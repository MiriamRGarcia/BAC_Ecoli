
% RUN NFKB parameter estimation example
clear all;

NFKB_OED              % Calls the script with the inputs: 
                     % Model
                     % Experimental scheme + data + noise
                     % PE problem formulation: cost function and unknowns to be estimated
                     % Numerical approaches for  simulation and optimization

AMIGO_Prep(inputs)   % Calls the task for pre-processing
AMIGO_OED(inputs)     % Calls the task for Parameter Estimation


