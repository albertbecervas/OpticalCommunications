clear all;
close all;

% Variables globales

L       =   25;                                 % Fiber length (km).
f       =   193.1e12;                           % Frecuency (Hz).
c       =   physconst('LightSpeed') / 1e3;      % Light velocity (nm/ps).
Lambda  =   (c / f) * 1e9;                      % Wavelength (nm).


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

% VPI simulator use ns units as time axis (HPFW, sigma)

HPFW_IN  =   6.24754e-12 * 1e3;   % VIDEO (Convert to ns->ps)
HPFW_OUT  =  2.40695e-10 * 1e3;   % REVISAR (Convert to ns->ps)

% Gaussian's pulse power.
sigma_in    =   sigma(HPFW_IN);         % [ps]
sigma_out   =   sigma(HPFW_OUT);        % [ps]

% Propagation constant calculation (2n order -> beta2).
beta2_time   =   beta_time(sigma_in,sigma_out,L);       % [ps^2/km]

% Dispersion coefficient (GVD).
D   =   dispersion(Lambda, beta2_time);   % TODO: Verify units (ps/nm/km) Need to possible conversion?

disp(['  - Lambda = ', num2str(Lambda), ' nm']);
disp(['  - HPFW_IN = ', num2str(HPFW_IN), ' ps.']);
disp(['  - HPFW_OUT = ', num2str(HPFW_OUT), ' ps.']);
disp(['  - sigma_in = ', num2str(sigma_in), ' ps.']);
disp(['  - sigma_out = ', num2str(sigma_out), ' ps.']);
disp(['  - beta = ', num2str(beta2_time), newline]);
disp('-> Dispersion coefficient (GVD):');
disp(['  - D = ', num2str(D), ' ps/nm*km', newline]);
disp('===================================');
 
%%
 
% 2. Determinar el coeficiente de dispersi�n de la fibra SMF mediante
% medidas de amplitud.

disp(['========== Exercise A1-2 ==========', newline]);

% Gaussian's pulse output power.
% Graphic power -> uW

power_in = 1.216158275081745e-3;    % [W].
Loss_db = 0.2 * L;          % dB/km * km 
Loss = 10^(Loss_db/10); 
% power_out   =   power_in / Loss;  %W.
power_out   =   power_in * exp(-Loss_db);

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

% Exemple params (13th file; page 3/5)

Lambda  =   1550;                           % [nm]
D       =   18;                             % [ps/(nm*km)]
f       =   40e-3;                          % [THz]
c       =   physconst('LightSpeed') / 1e3;  % [nm/ps]

% Expected result -> L = 2166 m.

% ================================================

beta2_3     =   (Lambda^2 * abs(D)) / (2*pi*c);
ws          =   2*pi*f;

L           =   pi / (beta2_3 * ws^2);


%%

freq_min = 10e9;  %Hz
w_min = 2*pi*freq_min; %rad/s
lambda_min = c/freq_min;

beta2 = - pi/(L * w_min^2);
disp(["beta2 = ", beta2]);

D = ((-2*pi*c)/(lambda_min^2)) * beta2; %s/(m^2)
disp(["D =  ", D, "s/(m^2)\n"]);

D_smf = D * 10^6; %REVISAR, YA QUE ESTAMOS USANDO C CORREGIDA
