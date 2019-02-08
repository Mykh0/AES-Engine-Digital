restart -f
view wave
delete wave *

add wave -color white clk
add wave -color red nrst
add wave -color green SerialIn
add wave -radix x -color pink ParallelOut

view wave
wave zoom full

run 1000000