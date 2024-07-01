//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9
//Part Number: GW5A-LV25MG121NES
//Device: GW5A-25
//Device Version: A
//Created Time: Sat Jun  8 20:52:39 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	DDS_II_Top your_instance_name(
		.clk_i(clk_i_i), //input clk_i
		.rst_n_i(rst_n_i_i), //input rst_n_i
		.cosine_o(cosine_o_o), //output [7:0] cosine_o
		.data_valid_o(data_valid_o_o) //output data_valid_o
	);

//--------Copy end-------------------
