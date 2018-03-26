
% Performs the robust identifiability analysis for the bacterial batch growth model  
clear all;

cprintf('*[1,0.5,0]','\n\n --->Robust identibiability using data from one experiment');
pause(1)

batch_bac_growth_RI_1exp   % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme + data + noise
                           % PE problem formulation: cost function and unknowns to be estimated
                           % Numerical approaches for  simulation and optimization
                      
AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_PE(inputs)           % Calls the task for Parameter Estimation

clear all;

cprintf('*[1,0.5,0]','\n\n --->Robust identibiablity using data from two experiments');
pause(1)

batch_bac_growth_RI_2exps   % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme + data + noise
                           % PE problem formulation: cost function and unknowns to be estimated
                           % Numerical approaches for  simulation and optimization
                      
AMIGO_PE(inputs)           % Calls the task for Parameter Estimation
