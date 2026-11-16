clc; clf; clear all;

fc = 10000;
fm = 1000;
fs = 10 * fc;
t = 0: 1/fs: 5/fm;

msg = sin(2*%pi*fm*t);
carrier = cos(2*%pi*fc*t);

subplot(2,1,1)
plot(t,msg); 
xgrid;
title('Message Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude');

subplot(2,1,2)
plot(t,carrier); 
xgrid;
title('Carrier Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude');

carrier_amp = 1;
index1 = 0.5;
DSB1 = carrier_amp * (1 + index1 * msg) .* carrier;
index2 = 1;
DSB2 = carrier_amp * (1 + index2 * msg) .* carrier;
index3 = 1.5;
DSB3 = carrier_amp * (1 + index3 * msg) .* carrier;

figure();
subplot(3,1,1)
plot(t * 1000, DSB1, "r", "LineWidth", 1);
plot(t * 1000, (1 + index1 * msg), "k--", "LineWidth", 1.5);
plot(t * 1000, -(1 + index1 * msg), "k--", "LineWidth", 1.5);
xgrid;
title('Amplitude Modulation (DSB), Modulation Index = 0.5'); 
xlabel('Time (ms)'); 
ylabel('Amplitude');

subplot(3,1,2)
plot(t * 1000, DSB2, "r", "LineWidth", 1);
plot(t * 1000, (1 + index2 * msg), "k--", "LineWidth", 1.5);
plot(t * 1000, -(1 + index2 * msg), "k--", "LineWidth", 1.5);
xgrid;
title('Amplitude Modulation (DSB), Modulation Index = 1'); 
xlabel('Time (ms)'); 
ylabel('Amplitude');

subplot(3,1,3)
plot(t * 1000, DSB3, "r", "LineWidth", 1);
plot(t * 1000, (1 + index3 * msg), "k--", "LineWidth", 1.5);
plot(t * 1000, -(1 + index3 * msg), "k--", "LineWidth", 1.5);
xgrid;
title('Amplitude Modulation (DSB), Modulation Index = 1.5'); 
xlabel('Time (ms)'); 
ylabel('Amplitude');

DSB_SC = carrier_amp * msg .* carrier;

msg_h = -cos(2*%pi*fm*t); 
carrier_quad = sin(2*%pi*fc*t); 
SSB = 0.5 * carrier_amp * (msg .* carrier - msg_h .* carrier_quad);

figure();
subplot(2,1,1)
plot(t * 1000, DSB_SC, "r", "LineWidth", 1);
plot(t * 1000, msg, "k--", "LineWidth", 1.5);
plot(t * 1000, -msg, "k--", "LineWidth", 1.5);
xgrid;
title('Double Sideband Suppressed Carrier (DSB-SC)'); 
xlabel('Time (ms)'); 
ylabel('Amplitude');

subplot(2,1,2)
plot(t * 1000, SSB, "r", "LineWidth", 1);
xgrid;
title('Single Sideband Modulation (SSB-USB)'); 
xlabel('Time (ms)'); 
ylabel('Amplitude');

DSB = DSB2;
N = length(DSB);
half_N = floor(N/2);
f_pos = (0:half_N-1) * (fs/N);

DSB_fft = abs(fft(DSB)) * 2 / N;
DSB_fft_pos = DSB_fft(1:half_N);

DSB_SC_fft = abs(fft(DSB_SC)) * 2 / N;
DSB_SC_fft_pos = DSB_SC_fft(1:half_N);

SSB_fft = abs(fft(SSB)) * 2 / N;
SSB_fft_pos = SSB_fft(1:half_N);

figure();
subplot(3,1,1)
plot2d3(f_pos, DSB_fft_pos);
ax = gca();
ax.data_bounds = [6000, 0; 14000, 1.1];
xgrid;
title('Fourier Transform of Standard AM (DSB-FC)'); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude');

subplot(3,1,2)
plot2d3(f_pos, DSB_SC_fft_pos); 
ax = gca();
ax.data_bounds = [6000, 0; 14000, 0.7];
xgrid;
title('Fourier Transform of DSB-SC (Carrier Suppressed)'); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude');

subplot(3,1,3)
plot2d3(f_pos, SSB_fft_pos); 
ax = gca();
ax.data_bounds = [9000, 0; 13000, 0.7];
xgrid;
title('Fourier Transform of SSB-USB (Carrier & LSB Suppressed)'); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude');


cutoff_freq = 2 * fm; 
normalized_cutoff = cutoff_freq / fs;
filter_hz = iir(4, 'lp', 'butt', [normalized_cutoff, 0], [0, 0]);

demod_DSB = DSB2 .* carrier;
demod_DSB_lpf = flts(demod_DSB, filter_hz);
demod_DSB_final = 2 * (demod_DSB_lpf - mean(demod_DSB_lpf));

demod_DSB_SC = DSB_SC .* carrier;
demod_DSB_SC_lpf = flts(demod_DSB_SC, filter_hz);
demod_DSB_SC_final = 2 * demod_DSB_SC_lpf;

demod_SSB = SSB .* carrier;
demod_SSB_lpf = flts(demod_SSB, filter_hz);
demod_SSB_final = 4 * demod_SSB_lpf;

figure();
subplot(3,1,1)
plot(t * 1000, msg, "k--", "LineWidth", 1.5);
plot(t * 1000, demod_DSB_final, "r", "LineWidth", 1);
xgrid;
title('Demodulated Standard AM (DSB-FC)'); 
xlabel('Time (ms)'); 
ylabel('Amplitude');

subplot(3,1,2)
plot(t * 1000, msg, "k--", "LineWidth", 1.5);
plot(t * 1000, demod_DSB_SC_final, "r", "LineWidth", 1);
xgrid;
title('Demodulated DSB-SC'); 
xlabel('Time (ms)'); 
ylabel('Amplitude');

subplot(3,1,3)
plot(t * 1000, msg, "k--", "LineWidth", 1.5);
plot(t * 1000, demod_SSB_final, "r", "LineWidth", 1);
xgrid;
title('Demodulated SSB'); 
xlabel('Time (ms)'); 
ylabel('Amplitude');
