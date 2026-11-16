clc; clf; clear all;
fc = 10000;
fm = 1000;
fs = 10 * fc;
dt = 1/fs;
t = 0: 1/fs: 4/fm;
kf = 2*%pi*fm;
Ac = 1;
Am = 1;
delta_fm = kf*Am;
beta_fm = delta_fm/fm;

msg = Am*sin(2*%pi*fm*t);
carrier = Ac*cos(2*%pi*fc*t);

subplot(3,1,1);
plot(t,msg); 
xgrid;
title('Message Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude');

msg_int = -cos(2*%pi*fm*t);
phase = 2*%pi*fc*t + beta_fm*msg_int;
FM = Ac * cos(phase);

subplot(3,1,2);
plot(t, FM);
xgrid;
title('Frequency Modulation'); 
xlabel('Time (s)'); 
ylabel('Amplitude');

//demodulation
dFM = [diff(FM) / dt, 0];
FM_rectify = abs(dFM);

cutoff_freq = 1.5*fm;
norm_cutoff = cutoff_freq / fs;
filter_FM = iir(3, 'lp', 'butt', [norm_cutoff, 0], [0, 0]);
demod_FM_lpf = flts(FM_rectify, filter_FM);
demod_FM_final = (demod_FM_lpf - mean(demod_FM_lpf));
demod_FM_final = demod_FM_final / max(demod_FM_final);

subplot(3,1,3);
plot(t, msg, "k--", "LineWidth", 1);
plot(t, demod_FM_final);
xgrid;
title('Demodulated FM Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude');
