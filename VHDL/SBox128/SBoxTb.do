restart -f
view wave
delete wave *

add wave -radix x -color green s_in
add wave -radix x -color pink s_out

wave zoom full

run 40