clc; clf; clear all;
f = 50;
T = 1/f;
Fs = 1000 * f; 
t = 0 : 1/Fs : 3*T; 

x = sin(2*%pi*f*t);
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
xtitle("Sine Wave (Time Domain)", "Time (s)", "Amplitude");
xgrid;

subplot(2,2,2);
plot2d3(n, abs(Cn));
xtitle("Fourier Series Magnitude Spectrum", "Harmonic number (n)", "|Cn|");
ax = gca();
ax.data_bounds = [-5, 0; 5, 2]; 

subplot(2,2,3);
plot2d3(n, phase_Cn);
xtitle("Fourier Series Phase Spectrum", "Harmonic number (n)", "Phase (radians)");
xgrid;

subplot(2,2,4);
plot2d3(f_axis, X_mag_shifted); 
xtitle("Fourier Transform Magnitude Spectrum", "Frequency (Hz)", "|X(f)|");
a = gca();
a.data_bounds = [-150, 0; 150, max(X_mag_shifted)*1.2]; 

disp("Phase of Cn (radians):");
disp(phase_Cn);
