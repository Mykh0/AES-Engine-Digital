restart -f
delete wave *

view wave
add wave -color white -radix x clk
add wave -color red -radix x nrst
add wave -color yellow -radix x start
add wave -color blue -radix x Key_Length
add wave -color orange -radix x Decrypt
add wave -color green -radix x Key
add wave -color pink -radix x Key_I

run 5000

wave zoom full