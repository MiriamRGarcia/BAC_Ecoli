
% RUN Bacterial batch growth parameter estimation example
clear all;

batch_bac_growth_SM        % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme (number of experiments initial 
                           % & stimulation conditions, final time - per experiment) 
                           % Numerical approaches for simulation 
AMIGO_Prep(inputs)         % Calls model preprocessing
                           
AMIGO_SModel(inputs)       % Calls the task for Parameter Estimation


