
% RUN Bacterial batch growth parameter estimation example
clear all;

cprintf('*[1,0.5,0]','\n\n --->Parameter estimation using data from one experiment');
pause(1)

batch_bac_growth_PE_1exp   % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme + data + noise
                           % PE problem formulation: cost function and unknowns to be estimated
                           % Numerical approaches for  simulation and optimization
                      
AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_PE(inputs)           % Calls the task for Parameter Estimation

clear all;

cprintf('*[1,0.5,0]','\n\n --->Parameter estimation using data from two experiments');
pause(1)

batch_bac_growth_PE_2exps   % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme + data + noise
                           % PE problem formulation: cost function and unknowns to be estimated
                           % Numerical approaches for  simulation and optimization
                      
AMIGO_PE(inputs)           % Calls the task for Parameter Estimation
