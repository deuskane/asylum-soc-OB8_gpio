p.addPad('clk_i'        ,{'location':'IOB12_D09P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('arst_i'       ,{'location':'IOB10_D12N', 'standard' : 'LVCMOS', 'drive' : '2mA'})

p.addPad('switch_i[0]'  ,{'location':'IOB10_D09P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[1]'  ,{'location':'IOB10_D03P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[2]'  ,{'location':'IOB10_D03N', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[3]'  ,{'location':'IOB10_D04P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[4]'  ,{'location':'IOB10_D09N', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[5]'  ,{'location':'IOB10_D04N', 'standard' : 'LVCMOS', 'drive' : '2mA'})

p.addPad('led_o[0]'     ,{'location':'IOB0_D01P' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[1]'     ,{'location':'IOB0_D03N' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[2]'     ,{'location':'IOB0_D03P' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[3]'     ,{'location':'IOB1_D05N' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[4]'     ,{'location':'IOB1_D05P' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[5]'     ,{'location':'IOB1_D06N' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[6]'     ,{'location':'IOB1_D06P' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[7]'     ,{'location':'IOB1_D02N' , 'standard' : 'LVCMOS', 'drive' : '2mA'})

p.addBank('IOB0' ,{'voltage' : '3.3'})
p.addBank('IOB1' ,{'voltage' : '3.3'})
p.addBank('IOB10',{'voltage' : '1.8'})
p.addBank('IOB12',{'voltage' : '2.5'})
