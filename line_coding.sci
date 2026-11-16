clc(); clf(); clear all; //clear
    
//Input binary data and axes
y = [1 1 0 0 1 0 1 1 0 0];
N = length(y);
t_nrz = 0:1:N;
t_rz = 0:0.5:N;
f = -50:(1/N):50-(1/N);
idx_nrz = ceil((1:100*N)/100);
idx_rz = ceil((1:100*N)/50);

//Unipolar NRZ & RZ
UNRZ = [y, y(N)];
URZ = zeros(1, 2*N + 1);
URZ(1:2:2*N) = y;
F_UNRZ = abs(fftshift(fft(UNRZ(idx_nrz))));
F_URZ = abs(fftshift(fft(URZ(idx_rz))));

figure(0);
subplot(2,2,1);
plot2d2(t_nrz, UNRZ, 2);
gce().children.thickness = 2;
xgrid();
xtitle("Unipolar NRZ - Time Domain", "Time", "Amplitude");

subplot(2,2,2);
plot2d(f, F_UNRZ/max(F_UNRZ), 2);
xgrid();
xtitle("Unipolar NRZ - Frequency Domain", "Frequency (Hz)", "Normalized Magnitude");

subplot(2,2,3);
plot2d2(t_rz, URZ, 2);
gce().children.thickness = 2;
xgrid();
xtitle("Unipolar RZ - Time Domain", "Time", "Amplitude");

subplot(2,2,4); 
plot2d(f, F_URZ/max(F_URZ), 2); 
xgrid();
xtitle("Unipolar RZ - Frequency Domain", "Frequency (Hz)", "Normalized Magnitude");

//Polar NRZ & RZ
PNRZ = 2*UNRZ - 1;
PRZ = zeros(1, 2*N + 1);
PRZ(1:2:2*N) = 2*y - 1;
F_PNRZ = abs(fftshift(fft(PNRZ(idx_nrz))));
F_PRZ = abs(fftshift(fft(PRZ(idx_rz))));

figure(1);
subplot(2,2,1);
plot2d2(t_nrz, PNRZ, 2);
gce().children.thickness = 2;
xgrid();
xtitle("Polar NRZ - Time Domain", "Time", "Amplitude");

subplot(2,2,2);
plot2d(f, F_PNRZ/max(F_PNRZ), 2);
xgrid();
xtitle("Polar NRZ - Frequency Domain", "Frequency (Hz)", "Normalized Magnitude");

subplot(2,2,3);
plot2d2(t_rz, PRZ, 2);
gce().children.thickness = 2;
xgrid();
xtitle("Polar RZ - Time Domain", "Time", "Amplitude");

subplot(2,2,4);
plot2d(f, F_PRZ/max(F_PRZ), 2);
xgrid();
xtitle("Polar RZ - Frequency Domain", "Frequency (Hz)", "Normalized Magnitude");

//AMI
AMI = y;
ones_idx = find(y == 1);
AMI(ones_idx(2:2:length(ones_idx))) = -1;
AMI = [AMI, AMI(N)];
F_AMI = abs(fftshift(fft(AMI(idx_nrz))));

figure(2);
subplot(2,1,1); 
plot2d2(t_nrz, AMI, 2); 
gce().children.thickness = 2;
xgrid();
xtitle("AMI - Time Domain", "Time", "Amplitude");

subplot(2,1,2);
plot2d(f, F_AMI/max(F_AMI), 2); 
xgrid();
xtitle("AMI - Frequency Domain", "Frequency (Hz)", "Normalized Magnitude");

//Manchester
Manchester = zeros(1, 2*N);
Manchester(1:2:2*N) = 1 - 2*y;
Manchester(2:2:2*N) = 2*y - 1;
Manchester = [Manchester, Manchester(2*N)];
F_Man = abs(fftshift(fft(Manchester(idx_rz))));

figure(3);
subplot(2,1,1); 
plot2d2(t_rz, Manchester, 2); 
gce().children.thickness = 2; 
xgrid();
xtitle("Manchester - Time Domain", "Time", "Amplitude");

subplot(2,1,2); 
plot2d(f, F_Man/max(F_Man), 2); 
xgrid();
xtitle("Manchester - Frequency Domain", "Frequency (Hz)", "Normalized Magnitude");
