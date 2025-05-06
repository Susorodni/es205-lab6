clc; clear variables; close all;
% Task 2

% Load Data
X = readtable('WahHigh.csv','NumHeaderLines', 4);
t_h = X.Var1; V1_h = X.Var2; Vout_h = X.Var4;

% High Range
[f_h_1,FRF_h] = FRFSpectrum(t_h,V1_h,Vout_h,'false',175);  % function outputs FRF as complex numbers forand frequencies for those outputs
mag_h = abs(FRF_h);  MdB_h = 20*log(mag_h); % use FRF output to find magnitude in dB
phase_h = unwrap(angle(FRF_h))*180/pi; % find angle in radians

set(gcf,'Position',[50 50 1300 750])
set(gcf, 'color', 'w')
subplot(211)             %  Create a subplot figure
semilogx(f_h_1*2*pi,MdB_h)          %  Bode magnitude plot
hold on
grid on
xlabel('Frequency (rad/s)')
ylabel('Magnitude (dB)')
title('High Range')
