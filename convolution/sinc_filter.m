low_low_f = 1150000;
low_high_f = 1350000;

high_low_f = 2400000;
high_high_f = 2600000;

filter_factor=1024;

x = linspace(-5,5,50);
y = 2*low_high_f*sinc(2*low_high_f*x)-2*low_low_f*sinc(2*low_low_f*x);

fprintf("LOW FREQUENCY\n");
for i = 1:20
    fprintf ('%d => \"%s\",\n', i-1, dec2bin(typecast(int16(filter_factor*y(i)),'uint16'),10));
end

y = 2*high_high_f*sinc(2*high_high_f*x)-2*high_low_f*sinc(2*high_low_f*x);

fprintf("HIGH FREQUENCY\n");
for i = 1:20
    fprintf ('%d => \"%s\",\n', i-1, dec2bin(typecast(int16(filter_factor*y(i)),'uint16'),10));
end