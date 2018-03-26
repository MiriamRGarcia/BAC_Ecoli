
% RUN Bacterial batch growth parameter estimation example
clear all;

batch_bac_growth_SObs      % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme (number of experiments initial 
                           % & stimulation conditions, OBSERVABLES, final time - per experiment) 
                           % Numerical approaches for simulation 
AMIGO_Prep(inputs)         % Calls model preprocessing
                           
AMIGO_SObs(inputs)        % Calls the task for simulating observables


