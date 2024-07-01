tb_file:=		../../tb/DDS_tb.v								


vcs:
	vcs -debug_all -R -full64 -fsdb -sverilog 			\
	-v ../../tb/prim_sim.v 			            		\
	$(tb_file)											\
	../../dds.vo										\
	+vcs+initreg+random									\
	+vcs+initreg+0  								    \
    +incdir+../../temp/DDS/ 							\
	-cm line+cond+fsm+branch+tgl

vd:
	verdi -sverilog										\
	-v ../../tb/prim_sim.v 								\
	$(tb_file)											\
	../../dds.vo										\
	-ssf verilog.fsdb									\
	+incdir+../../temp/DDS/							    \
	&
reVd:
	./repair.sh tb
	verdi -ssr wave.ses &
#----------------------------------------------------------------------------------------------------
# Rule to clean temp files
#----------------------------------------------------------------------------------------------------
clean:
	rm -rf csrc simv.daidir simv.vdb verdiLog cm.log novas.conf novas.rc novas_dump.log simv verilog.fsdb ucli.key wave.ses.png 	./repair.sh tb dout.txt
