% Lab6_T1
clear variables;  clc; close all;

a = -1;                  %  10^a = 0.1 rad/s
b = 35000;                   %  10^b = 1000 rad/s
n = 5000;                %  Number of frequency points # of points
w = linspace(a,b,n)';    %  Define the frequency range    logspace makes log based points (equal distance between points)
s = 1j*w;                % matlab knows 1j as imaginary

R = 80e3;              % ohms
C = 10e-9;        % F


for Rp = 0:1000:10000 

G1 = -(C*R*(Rp+100)*s)./(C^2*R^2*(s.^2)*(100+Rp)+C*R*s*(100+Rp)+(R+Rp+100)/2);

magGiw = abs(G1);       %  FRF magnitude
MdB = 20*log10(magGiw);  %  Magnitude in dB
phaseGiw = unwrap(angle(G1))*180/pi;  %  FRF phase in degrees.  Unwrap prevents jumps
              
figure(1)
set(gcf,'Position',[50 50 1300 750])
set(gcf, 'color', 'w')
subplot(211)             %  Create a subplot figure
plot(w,MdB,'Linewidth',2)          %  Bode magnitude plot
hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')

subplot(212)
plot(w,phaseGiw,'LineWidth',2)     %  Bode phase plot
hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Phase (deg)')	

end

