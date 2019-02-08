restart -f
view wave
delete wave *

add wave -radix x -color green AES_Core_In
add wave -radix x -color green ki_in
add wave -radix x -color yellow keyAdd_only
add wave -radix x -color yellow last_round 
add wave -radix x -color yellow decrypt
add wave -radix x -color pink engine_out    

wave zoom full

run 200