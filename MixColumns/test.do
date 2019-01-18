restart -f
delete wave *

view wave
add wave -color green -radix x rawdata
add wave -color pink -radix x encrypted

run 1000

wave zoom full