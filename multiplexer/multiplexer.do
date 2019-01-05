restart -f
force clk 0, 1 5 ms -repeat 10 ms
run 100 ms
force reset '0'
run 100 ms
force reset '1'

run 1000ms
force buttons_0000000000 "1111"
force leds_0000000000 "1111101010"
force switches "0000000000"
run 1000ms
force buttons_1000000000 "1010"
force leds_1000000000 "1010101010"
force switches "1000000000"
run 1000ms
force buttons_0100000000 "1111"
force leds_0100000000 "1111101010"
force switches "0100000000"
run 1000ms
force buttons_0010000000 "1010"
force leds_0010000000 "1010101010"
force switches "0010000000"
run 1000ms
force buttons_0001000000 "1111"
force leds_0001000000 "1111101010"
force switches "0001000000"
run 1000ms
force buttons_0000100000 "1010"
force leds_0000100000 "1010101010"
force switches "0000100000"
run 1000ms
force buttons_0000010000 "1111"
force leds_0000010000 "1111101010"
force switches "0000010000"
run 1000ms
force buttons_0000001000 "1010"
force leds_0000001000 "1010101010"
force switches "0000001000"
run 1000ms
force buttons_0000000100 "1111"
force leds_0000000100 "1111101010"
force switches "0000000100"
run 1000ms
force buttons_0000000010 "1010"
force leds_0000000010 "1010101010"
force switches "0000000010"
run 1000ms
force buttons_0000000001 "1111"
force leds_0000000001 "1111101010"
force switches "0000000001"
run 1000ms

force reset '0'
run 100 ms
force reset '1'
run 1000ms
