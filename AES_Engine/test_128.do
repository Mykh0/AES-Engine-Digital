restart -f

force clk 0 0, 1 10 -r 20
force nrst 0
force start 0
force key_length 00
force decrypt 0
force engine_in 16#00000000000000000000000000000000
force key 16#00000000000000000000000000000000

run 20

force nrst 1

force engine_in 16#00112233445566778899aabbccddeeff
force key 16#000102030405060708090a0b0c0d0e0f

run 10

force start 1

run 20

force start 0

run 1000

force engine_in 16#69c4e0d86a7b0430d8cdb78070b4c55a
force key 16#000102030405060708090a0b0c0d0e0f
force decrypt 1

run 10

force start 1

run 20

force start 0

run 1000


