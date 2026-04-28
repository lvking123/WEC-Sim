% Plot mean power vs pto damping
pto_damp = [1 2 5 50 100 500 1000 2500 5000 7500 10000]; %Nms/rad
mean_power = [2.0356E-4 4.067E-4  1.0159E-3 1.0149E-2 2.0245E-2 9.346E-2 0.1509 0.16072 0.10544 0.074613 5.7192E-2]; %W

figure
semilogy(pto_damp, mean_power, '-o')
xlabel('PTO Damping (Nms/rad)')
ylabel('Mean Power (W)')