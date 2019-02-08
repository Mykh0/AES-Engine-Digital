restart -f
view wave
delete wave *

add wave -color white clk
add wave -color red nrst
add wave -color yellow start
add wave -color yellow decrypt 
add wave -color yellow key_length
add wave -radix x -color green engine_in
add wave -radix x -color green key
add wave -color yellow ready
add wave -radix x -color pink engine_out

wave zoom full

run 20000