restart -f

force clk 1 0, 0 10 -r 20
force nrst 0

run 25
force nrst 1


###128 ENCRYPTION TEST###
force key 16#2b7e151628aed2a6abf7158809cf4f3c

force engine_in 16#6bc1bee22e409f96e93d7e117393172a


force key_length 00
run 75
force start_engine 1
run 20
force start_engine 0

run 700

###128 ENCRYPTION TEST###
force key 16#2b7e151628aed2a6abf7158809cf4f3c

force engine_in 16#ae2d8a571e03ac9c9eb76fac45af8e51


force key_length 00
run 75
force start_engine 1
run 20
force start_engine 0

run 700

###128 ENCRYPTION TEST###
force key 16#2b7e151628aed2a6abf7158809cf4f3c

force engine_in 16#30c81c46a35ce411e5fbc1191a0a52ef


force key_length 00
run 75
force start_engine 1
run 20
force start_engine 0

run 700

###128 ENCRYPTION TEST###
force key 16#2b7e151628aed2a6abf7158809cf4f3c

force engine_in 16#f69f2445df4f9b17ad2b417be66c3710


force key_length 00
run 75
force start_engine 1
run 20
force start_engine 0

run 700

###196 ENCRYPTION TEST###
force key 16#8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b

force engine_in 16#6bc1bee22e409f96e93d7e117393172a


force key_length 01
run 75
force start_engine 1
run 20
force start_engine 0

run 900

###196 ENCRYPTION TEST###
force key 16#8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b

force engine_in 16#ae2d8a571e03ac9c9eb76fac45af8e51


force key_length 01
run 75
force start_engine 1
run 20
force start_engine 0

run 900

###196 ENCRYPTION TEST###
force key 16#8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b

force engine_in 16#30c81c46a35ce411e5fbc1191a0a52ef


force key_length 01
run 75
force start_engine 1
run 20
force start_engine 0

run 900

###196 ENCRYPTION TEST###
force key 16#8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b

force engine_in 16#f69f2445df4f9b17ad2b417be66c3710


force key_length 01
run 75
force start_engine 1
run 20
force start_engine 0

run 900

###256 ENCRYPTION TEST###
force key 16#603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4

force engine_in 16#6bc1bee22e409f96e93d7e117393172a


force key_length 10
run 75
force start_engine 1
run 20
force start_engine 0

run 1100

###256 ENCRYPTION TEST###
force key 16#603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4

force engine_in 16#ae2d8a571e03ac9c9eb76fac45af8e51


force key_length 10
run 75
force start_engine 1
run 20
force start_engine 0

run 1100

###256 ENCRYPTION TEST###
force key 16#603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4

force engine_in 16#ae2d8a571e03ac9c9eb76fac45af8e51


force key_length 10
run 75
force start_engine 1
run 20
force start_engine 0

run 1100

###256 ENCRYPTION TEST###
force key 16#603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4

force engine_in 16#30c81c46a35ce411e5fbc1191a0a52ef

force key_length 10
run 75
force start_engine 1
run 20
force start_engine 0

run 1100

###256 ENCRYPTION TEST###
force key 16#603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4

force engine_in 16#f69f2445df4f9b17ad2b417be66c3710

force key_length 10
run 75
force start_engine 1
run 20
force start_engine 0

run 1100