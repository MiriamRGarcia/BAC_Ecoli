
% RUN NFKB model simulation
clear all;

NFKB_SData                 % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme (number of experiments initial 
                           % & stimulation conditions, observables, final time - per experiment),
                           % type of data and noise
                           % Numerical approaches for simulation 

AMIGO_Prep(inputs)         % Calls the task for pre-processing


cprintf('*[1,0.5,0]','\n\n --->Generates pseudo-data with equal noise variance for all sampling times (homo noise)');
pause(1)

AMIGO_SData(inputs)        % Calls the task for simulating observables

close all;
cprintf('*[1,0.5,0]','\n\n --->Generates pseudo-data with noise standard deviation proportional to the state (hetero_proportional noise)');
pause(1)


inputs.exps.data_type='pseudo';
inputs.exps.noise_type='hetero_proportional';
inputs.exps.std_dev{1}=[0.15 0.15 0.1 0.2 0.1 0.2];
inputs.exps.std_dev{2}=[0.15 0.15 0.1 0.2 0.1 0.2];

AMIGO_SData(inputs)        % Calls the task for simulating observables


close all;
cprintf('*[1,0.5,0]','\n\n --->Generates pseudo-data with multiplicative, lognormally distributed noise with standard (log_normal noise)');
pause(1)


inputs.exps.data_type='pseudo';
inputs.exps.noise_type='log_normal';
inputs.exps.std_devb{1}=[0.15 0.15 0.1 0.2 0.1 0.2];
inputs.exps.std_devb{2}=[0.15 0.15 0.1 0.2 0.1 0.2];

AMIGO_SData(inputs)        % Calls the task for simulating observables
