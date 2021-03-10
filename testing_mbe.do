#refresh the work library
rm -rf work
vlib work


#compile the mbe
vcom -93 -work ./work ../src/multiplier/FF.vhd
vcom -93 -work ./work ../src/common/fpnormalize_fpnormalize.vhd
vcom -93 -work ./work ../src/common/fpround_fpround.vhd
vcom -93 -work ./work ../src/common/packfp_packfp.vhd
vcom -93 -work ./work ../src/common/unpackfp_unpackfp.vhd
vcom -93 -work ./work ../src/mbe/my_pkg.vhd
vcom -93 -work ./work ../src/mbe/partial_product_generator.vhd
vcom -93 -work ./work ../src/mbe/s_padder.vhd
vcom -93 -work ./work ../src/mbe/FA.vhd
vcom -93 -work ./work ../src/mbe/HA.vhd
vcom -93 -work ./work ../src/mbe/dadda_stage1.vhd
vcom -93 -work ./work ../src/mbe/dadda_stage2.vhd
vcom -93 -work ./work ../src/mbe/dadda_stage3.vhd
vcom -93 -work ./work ../src/mbe/dadda_stage4.vhd
vcom -93 -work ./work ../src/mbe/dadda_stage5.vhd
vcom -93 -work ./work ../src/mbe/dadda_stage6.vhd
vcom -93 -work ./work ../src/mbe/rca63.vhd
vcom -93 -work ./work ../src/mbe/dadda_tree.vhd
vcom -93 -work ./work ../src/mbe/mbe.vhd

#run the given source code
vlog -sv ../tb/top.sv
vsim top
run 4 us
