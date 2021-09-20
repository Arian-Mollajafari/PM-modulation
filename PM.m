clear;
clc;
% Message bandwidtth
W = 5000;

% Carrier amplitude
Ac = 1;

% Carrier frequency
fc = 20000;

% Frequenncy deviation
kp = 1;

% Assuming power spectral density N0/2
N0 = 10^-10;

% Audio reading from the file
[m,fs] = audioread('PinkPanther.wav');

% Forming t
t = linspace(0,(length(m)-1)/fs,length(m));

mod   = pm_modulator(m',t,Ac,fc,kp);
chn   = channel(mod,2*(max(m)+1)*W,N0);
demod = pm_demodulator(chn,t,fs,Ac,W);

sound(demod, fs);