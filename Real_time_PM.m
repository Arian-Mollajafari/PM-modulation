clc;
clear;
% Assuming a time domain which can be infinite
% no limitations such as memory run-out, overloads, etc.
T = 30;

% Message bandwidth
W = 5000;

% Carrier amplitude
Ac = 1;

% Carrier frequency
fc = 15000;

% Frequency deviation
kp = 1;

% Assuming power spectral density N0/2
N0 = 10^-11;

% Audio recorder object
recorder = audioDeviceReader;

% Audio player object
player = audioDeviceWriter('SampleRate',recorder.SampleRate);

% Assigning the SamplesPerFrame rate equal to the SamplesRate
% in order to process the latest one-second data
recorder.SamplesPerFrame = recorder.SampleRate;

% Start recording
disp('Radio started')

% Using tic-toc in order to form the t array for each second
tic;

% Radio is active for T seconds
for i = 0:round(T)
t0 = toc; % The time at the start of recording
m = recorder();
t = linspace(t0, toc, length(m)); % Forming t
mod   = pm_modulator(m', t, Ac, fc, kp);
chn   = channel(mod, 2*(max(m)+1)*W, N0);
demod = pm_demodulator(chn, t, recorder.SampleRate, Ac, W);
player(demod');
end
release(recorder)
release(player)