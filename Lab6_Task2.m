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

[f_h,FRF_h] = FRFSpectrum(t_h,V1_h,Vout_h,'true',100);
