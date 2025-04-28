% FRFSpectrum.m
% a function that calculates and plots an H3 Frequency Response

function [f,H3] = FRFSpectrum(t,Vi,Vo,iPlot,Navg)

deltaT = t(2) - t(1); % sampling time (s)
num_samp = length(t);

% Break full sample into subsamples for averaging
%Navg = 200;      % Number of averages
eta  = 0.0;    % Percent overlap in samples

% first, determine number of samples in each average, then truncate array
n = floor(num_samp/(Navg*(1-eta)+eta));
num_samp = floor(n*(Navg*(1-eta)+eta));
dataA(1:num_samp,1) = Vi(1:num_samp);
dataB(1:num_samp,1) = Vo(1:num_samp);

% Here's where the autospectrum stuff starts
% Calculate weighting function and frequency values
j = 1:n;                    % # of points in time sample
n2 = floor(n/2);  
k = 1:n2;                   % up to Nyquist frequency
f(k) = (k-1)/(n*deltaT) ;   % Frequency values
w(j) = 1;                   % uniform window
EAA    = zeros(1,n2);  EBB    = zeros(1,n2);  EAB    = zeros(1,n2);
for i = 1:Navg
    Nstart = floor((i-1)*n*(1-eta)+1);  % starting index for each average
    tempA = dataA(Nstart:Nstart+n-1)';
    tempB = dataB(Nstart:Nstart+n-1)';
    tempA = w .* tempA;     % Apply window to sample
    tempB = w .* tempB;     % Apply window to sample
    XA = fft(tempA);        % Take Fourier transform of sample
    XB = fft(tempB);        % Take Fourier transform of sample
    SA = XA*sqrt(2)/n;      % Change to Fourier spectrum
    SB = XB*sqrt(2)/n;      % Change to Fourier spectrum
    SA(1) = SA(1)/sqrt(2);  % Change to Fourier spectrum
    SB(1) = SB(1)/sqrt(2);  % Change to Fourier spectrum
    GAA = conj(SA) .* SA;   % Power of autospectrum
    GBB = conj(SB) .* SB;   % Power of autospectrum
    GAB = conj(SA) .* SB;   % Power of cross-spectrum
    EAA(k) = EAA(k) + GAA(k);  % Averaged autospectrum
    EBB(k) = EBB(k) + GBB(k);  % Averaged autospectrum
    EAB(k) = EAB(k) + GAB(k);  % Averaged cross-spectrum
end
EAA = EAA/Navg;
EBB = EBB/Navg;
EAB = EAB/Navg;

phi = angle(EAB);       % phase of cross-spectrum
H3 = sqrt(EBB./EAA).*exp(1j*phi);

% -----------------   Plot autospectra and FRFs   -----------------------
dBEAA  = 20*log10(EAA/1e-6);
dBEBB  = 20*log10(EBB/1e-6);
dBEH3  = 20*log10(abs(H3));


if iPlot 
  figure; set(gcf,'Position',[50 50 1200 700]); hold on
  plot(f,dBEAA,f,dBEBB)
  xlabel('Frequency (Hz)'),ylabel('Autospectrum (dB re 1\muV)')
  legend('Input','Output')
  grid on

  figure; set(gcf,'Position',[50 50 1200 700]); hold on
  plot(f,dBEH3)
  xlabel('Frequency (Hz)'),ylabel('Frequency Response (dB re 1V/V)')
  ylim([-40 0])
  xlim([0 5000])
  grid on
end
