%% set up
clear all;
clc;
close all;

%% Load data
% csv files: in s,C1 in V,C2 in V
WithFilter = load('FSK Filter Enabled.CSV');
WithoutFilter = load('FSK Filter Disabled.CSV');
 
%% Make Parameters
FFTWithFilter = fft(WithFilter(1:end,2));
TWith = (WithFilter(end:end,1)-WithFilter(1:1,1))/length(WithFilter(1:end,1));
FsWith = 1/TWith;
LWith = length(WithFilter(1:end,1));
fWith = FsWith*(0:(LWith-1))/LWith;

FFTWithoutFilter = fft(WithoutFilter(1:end,2));
TWithout = (WithoutFilter(end:end,1)-WithoutFilter(1:1,1))/length(WithoutFilter(1:end,1));
FsWithout = 1/TWithout;
LWithout = length(WithoutFilter(1:end,1));
fWithout = FsWithout*(0:(LWithout-1))/LWithout;
%% Plot figures
figure(1); clf;
hold on
plot(WithFilter(1:end,1),WithFilter(1:end,2))
plot(WithFilter(1:end,1),WithFilter(1:end,3))
xlabel('time (s)')
ylabel('voltage in (V)')
title('FSK with filter enabled')
legend('channel 1', 'channel 2')

figure(2); clf;
hold on
plot(WithoutFilter(1:end,1),WithoutFilter(1:end,2))
plot(WithoutFilter(1:end,1),WithoutFilter(1:end,3))
xlabel('time (s)')
ylabel('voltage in (V)')
title('FSK with filter enabled')
legend('channel 1', 'channel 2')

figure(3); clf;
subplot(2,1,1);
plot((fWithout/1e6),10*log10(abs(FFTWithoutFilter)))
xlim([0 (50)])
ylim([-20 20])
xlabel('Freq (MHz)')
ylabel('Magnitude (dB)')
title('FSK with filter disabled')
subplot(2,1,2);
hold on
plot((fWith/1e6),10*log10(abs(FFTWithFilter)))
xlim([0 (50)])
ylim([-20 20])
xlabel('Freq (MHz)')
ylabel('Magnitude (dB)')
title('FSK with filter enabled')

