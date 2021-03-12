#refresh the work library
rm -rf work
vlib work

#run the given source code
vlog -sv ../tb/top.sv
vsim top
run 4 us
