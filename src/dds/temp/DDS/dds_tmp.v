//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9
//Part Number: GW5A-LV25MG121NES
//Device: GW5A-25
//Device Version: A
//Created Time: Sat Jun  8 19:02:11 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	DDS_Top your_instance_name(
		.clk(clk_i), //input clk
		.rstn(rstn_i), //input rstn
		.wr(wr_i), //input wr
		.waddr(waddr_i), //input [15:0] waddr
		.wdata(wdata_i), //input [31:0] wdata
		.dout(dout_o), //output [7:0] dout
		.out_valid(out_valid_o) //output out_valid
	);

//--------Copy end-------------------
