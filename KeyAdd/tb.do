restart -f
delete wave *

view wave
add wave -color green -radix x a1
add wave -color green -radix x a2
add wave -color pink -radix x output

run 120

wave zoom full