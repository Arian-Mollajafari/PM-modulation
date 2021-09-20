clear;
clc;
T = 2;
fs = 500000;
N0 = 10^-9;
W = linspace(100,10000, 50);
t = linspace(0,T-1/fs,T*fs);
snr = zeros(1,length(W));
msg = zeros(length(W),length(t));
for i=1:length(W)
msg(i,:) = cos(2*pi*W(i)*t);
mod = pm_modulator(msg(i,:),t,1,50000,1);
demod_no_n = pm_demodulator(mod,t,fs,1,1.1*W(i));
s_pow_no_n = mean(demod_no_n.^2);
chn = channel(mod,2*W(i),N0);
demod_n = pm_demodulator(chn,t,fs,1,1.1*W(i));
n_pow = mean(demod_n.^2)-s_pow_no_n;
snr(i) = s_pow_no_n/n_pow;
end
plot(W,snr)
xlabel('W')
ylabel('SNR')