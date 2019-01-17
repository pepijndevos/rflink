# rflink

Full source code: https://github.com/pepijndevos/rflink

In the transceiver folder there are various versions of the Quartus top-level entity of the receiver and transmitter.
Increasing version numbers include increasingly many components, ranging from V1 containing just the audio codec, and V8 containing the full transceiver with all systems. The Quartus project folders do not contain copies of the source code. All the source code is shared from their common subdirectories, which also contains Modelsim projects and testbenches for each individual component.

* codec contains the driver for the FPGA audio interface.
* encoding contains the 8b10b encoding algorithm
* framing contains the preamble insertion/detection code
* p_2_s and s_2_p contains code to serialise/buffer bytes to and from bits.
* fir contains the pule-shaping filter
* clock_recovery contains, well, clock recovery
* modulation contains both the NCO and the demodulator
* dac and adc contain the RF-side analog interface
