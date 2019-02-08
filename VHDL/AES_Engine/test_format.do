onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Engine Data}
add wave -noupdate /aes_engine/engine_in
add wave -noupdate /aes_engine/key
add wave -noupdate /aes_engine/engine_out
add wave -noupdate -divider {Engine Control}
add wave -noupdate /aes_engine/start
add wave -noupdate /aes_engine/decrypt
add wave -noupdate /aes_engine/key_length
add wave -noupdate /aes_engine/ready
add wave -noupdate -divider Other
add wave -noupdate /aes_engine/nrst
add wave -noupdate /aes_engine/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 366
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
WaveRestoreZoom {0 ps} {867 ps}
