clc; clear variables; close all;
%% Task 2

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

%% Task 3

% High Range
[f_h_1,FRF_h] = FRFSpectrum(t_h,V1_h,Vout_h,'false',175);  % function outputs FRF as complex numbers forand frequencies for those outputs
mag_h = abs(FRF_h);  MdB_h = 20*log(mag_h); % use FRF output to find magnitude in dB

figure
set(gcf,'Position',[50 50 1300 750])
set(gcf, 'color', 'w')
plot(f_h,MdB_h)          %  Bode magnitude plot
hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('High Range')


% Low Range
[f_l,FRF_l] = FRFSpectrum(t_l,V1_l,Vout_l,'false',175);  % function outputs FRF as complex numbers forand frequencies for those outputs
mag_l = abs(FRF_l);  MdB_l = 20*log(mag_l); % use FRF output to find magnitude in dB

figure
set(gcf,'Position',[50 50 1300 750])
set(gcf, 'color', 'w')
plot(f_l,MdB_l)          %  Bode magnitude plot
hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Low Range')


% Mid Range 2
[f_m2,FRF_m2] = FRFSpectrum(t_m2,V1_m2,Vout_m2,'false',175);  % function outputs FRF as complex numbers forand frequencies for those outputs
mag_m2 = abs(FRF_m2);  MdB_m2 = 20*log(mag_m2); % use FRF output to find magnitude in dB

figure
set(gcf,'Position',[50 50 1300 750])
set(gcf, 'color', 'w')
plot(f_m2,MdB_m2)          %  Bode magnitude plot
hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Mid Range 2')


%% Task 4

s_h = 1j*f_h*2*pi;
s_l = 1j*f_l;
s_m2 = 1j*f_m2;

R = 80e3;
C = 10e-9;

Rp_guess = 10000;
Rp_h = fminsearch(@(Rp) Error_Mag(s_h,Rp,mag_h,C,R),Rp_guess);

Giw = -C*R*(Rp_h+100)*s_h./( (C^2)*(R^2)*(Rp_h+100)*s_h.^2 + C*R*(Rp_h+100)*s_h +(R+Rp_h+100)/2 );
magGiw = abs(Giw); MdB = 20*log(magGiw);

figure(4)
hold on
set(gcf,'Position',[50 50 1300 750])
set(gcf, 'color', 'w')
plot(f_h,MdB)          %  Bode magnitude plot
hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')

% %%
% % %Lab6_task4
% 
% w_1 = f_h_1*(2*pi);  %  Define the frequency range
% w_2 = f_h_2*(2*pi);
% w_3 = f_h_3*(2*pi);
% 
% s_1 = 1j*w_1;
% s_2 = 1j*w_2;
% s_3 = 1j*w_3;
% 
% 
% R = 80e3;
% C = 10e-9;
% 
% Giw_1 = -C*R*(Rp+100)*s_1./( (C^2)*(R^2)*(Rp+100)*s_1.^2 + C*R*(Rp+100)*s_1 +(R+Rp+100)/2 );       
% Giw_2 = -C*R*(Rp+100)*s_2./( (C^2)*(R^2)*(Rp+100)*s_2.^2 + C*R*(Rp+100)*s_2 +(R+Rp+100)/2 );       
% Giw_3 = -C*R*(Rp+100)*s_3./( (C^2)*(R^2)*(Rp+100)*s_3.^2 + C*R*(Rp+100)*s_3 +(R+Rp+100)/2 );       
% 


Rp_l = fminsearch(@(Rp) Error_Mag(s_l,Rp,mag_l,C,R),Rp_guess);

Giw = -C*R*(Rp_l+100)*s_l./( (C^2)*(R^2)*(Rp_l+100)*s_l.^2 + C*R*(Rp_l+100)*s_l +(R+Rp_l+100)/2 );
magGiw = abs(Giw); MdB = 20*log(magGiw);

figure(7)
hold on
set(gcf,'Position',[50 50 1300 750])
set(gcf, 'color', 'w')
plot(f_l,MdB)          %  Bode magnitude plot
hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')


Rp_guess = 10000;
Rp_m2 = fminsearch(@(Rp) Error_Mag(s_m2,Rp,mag_m2,C,R),Rp_guess);

Giw = -C*R*(Rp_m2+100)*s_m2./( (C^2)*(R^2)*(Rp_m2+100)*s_m2.^2 + C*R*(Rp_m2+100)*s_m2 +(R+Rp_m2+100)/2 );
magGiw = abs(Giw); MdB = 20*log(magGiw);

figure(10)
hold on
set(gcf,'Position',[50 50 1300 750])
set(gcf, 'color', 'w')
plot(f_m2,MdB)          %  Bode magnitude plot
hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
