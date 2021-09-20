clear;
clc;
W = 4000;
T = 2;
fs = 500000;
%N0 = 9*10^-8;
N0= linspace(2*10^-11,5*10^-10, 30);
t = linspace(0,T-1/fs,T*fs);
msg = cos(2*pi*W*t);

mod = pm_modulator(msg,t,1,20000,1);
demod_no_n = pm_demodulator(mod,t,fs,1,W);

s_pow_no_n = mean(demod_no_n.^2);
snr = zeros(1,length(N0));
for i=1:length(N0)
    chn = channel(mod,2*(max(msg)+1)*W,N0(i));
    demod_n = pm_demodulator(chn,t,fs,1,W);
    n_pow = mean(demod_n.^2)-s_pow_no_n;
    snr(i) = s_pow_no_n/n_pow;
end
plot(N0,snr)
xlabel('N_0')
ylabel('SNR')