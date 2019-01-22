restart -f

force clk 1 0, 0 10 -r 20
force nrst 0

run 25
force nrst 1
force key 16#000102030405060708090a0b0c0d0e0f

force engine_in 16#00112233445566778899aabbccddeeff

###128 ENCRYPTION TEST###
force key_length 00
run 75
force start_engine 1
run 20
force start_engine 0

run 700

###192 ENCRYPTION TEST###
force key 16#000102030405060708090a0b0c0d0e0f1011121314151617
force key_length "01"
run 20

force start_engine 1
run 20
force start_engine 0

run 1000

###256 ENCRYPTION TEST###
force key 16#000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f
force key_length "10"
run 20

force start_engine 1
run 20
force start_engine 0


run 1500


