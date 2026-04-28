%% Spray input data

%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'spray.slx';      % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer = 'on';                   % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 200;                    % Wave Ramp Time [s]
simu.endTime = 750;                     % Simulation End Time [s]
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.01; 							% Simulation time-step [s]

%% Wave Information 
% % noWaveCIC, no waves with radiation CIC  
% waves = waveClass('noWaveCIC');       % Initialize Wave Class and Specify Type  

% % Regular Waves  
waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
waves.height = 0.5;                     % Wave Height [m]
waves.period = 6;                       % Wave Period [s]

% % Regular Waves with CIC
% waves = waveClass('regularCIC');          % Initialize Wave Class and Specify Type                                 
% waves.height = 2.5;                       % Wave Height [m]
% waves.period = 8;                         % Wave Period [s]

% % Irregular Waves using PM Spectrum 
%  waves = waveClass('irregular');           % Initialize Wave Class and Specify Type
%  waves.height = 2.5;                       % Significant Wave Height [m]
%  waves.period = 8;                         % Peak Period [s]
%  waves.spectrumType = 'PM';                % Specify Wave Spectrum Type
%  waves.direction=[0];

% % Irregular Waves using JS Spectrum with Equal Energy and Seeded Phase
% waves = waveClass('irregular');           % Initialize Wave Class and Specify Type
% waves.height = 2.5;                       % Significant Wave Height [m]
% waves.period = 8;                         % Peak Period [s]
% waves.spectrumType = 'JS';                % Specify Wave Spectrum Type
% waves.bem.option = 'EqualEnergy';         % Uses 'EqualEnergy' bins (default) 
% waves.phaseSeed = 1;                      % Phase is seeded so eta is the same

% % Irregular Waves using PM Spectrum with Traditional and State Space 
% waves = waveClass('irregular');           % Initialize Wave Class and Specify Type
% waves.height = 2.5;                       % Significant Wave Height [m]
% waves.period = 8;                         % Peak Period [s]
% waves.spectrumType = 'PM';                % Specify Wave Spectrum Type
% simu.stateSpace = 1;                      % Turn on State Space
% waves.bem.option = 'Traditional';         % Uses 1000 frequnecies

% % Irregular Waves with imported spectrum
% waves = waveClass('spectrumImport');      % Create the Wave Variable and Specify Type
% waves.spectrumFile = 'spectrumData.mat';  % Name of User-Defined Spectrum File [:,2] = [f, Sf]

% % Waves with imported wave elevation time-history  
% waves = waveClass('elevationImport');          % Create the Wave Variable and Specify Type
% waves.elevationFile = 'elevationData.mat';     % Name of User-Defined Time-Series File [:,2] = [time, eta]

%% Body Data
% Float
body(1) = bodyClass('hydroData/spray_hydrodynamics.h5');      
    % Create the body(1) Variable, Set Location of Hydrodynamic Data File 
    % and Body Number Within this File.   
body(1).geometryFile = 'geometry/Hull2_wec.stl';    % Location of Geomtry File
%body(1).initial.displacement = [0 0 -.5];
body(1).mass = 'equilibrium'; %100kg                   
    % Body Mass. The 'equilibrium' Option Sets it to the Displaced Water 
    % Weight.
body(1).inertia = [40.002 40.002 0.777];  % Moment of Inertia [kg*m^2] 
body(1).centerGravity = [.175 0 -.9];
%body(1).centerBuoyancy = body(1).centerGravity;
body(1).hydroStiffness = [[ 0.00000000e+00,  0.00000000e+00,  0.00000000e+00, 0.00000000e+00,  0.00000000e+00,  0.00000000e+00];
       [ 0.00000000e+00,  0.00000000e+00,  0.00000000e+00, 0.00000000e+00,  0.00000000e+00,  0.00000000e+00];
       [ 0.00000000e+00,  0.00000000e+00,  4.77736007e+02, 7.97701748e-16, -8.36259854e+01,  0.00000000e+00];
       [ 0.00000000e+00,  0.00000000e+00,  7.97701748e-16, -8.46053553e+01, -3.80118643e-10,  2.39527599e-03];
       [ 0.00000000e+00,  0.00000000e+00, -8.36259854e+01, -3.80118643e-10, -6.99675751e+01,  2.92513424e-09];
       [ 0.00000000e+00,  0.00000000e+00,  0.00000000e+00, 0.00000000e+00,  0.00000000e+00,  0.00000000e+00]];

% Spar/Plate
body(2) = bodyClass('hydroData/spray_hydrodynamics.h5'); 
body(2).geometryFile = 'geometry/Arm2_wec.stl'; 
%body(2).initial.displacement = [0 0 -0.5]; %***
body(2).mass = 'equilibrium'; %5kg   ***                
body(2).inertia = [.005 1.52 1.523]; %kg*m^3
%body(2).centerGravity = [.992 0 -.006];
%body(2).centerBuoyancy = [0.9920 0 -0.0060]; 
body(2).hydroStiffness = [[ 0.00000000e+00,  0.00000000e+00,  0.00000000e+00, 0.00000000e+00,  0.00000000e+00,  0.00000000e+00];
       [ 0.00000000e+00,  0.00000000e+00,  0.00000000e+00, 0.00000000e+00,  0.00000000e+00,  0.00000000e+00];
       [ 0.00000000e+00,  0.00000000e+00,  1.69711650e+03, -2.42864129e-06,  1.76966511e+03,  0.00000000e+00];
       [ 0.00000000e+00,  0.00000000e+00, -2.42864129e-06, 9.01065220e-01, -2.51235510e-01, -2.05241957e+00];
       [ 0.00000000e+00,  0.00000000e+00,  1.76966511e+03, -2.51235510e-01,  2.26088691e+03, -5.84446016e-04];
       [ 0.00000000e+00,  0.00000000e+00,  0.00000000e+00, 0.00000000e+00,  0.00000000e+00,  0.00000000e+00]];


%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('Constraint1'); % Initialize Constraint Class for Constraint1
constraint(1).location = body(1).centerGravity;               % Constraint Location [m]

% Translational PTO
pto(1) = ptoClass('PTO1');                      % Initialize PTO Class for PTO1
pto(1).stiffness = 0;                           % PTO Stiffness [N/m]
pto(1).damping = 10;                       % PTO Damping [Nm/(rad/s)], what should this be?
pto(1).location = [0 0 0];                      % PTO Location [m]
