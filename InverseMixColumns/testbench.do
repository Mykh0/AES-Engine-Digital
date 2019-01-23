restart -f
view wave
delete wave *

add wave -radix x -color green RawData
add wave -radix x -color pink Encrypted

wave zoom full

run 200