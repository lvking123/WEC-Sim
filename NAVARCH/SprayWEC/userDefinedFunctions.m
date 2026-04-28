%MATLAB file for post processing spray data

%Plot waves
waves.plotElevation(simu.rampTime);
try 
    waves.plotSpectrum();
catch
end

% Plot RY forces for body 1
output.plotForces(1,5)

%Plot RY response for body 1
output.plotResponse(2,5);

% Plot x forces for body 2
output.plotForces(2,1)

% Plot pto power
ramp_time = 200;
power_pitch = -output.ptos.powerInternalMechanics(:,5);
power_steady = power_pitch(output.ptos.time>ramp_time);
mean_steady_power = mean(power_steady);

plot(output.ptos.time, -output.ptos.powerInternalMechanics);
grid on
yline(mean_steady_power, label = ['Mean Power = ', num2str(mean_steady_power)], Color = 'r');
axis([ramp_time max(output.ptos.time) 0 1.5*max(power_steady)]);
xlabel('Time (s)');
ylabel('Power (W)');
title('Instantaneous PTO Power');

% Save waves and response as video
% output.saveViz(simu,body,waves,...
%     'timesPerFrame',5,'axisLimits',[-50 50 -50 50 -12 20],...
%     'startEndTime',[100 125]);
