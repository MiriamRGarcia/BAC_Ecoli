
% RUN Bacterial batch growth parameter estimation example
clear all;

batch_bac_growth_SData     % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme (number of experiments initial 
                           % & stimulation conditions, observables, final time - per experiment)
                           % type of data and noise
                           % Numerical approaches for simulation 
AMIGO_Prep(inputs)         % Calls model preprocessing
                           
AMIGO_SObs(inputs)        % Calls the task for simulating observables


