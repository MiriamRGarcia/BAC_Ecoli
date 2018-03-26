
% RUN NFKB model simulation
clear all;

NFKB_SM                    % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme (number of experiments initial 
                           % & stimulation conditions, final time - per experiment) 
                           % Numerical approaches for simulation 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_SModel(inputs)       % Calls the task for Parameter Estimation


