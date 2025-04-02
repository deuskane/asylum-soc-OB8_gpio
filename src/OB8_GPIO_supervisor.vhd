-------------------------------------------------------------------------------
-- Title      : OB8_GPIO_supervisor
-- Project    : 
-------------------------------------------------------------------------------
-- File       : OB8_GPIO_supervisor.vhd
-- Author     : Mathieu Rosiere
-- Company    : 
-- Created    : 2017-03-30
-- Last update: 2025-04-02
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author   Description
-- 2025-01-01  1.0      mrosiere Created
-- 2025-04-02  1.1      mrosiere Add ICN
-------------------------------------------------------------------------------

library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library work;
use     work.pbi_pkg.all;
use     work.GPIO_csr_pkg.all;

entity OB8_GPIO_supervisor is
  generic (
    NB_LED0        : positive := 8;
    NB_LED1        : positive := 8
    );
  port (
    clk_i      : in  std_logic;
    arst_b_i   : in  std_logic;

    led0_o     : out std_logic_vector(NB_LED0  -1 downto 0);
    led1_o     : out std_logic_vector(NB_LED1  -1 downto 0);

    diff_i     : in  std_logic_vector(        3-1 downto 0)
);
end OB8_GPIO_supervisor;

architecture rtl of OB8_GPIO_supervisor is
  -- Constant declaration
  constant CST0                       : std_logic_vector (8-1 downto 0) := (others => '0');
  constant CST1                       : std_logic_vector (8-1 downto 0) := (others => '1');

  -- ICN Configuration

  constant NB_TARGET                  : positive := 4;

  constant TARGET_LED0                : integer  := 0;
  constant TARGET_LED1                : integer  := 1;
  constant TARGET_IT_VECTOR_MASK      : integer  := 2;
  constant TARGET_IT_VECTOR           : integer  := 3;

  constant TARGET_ID                  : pbi_addrs_t   (NB_TARGET-1 downto 0) :=
    ( TARGET_LED0                     => "00000000",
      TARGET_LED1                     => "00000100",
      TARGET_IT_VECTOR_MASK           => "00001000",
      TARGET_IT_VECTOR                => "00001100" 
      );

  constant TARGET_ADDR_WIDTH          : pbi_naturals_t(NB_TARGET-1 downto 0) :=
    ( TARGET_LED0                     => GPIO_ADDR_WIDTH,
      TARGET_LED1                     => GPIO_ADDR_WIDTH,
      TARGET_IT_VECTOR_MASK           => GPIO_ADDR_WIDTH,
      TARGET_IT_VECTOR                => GPIO_ADDR_WIDTH
      );
      
  -- Signals Clock/Reset
  signal clk                          : std_logic;
  signal arst_b                       : std_logic;
  
  -- Signals CPUs
  signal cpu_iaddr                    : std_logic_vector(10-1 downto 0);
  signal cpu_idata                    : std_logic_vector(17 downto 0);
  signal cpu_pbi_ini                  : pbi_ini_t(addr (PBI_ADDR_WIDTH-1 downto 0),
                                                  wdata(PBI_DATA_WIDTH-1 downto 0));
  signal cpu_pbi_tgt                  : pbi_tgt_t(rdata(PBI_DATA_WIDTH-1 downto 0));

  signal cpu_it_val                   : std_logic;
  signal cpu_it_ack                   : std_logic;

  -- Signals ICN
  signal icn_pbi_inis                 : pbi_inis_t(NB_TARGET-1 downto 0)(addr (PBI_ADDR_WIDTH-1 downto 0),
                                                                         wdata(PBI_DATA_WIDTH-1 downto 0));
  signal icn_pbi_tgts                 : pbi_tgts_t(NB_TARGET-1 downto 0)(rdata(PBI_DATA_WIDTH-1 downto 0));
  
  signal led0                         : std_logic_vector(NB_LED0-1 downto 0);
  signal led1                         : std_logic_vector(NB_LED1-1 downto 0);

  signal diff_mask                    : std_logic_vector(      3-1 downto 0);
  
