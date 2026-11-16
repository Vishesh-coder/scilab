clc; clf; clear all; //clear
//defining all parameters
fc = 10000;
fm = 1000;
fs = 10 * fc;
dt = 1/fs;
t = 0: 1/fs: 4/fm;
kp = %pi;
Ac = 1;
Am = 1;
//defining message and carrier signal
msg = Am*sin(2*%pi*fm*t);
carrier = Ac*cos(2*%pi*fc*t);
//plotting the message signal
subplot(3,1,1);
plot(t,msg); 
xgrid;
title('Message Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude');
//performing modulation
phase = 2*%pi*fc*t + kp*msg;
PM = Ac*cos(phase);
//plotting modulated signal
subplot(3,1,2);
plot(t, PM);
xgrid;
title('Phase Modulation'); 
xlabel('Time (s)'); 
ylabel('Amplitude');
I = PM .* cos(2*%pi*fc*t); //defining in-phase signal
Q = -PM .* sin(2*%pi*fc*t); // defining quadrature-phase signal
filt = iir(3, 'lp', 'butt', [3*fm/fs, 0], [0, 0]); //using lpf to remove freq over cutoff
I = flts(I, filt); //filtering in-phase signal
Q = flts(Q, filt); //filtering Q-phase signal
demod = atan(Q, I) / kp; //taking tan-1 of (Q/I)
demod = demod / max(abs(demod)); //fixing the amplitude
//plotting the demodulated signal
subplot(3,1,3);
plot(t, msg, "k--", "LineWidth", 1);
plot(t, demod);
xgrid;
title('Demodulated PM Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude');
