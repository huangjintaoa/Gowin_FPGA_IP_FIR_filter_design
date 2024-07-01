
module fir_top (
    input               sclk                 ,
    input               s_rst	             ,
    

    output wire         sign_led            

);


//=================================================\
//******Define Parameter  and Internal Signal****
//=================================================\

//DDS
wire				clk_32M                							;
wire				clk_100M               							;
wire				s_rst_n											;				
wire [ 7:0]			cosine_sig_4M          							;	
wire				cosine_sig_valid_4M    							;			
wire				clk_50M                							;		
wire[ 7:0]			cosine_sig_3M          							;	
wire				cosine_sig_valid_3M    							;			


//multi                              
wire[18:0]			mix_cosine_sig                                  ;  
wire[18:0]			mix_cosine_sig_mx                               ;  

//fir filter
wire				fir_rfi_o                                     ;  
reg 				fir_valid_i                                   ;  
reg 				fir_sync_i                                    ;  
wire[18:0]			fir_data_i                                    ;  
wire				fir_valid_o                                   ;  
wire				fir_sync_o                                    ;  
wire[30:0]			fir_data_o                                    ;  

//delay
reg [15:0]			delay_cnt										;
wire				flag_delay_end									;

//PLL
wire				pll_lock										;

//===========================================\
//******************Main Code **********
//===========================================\



always @(posedge sclk or negedge s_rst_n) begin
	if(!s_rst_n)
		delay_cnt <= 'd0 ;
	else if(flag_delay_end ==1'b0  )
		delay_cnt	<= delay_cnt + 1'b1 	;

end

assign flag_delay_end	= (delay_cnt >= 500)? 1'b1: 1'b0 ;//延时停止标志位


    Gowin_PLL Gowin_PLL_inst (
        .lock		(pll_lock	), //output lock
        .clkout0	(clk_50M	), //output clkout0
        .clkout1	(clk_32M	), //output clkout1
		.clkout2	(clk_100M	), //output clkout1
        .clkin		(sclk		), //input clkin
        .reset		(s_rst		) //input reset
    );

assign	s_rst_n	=	(~s_rst) & (pll_lock) 		;//常态下处于高电平,按下去为低电平复位
//output    4M cos
	DDS_Top DDS_inst(
		.clk            (clk_100M               ), //input clk
		.rstn           (s_rst_n                ), //input rstn
		.wr             (1'b0                   ), //input wr
		.waddr          ('d0                    ), //input [15:0] waddr
		.wdata          ('d0                    ), //input [31:0] wdata
		.dout           (cosine_sig_4M          ), //output [7:0] dout
		.out_valid      (cosine_sig_valid_4M    ) //output out_valid
	);
// input    3M cos
	DDS_II_Top DDS_II_inst(
		.clk_i          (clk_100M                ), //input clk_i
		.rst_n_i        (s_rst_n                ), //input rst_n_i
		.cosine_o       (cosine_sig_3M          ), //output [7:0] sine_o
		// .sine_o	        (cosine_sig_3M          ),
		.data_valid_o   (cosine_sig_valid_3M    ) //output data_valid_o
	);
//3M_COSINE * 4M_COSINE= (3+4)=7M & (4-3)=1M 延时一周期出数据
	Complex_Multiplier_Top Complex_Multiplier_inst(
		.ce             (cosine_sig_valid_3M & cosine_sig_valid_4M              ), //input ce
		.clk            (sclk                                                   ), //input clk
		.reset          (~s_rst_n                                               ), //input reset
		.real1          (cosine_sig_4M                                          ), //input [7:0] real1
		.real2          (cosine_sig_3M                                          ), //input [7:0] real2
		.imag1          ('d0                                                    ), //input [7:0] imag1
		.imag2          ('d0                                                    ), //input [7:0] imag2
		.realo          (mix_cosine_sig                                         ), //output [18:0] realo
		.imago          (mix_cosine_sig_mx                                      ) //output [18:0] imago
	);
//FIR Filter :FC=8M
always @(posedge sclk or negedge s_rst_n) begin
	if(!s_rst_n)begin
		fir_valid_i <= 1'b0	;
		fir_sync_i	<= 1'b0 ;
	end
	else if(fir_rfi_o == 1'b1 && flag_delay_end== 1'b1)begin
		fir_valid_i	<= 1'b1 ;
		fir_sync_i	<= 1'b1 ;
	end
	else begin
		fir_valid_i <= 1'b0	;
		fir_sync_i	<= 1'b0 ;
	end

end
assign	fir_data_i	= (fir_sync_i)? mix_cosine_sig:		'd0			;
	Advanced_FIR_Filter_Top Advanced_FIR_Filter_inst(
		.clk            (sclk                                                 ), //input clk
		.rstn           (s_rst_n                                              ), //input rstn
		.fir_rfi_o      (fir_rfi_o                                            ), //output fir_rfi_o
		.fir_valid_i    (fir_valid_i                                          ), //input fir_valid_i
		.fir_sync_i     (fir_sync_i                                           ), //input fir_sync_i
		.fir_data_i     (fir_data_i                                           ), //input [18:0] fir_data_i
		.fir_valid_o    (fir_valid_o                                          ), //output fir_valid_o
		.fir_sync_o     (fir_sync_o                                           ), //output fir_sync_o
		.fir_data_o     (fir_data_o                                           ) //output [30:0] fir_data_o
	);

endmodule


