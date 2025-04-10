p.addPad('clk_i'             ,{'location':'IOB12_D09P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('arst_i'            ,{'location':'IOB10_D12N', 'standard' : 'LVCMOS', 'drive' : '2mA'})
                             
p.addPad('switch_i[0]'       ,{'location':'IOB10_D04P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[1]'       ,{'location':'IOB10_D03N', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[2]'       ,{'location':'IOB10_D03P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[3]'       ,{'location':'IOB10_D09P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[4]'       ,{'location':'IOB10_D04N', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('switch_i[5]'       ,{'location':'IOB10_D09N', 'standard' : 'LVCMOS', 'drive' : '2mA'})
                             
p.addPad('led_o[0]'          ,{'location':'IOB0_D01P' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[1]'          ,{'location':'IOB0_D03N' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[2]'          ,{'location':'IOB0_D03P' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[3]'          ,{'location':'IOB1_D05N' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[4]'          ,{'location':'IOB1_D05P' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[5]'          ,{'location':'IOB1_D06N' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[6]'          ,{'location':'IOB1_D06P' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[7]'          ,{'location':'IOB1_D02N' , 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('led_o[8]'          ,{'location':'USER_D0'   }) # USER_* have predefined parameters
p.addPad('led_o[9]'          ,{'location':'USER_D1'   }) # USER_* have predefined parameters
p.addPad('led_o[10]'         ,{'location':'USER_D2'   }) # USER_* have predefined parameters
p.addPad('led_o[11]'         ,{'location':'USER_D3'   }) # USER_* have predefined parameters
p.addPad('led_o[12]'         ,{'location':'USER_D4'   }) # USER_* have predefined parameters
p.addPad('led_o[13]'         ,{'location':'USER_D5'   }) # USER_* have predefined parameters
p.addPad('led_o[14]'         ,{'location':'USER_D6'   }) # USER_* have predefined parameters
p.addPad('led_o[15]'         ,{'location':'USER_D7'   }) # USER_* have predefined parameters
p.addPad('led_o[16]'         ,{'location':'USER_D8'   }) # USER_* have predefined parameters
p.addPad('led_o[17]'         ,{'location':'USER_D9'   }) # USER_* have predefined parameters
p.addPad('led_o[18]'         ,{'location':'USER_D10'  }) # USER_* have predefined parameters
                             
p.addPad('it_user_i'         ,{'location':'IOB10_D14P', 'standard' : 'LVCMOS', 'drive' : '2mA'})

p.addPad('inject_error_i[0]' ,{'location':'IOB10_D07P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('inject_error_i[1]' ,{'location':'IOB10_D12P', 'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('inject_error_i[2]' ,{'location':'IOB10_D07N', 'standard' : 'LVCMOS', 'drive' : '2mA'})

p.addPad('uart_tx_o'         ,{'location':'IOB5_D03N',  'standard' : 'LVCMOS', 'drive' : '2mA'})
p.addPad('uart_rx_i'         ,{'location':'IOB5_D03P',  'standard' : 'LVCMOS', 'drive' : '2mA'})

p.addBank('IOB0' ,{'voltage' : '3.3'})
p.addBank('IOB1' ,{'voltage' : '3.3'})
p.addBank('IOB5' ,{'voltage' : '3.3'})
p.addBank('IOB10',{'voltage' : '1.8'})
p.addBank('IOB12',{'voltage' : '2.5'})
