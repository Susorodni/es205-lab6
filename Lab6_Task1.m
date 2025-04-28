clear variables; clc; close all;

% Task 1
a = 0;                
b = 35000;                
n = 5001;                %  Number of frequency points
w = linspace(a,b,n)';    %  Define the frequency range
s = 1j*w;


R = 80e3;
C = 10e-9;

for Rp = 0:1000:10000

    Giw_1 = -C*R*(Rp+100)*s./( (C^2)*(R^2)*(Rp+100)*s.^2 + C*R*(Rp+100)*s +(R+Rp+100)/2 );        %  FRF – use ‘.’ operators
    magGiw_1 = abs(Giw_1);       %  FRF magnitude
    MdB_1 = 20*log10(magGiw_1);  %  Magnitude in dB
    phaseGiw_1 = unwrap(angle(Giw_1))*180/pi;  %  FRF phase in degrees.  Unwrap prevents jumps
                                           %  around the unit circle.
    
    
    set(gcf,'Position',[50 50 1300 750])
    set(gcf, 'color', 'w')
    subplot(211)             %  Create a subplot figure
    plot(w/(2*pi),MdB_1)          %  Bode magnitude plot
    hold on
    grid on
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')

    subplot(212)
    plot(w/(2*pi),phaseGiw_1)     %  Bode phase plot
    hold on
    grid on
    xlabel('Frequency (Hz)')
    ylabel('Phase (deg)')	

end