begin  -- architecture rtl

  -- Clock & Reset
  clk    <= clk_i;
  arst_b <= arst_b_i;
  
  ins_pbi_OpenBlaze8_0 : entity work.pbi_OpenBlaze8(rtl)
  port map (
    clk_i            => clk      ,
    cke_i            => '1'      ,
    arstn_i          => arst_b   ,
    iaddr_o          => cpu_iaddr,
    idata_i          => cpu_idata,
    pbi_ini_o        => cpu_pbi_ini  ,
    pbi_tgt_i        => cpu_pbi_tgt  ,
    interrupt_i      => cpu_it_val   ,
    interrupt_ack_o  => open
    );

  ins_pbi_icn : entity work.pbi_icn(rtl)
    generic map (
      NB_TARGET         => NB_TARGET,
      TARGET_ID         => TARGET_ID,
      TARGET_ADDR_WIDTH => TARGET_ADDR_WIDTH
      )
    port map (
      clk_i            => clk        ,
      cke_i            => '1'        ,
      arst_b_i         => arst_b     ,
      pbi_ini_i        => cpu_pbi_ini    ,
      pbi_tgt_o        => cpu_pbi_tgt    ,
      pbi_inis_o       => icn_pbi_inis   ,
      pbi_tgts_i       => icn_pbi_tgts
    );

  ins_pbi_OpenBlaze8_ROM : entity work.ROM_supervisor(rom)
    port map (
      clk_i            => clk      ,
      cke_i            => '1'      ,
      address_i        => cpu_iaddr,
      instruction_o    => cpu_idata  
    );

  ins_pbi_led0 : entity work.pbi_GPIO(rtl)
    generic map(
    NB_IO            => NB_LED0,
    DATA_OE_INIT     => CST1(NB_LED0-1 downto 0),
    DATA_OE_FORCE    => CST1(NB_LED0-1 downto 0),
    IT_ENABLE        => false
    )
  port map  (
    clk_i            => clk         ,
    cke_i            => '1'         ,
    arstn_i          => arst_b      ,
    pbi_ini_i        => icn_pbi_inis(TARGET_LED0),
    pbi_tgt_o        => icn_pbi_tgts(TARGET_LED0),
    data_i           => CST0(NB_LED0-1 downto 0),
    data_o           => led0        ,
    data_oe_o        => open        ,
    interrupt_o      => open        ,
    interrupt_ack_i  => '0'
    );

  ins_pbi_led1 : entity work.pbi_GPIO(rtl)
    generic map(
    NB_IO            => NB_LED1,
    DATA_OE_INIT     => CST1(NB_LED1-1 downto 0),
    DATA_OE_FORCE    => CST1(NB_LED1-1 downto 0),
    IT_ENABLE        => false
    )
  port map  (
    clk_i            => clk         ,
    cke_i            => '1'         ,
    arstn_i          => arst_b      ,
    pbi_ini_i        => icn_pbi_inis(TARGET_LED1),
    pbi_tgt_o        => icn_pbi_tgts(TARGET_LED1),
    data_i           => CST0(NB_LED1-1 downto 0),
    data_o           => led1        ,
    data_oe_o        => open        ,
    interrupt_o      => open        ,
    interrupt_ack_i  => '0'
    );

  ins_pbi_it_vector_mask : entity work.pbi_GPIO(rtl)
    generic map(
    NB_IO            => 3,
    DATA_OE_INIT     => CST1(3-1 downto 0),
    DATA_OE_FORCE    => CST1(3-1 downto 0),
    IT_ENABLE        => false
    )
  port map  (
    clk_i            => clk         ,
    cke_i            => '1'         ,
    arstn_i          => arst_b      ,
    pbi_ini_i        => icn_pbi_inis(TARGET_IT_VECTOR_MASK),
    pbi_tgt_o        => icn_pbi_tgts(TARGET_IT_VECTOR_MASK),
    data_i           => CST0(3-1 downto 0),
    data_o           => diff_mask   ,
    data_oe_o        => open        ,
    interrupt_o      => open        ,
    interrupt_ack_i  => '0'
    );

  ins_pbi_it_vector : entity work.pbi_GPIO(rtl)
    generic map(
    NB_IO            => 3,
    DATA_OE_INIT     => CST0(3-1 downto 0),
    DATA_OE_FORCE    => CST1(3-1 downto 0),
    IT_ENABLE        => false
    )
  port map  (
    clk_i            => clk         ,
    cke_i            => '1'         ,
    arstn_i          => arst_b      ,
    pbi_ini_i        => icn_pbi_inis(TARGET_IT_VECTOR),
    pbi_tgt_o        => icn_pbi_tgts(TARGET_IT_VECTOR),
    data_i           => diff_i      ,
    data_o           => open        ,
    data_oe_o        => open        ,
    interrupt_o      => open        ,
    interrupt_ack_i  => '0'
    );

  led0_o <= led0;
  led1_o <= led1;

  cpu_it_val <= ((diff_i(0) and diff_mask(0)) or
                 (diff_i(1) and diff_mask(1)) or
                 (diff_i(2) and diff_mask(2)));
  
end architecture rtl;
    
  
