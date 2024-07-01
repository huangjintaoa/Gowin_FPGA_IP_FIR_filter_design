//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9
//Part Number: GW5A-LV25MG121NES
//Device: GW5A-25
//Device Version: A
//Created Time: Wed Jun  5 21:46:47 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Complex_Multiplier_Top your_instance_name(
		.ce(ce_i), //input ce
		.clk(clk_i), //input clk
		.reset(reset_i), //input reset
		.real1(real1_i), //input [7:0] real1
		.real2(real2_i), //input [7:0] real2
		.imag1(imag1_i), //input [7:0] imag1
		.imag2(imag2_i), //input [7:0] imag2
		.realo(realo_o), //output [18:0] realo
		.imago(imago_o) //output [18:0] imago
	);

//--------Copy end-------------------
