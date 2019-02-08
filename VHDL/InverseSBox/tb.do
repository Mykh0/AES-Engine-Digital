restart -f
delete wave *

view wave
add wave -color green -radix x data_in
add wave -color pink -radix x data_out

run 12000

wave zoom full