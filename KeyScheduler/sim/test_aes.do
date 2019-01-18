restart -f

force clk 0 0, 1 25 -r 50
force nrst 1
force start 1
force Key_Length "00"
force Key 16#2b7e151628aed2a6abf7158809cf4f3c
#force Key 16#000102030405060708090a0b0c0d0e0f

run 1000

force start 0
force Key_Length "01"
force Key 16#8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b

run 100

force start 1

run 1000

force start 0
force Key_Length "10"
force Key 16#603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4

run 100

force start 1

run 1000