function y = pm_demodulator(r,t,fs,Ac,w)
% Derivative calculator
y = diff(r)/(t(2)-t(1));
% Finding the envelope
y = envelope(y);
% Removing DC
y = y - mean(y);
% Integration to find PM demodulated signal
y = cumsum(y)*(t(2)-t(1));
% Removing offset of the integral
y = y - mean(y);
% Also removing the Ac effect remained from the PM modulated signal
y = y/Ac;
% Final lowpass filter
y = lowpass(y,w,fs);

end