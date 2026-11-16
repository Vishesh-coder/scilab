clc; clf; clear all;

f = 50;
T = 1/f;
Fs = 1000 * f; 
t = 0 : 1/Fs : 5*T; 

x = squarewave(2*%pi*f*t);
N = 50;
n = -N:N;
Cn = zeros(1, length(n));

for k=1:length(n)
    y = x.*exp(-%i*2*%pi*f*n(k)*t);
    Cn(k) = 1/T * inttrap(t,y);
end

phase_Cn = atan(imag(Cn), real(Cn));

L = length(t);
X_fft = fft(x);
X_mag = abs(X_fft) / L; 
X_mag_shifted = fftshift(X_mag);
f_axis = (-floor(L/2) : floor((L-1)/2)) * Fs / L;

subplot(2,2,1);
plot(t, x);
title("Square Wave (Time Domain)");
xlabel("Time (s)");
ylabel("Amplitude");

subplot(2,2,2);
plot2d3(n, abs(Cn));
title("Fourier Series Magnitude Spectrum");
xlabel("Harmonic number (n)");
ylabel("|Cn|");

subplot(2,2,3);
plot2d3(n, phase_Cn);
title("Fourier Series Phase Spectrum");
xlabel("Harmonic number (n)");
ylabel("Phase (radians)");

subplot(2,2,4);
plot2d3(f_axis, X_mag_shifted); 
title("Fourier Transform Magnitude Spectrum");
xlabel("Frequency (Hz)");
ylabel("|X(f)|");
a = gca();
a.data_bounds = [-550, 0; 550, max(X_mag_shifted)*1.2]; 

disp("Phase of Cn (radians):");
disp(phase_Cn);
