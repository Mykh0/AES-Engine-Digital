onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level Signals}
add wave -noupdate /aes_engine/engine_ready
add wave -noupdate -radix hexadecimal /aes_engine/engine_out
add wave -noupdate -radix hexadecimal /aes_engine/engine_in
add wave -noupdate -radix hexadecimal /aes_engine/key
add wave -noupdate -divider {Control Signals}
add wave -noupdate /aes_engine/key_length
add wave -noupdate /aes_engine/start_engine
add wave -noupdate -divider {Other Signals}
add wave -noupdate /aes_engine/clk
add wave -noupdate /aes_engine/nrst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {840 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 323
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1784 ps}
