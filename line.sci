clc;
clear;
clf;

bits=[1 0 1 1 0 0 1 0];
n=length(bits);

samples=100;
t=linspace(0, n, n * samples);

unipolar_nrz=[];
unipolar_rz=[];
polar_nrz=[];
polar_rz=[];
manchester=[];
ami=[];

ami_sign=1;

for i=1:n
    if bits(i)==1 then
        u_nrz=ones(1, samples);
        u_rz=[ones(1, samples/2), zeros(1, samples/2)];
        p_nrz=ones(1, samples);
        p_rz=[ones(1, samples/2), zeros(1, samples/2)];
        manch=[ones(1, samples/2), -ones(1, samples/2)];
        b_ami=ami_sign * ones(1, samples);
        ami_sign=-ami_sign;
    else
        u_nrz=zeros(1, samples);
        u_rz=zeros(1, samples);
        p_nrz=-ones(1, samples);
        p_rz=[-ones(1, samples/2), zeros(1, samples/2)];
        manch=[-ones(1, samples/2), ones(1, samples/2)];
        b_ami=zeros(1, samples);
    end
    
    unipolar_nrz=[unipolar_nrz, u_nrz];
    unipolar_rz=[unipolar_rz, u_rz];
    polar_nrz=[polar_nrz, p_nrz];
    polar_rz=[polar_rz, p_rz];
    manchester=[manchester, manch];
    ami=[ami, b_ami];
end

subplot(6, 1, 1);
plot(t, unipolar_nrz, 'b', 'LineWidth', 2);
title('Unipolar NRZ');
ylabel('Amp');
xgrid();

subplot(6, 1, 2);
plot(t, unipolar_rz, 'c', 'LineWidth', 2);
title('Unipolar RZ (URZ)');
ylabel('Amp');
xgrid();

subplot(6, 1, 3);
plot(t, polar_nrz, 'r', 'LineWidth', 2);
title('Polar NRZ');
ylabel('Amp');
xgrid();

subplot(6, 1, 4);
plot(t, polar_rz, 'g', 'LineWidth', 2);
title('Polar RZ');
ylabel('Amp');
xgrid();

subplot(6, 1, 5);
plot(t, manchester, 'm', 'LineWidth', 2);
title('Manchester');
ylabel('Amp');
xgrid();

subplot(6, 1, 6);
plot(t, ami, 'k', 'LineWidth', 2);
title('Bipolar AMI');
xlabel('Time (Bit Duration)');
ylabel('Amp');
xgrid();
