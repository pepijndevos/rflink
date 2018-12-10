%% Reset
clear all
close all
clc

%% Set Parameters audio
Fsample_audio = 31250;
Bits_per_Sample = 8;
SampleTime = 1/(Fsample_audio*Bits_per_Sample);% the sample time is dependent
% on the amount of bits which is why I am deviding by the amount of bits in parallel (if you do not believe me look at the sample time legend in simulink, I know it is a strange block)

%% Set Parameters preamble
PreambleIntervalBits = 4; % The interval is added every 2^PreambleIntervalBits-1
PreambleInterval = 2^PreambleIntervalBits-1;
Preamble = [0; 1; 1; 0; 1; 1; 1; 0; 0; 1];

%% Set Parameters upsampler
Upsample_Rate = 8;
SampleTimeUpsampler =  1/(Fsample_audio*10*Upsample_Rate);

%% Set Parameters filter
bt = 0.3;
span = 1;
sps = 2;
h = gaussdesign(bt,span,sps);
fvtool(h,'impulse')

%% Set parameters VCO
WavesPerBit = 4;
Quiescetf = Fsample_audio*10*WavesPerBit;       % Quiescet frequency (Hz)
InputSensitivity = Fsample_audio*10*WavesPerBit;% Input sensitivity (Hz/v)
DACSampleTime = 1/20000000;                     % Sample time (s)

%% Set parameters simulink model
Tsymbol = 1/(Fsample_audio);
Tsim=320*Tsymbol;
set_param('VCO', 'StopTime', 'Tsim');




