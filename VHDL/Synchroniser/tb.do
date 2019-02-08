restart -f
view wave
delete wave *

add wave -color white clk
add wave -color red nrst
add wave -color yellow start_engine
add wave -color yellow key_l
add wave -radix x -color pink engine_ready
add wave -radix x -color pink start_core
add wave -radix x -color pink start_scheduler

wave zoom full

run 5000