restart -f
view wave
delete wave *

add wave -radix x -color green data_in
add wave -radix x -color pink data_out

wave zoom full

run 200