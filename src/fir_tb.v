//=========================================\
//*TOP
//*
//=========================================\
`timescale 1ns/1ns
module tb_dds_fir ();

reg	clk ;
reg s_rst;

   initial begin
      clk = 0; //50MHz
      s_rst = 1 ;
      #10 s_rst = 0;
    //   #20 rstn = 1;
   end

GSR GSR(.GSRI(1'b1));

always #10 clk <= ~ clk ;	//产生50MHz时钟

fir_top fir_top_inst(
    .sclk        (clk )      ,
    .s_rst	      (s_rst)   	,
    

    .sign_led    ()    

);

endmodule
