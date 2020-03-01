clear all;
close all;

% Variables globales

L       =   25e3;                       % Fiber length (m).
f       =   193.1e12;                   % Frecuency (Hz).
c       =   physconst('LightSpeed');    % Light velocity (m/s).
Lambda  =   (c / f) * 1e9;              % Wavelength (nm).


%%

% Use numbers with 15-digits precision.
format long;

% =======================
% ===== APARTADO A1 =====
% =======================
% Medida de dispersi�n en fibras monomodo mediante pulsos.

% 1. Determinar el coeficiente de dispersi�n de la fibra SMF mediante
% medidas temporales.

disp(['========== Exercise A1-1 ==========', newline]);

HPFW_IN  =   6.24754e-12;  
HPFW_OUT  =  0;

% Gaussian's pulse power.
sigma_in    =   sigma(HPFW_IN);
sigma_out   =   sigma(HPFW_OUT);

% Propagation constant calculation (2n order -> beta2).
beta2_time   =   beta(sigma_in,sigma_out,L);

% Dispersion coefficient (GVD).
D   =   dispersion(Lambda, beta2_time);   % TODO: Verify units (ps/nm/km) Need to possible conversion?

disp(['  - Lambda = ', num2str(Lambda), ' nm']);
disp(['  - HPFW_IN = ', num2str(HPFW_IN), ' W.']);
disp(['  - HPFW_OUT = ', num2str(HPFW_OUT), ' W.']);
disp(['  - sigma_in = ', num2str(sigma_in), ' W.']);
disp(['  - sigma_out = ', num2str(sigma_out), ' W.']);
disp(['  - beta = ', num2str(beta2_time), newline]);
disp('-> Dispersion coefficient (GVD):');
disp(['  - D = ', num2str(D), ' ps/nm*km', newline]);
disp('===================================');
 
%%
 
% 2. Determinar el coeficiente de dispersi�n de la fibra SMF mediante
% medidas de amplitud.

disp(['========== Exercise A1-1 ==========', newline]);

% Gaussian's pulse output power.

power_in = 1e-3; %W.
Loss_db = 0.2e-3 * L; % dB/m * m 
Loss = 10^(Loss_db/10); 
power_out   =   power_in / Loss;  %W.

beta2_amp = sqrt((sigma_in^4) - (power_out^2)*(sigma_in^4)) / (power_out * L);

% Dispersion coefficient (GVD).
D   =   dispersion(Lambda, beta2_amp);   % TODO: Verify units (ps/nm/km) Need to possible conversion?

disp(['  - Pout = ', num2str(power_out), 'W.']);
disp(['  - beta = ', num2str(beta2_amp), newline]);
disp('-> Dispersion coefficient (GVD):');
disp(['  - D = ', num2str(D), ' ps/nm/km', newline]);
disp('===================================');


%%

% 3. Determinar la longitud de la fibra DCF (en Resources) necesaria para
% compensar la dispersi�n de 25km de fibra SMF con una tasa de bits de
% 40Gb/s (par�metros por defecto en A1.vtmu).