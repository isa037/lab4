onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/in/clk
add wave -noupdate -radix binary /top/sum/fpmul_under_test/FPMULTIPLIER/MULT/FP_A
add wave -noupdate -radix binary /top/sum/fpmul_under_test/FPMULTIPLIER/MULT/FP_B
add wave -noupdate -radix hexadecimal /top/sum/fpmul_under_test/FPMULTIPLIER/MULT/FP_Z
add wave -noupdate /top/sum/fpmul_under_test/FPMULTIPLIER/MULT/I4/isZ
add wave -noupdate -radix binary /top/sum/fpmul_under_test/FPMULTIPLIER/MULT/I4/SIG_out
add wave -noupdate /top/sum/fpmul_under_test/FPMULTIPLIER/MULT/I4/SIG_isZ
add wave -noupdate /top/sum/fpmul_under_test/FPMULTIPLIER/MULT/I4/EXP_neg
add wave -noupdate -radix binary /top/sum/fpmul_under_test/FPMULTIPLIER/MULT/I4/EXP_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {155 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 112
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {162 ns}
