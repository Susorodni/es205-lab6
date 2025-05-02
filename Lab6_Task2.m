clc; clear variables; close all;
% Task 2

% Load Data
X = readtable('WahHigh.csv','NumHeaderLines', 4);
t_h = X.Var1; V1_h = X.Var2; Vout_h = X.Var4;
plot(t_h,V1_h,t_h,Vout_h)

X = readtable('WahLow.csv','NumHeaderLines', 4);
t_l = X.Var1; V1_l = X.Var2; Vout_l = X.Var4;

X = readtable('WahMid.csv','NumHeaderLines', 4);
t_m1 = X.Var1; V1_m1 = X.Var2; Vout_m1 = X.Var4;

X = readtable('WahMid2.csv','NumHeaderLines', 4);
t_m2 = X.Var1; V1_m2 = X.Var2; Vout_m2 = X.Var4;

X = readtable('WahMid3.csv','NumHeaderLines', 4);
t_m3 = X.Var1; V1_m3 = X.Var2; Vout_m3 = X.Var4;

X = readtable('WahMid4.csv','NumHeaderLines', 4);
t_m4 = X.Var1; V1_m4 = X.Var2; Vout_m4 = X.Var4;

% Task 3

[f_h,FRF_h] = FRFSpectrum(t_h,V1_h,Vout_h,'false',175);  % function outputs FRF as complex numbers forand frequencies for those outputs
mag_h = abs(FRF_h);  MdB_h = 20*log(mag_h); % use FRF output to find magnitude in dB
phase_h = unwrap(angle(FRF_h))*180/pi; % find angle in radians

set(gcf,'Position',[50 50 1300 750])
set(gcf, 'color', 'w')
subplot(211)             %  Create a subplot figure
semilogx(f_h,MdB_h)          %  Bode magnitude plot
hold on
grid on
xlabel('Frequency (rad/s)')
ylabel('Magnitude (dB)')

subplot(212)
semilogx(f_h,phase_h)     %  Bode phase plot
hold on
grid on
xlabel('Frequency (rad/s)')
ylabel('Phase (deg)')	

