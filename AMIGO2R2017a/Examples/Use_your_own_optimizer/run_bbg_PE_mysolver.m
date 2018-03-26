
% RUN Bacterial batch growth parameter estimation example with YOUR OWN
% optimizer
clear all;

cprintf('*[1,0.5,0]','\n\n --->Parameter estimation using your own optimizer');
pause(1)

bbg_PE                     % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme + data + noise
                           % PE problem formulation: cost function and unknowns to be estimated
                           % Numerical approaches for  simulation and optimization
                      
AMIGO_Prep(inputs)         % Calls the task for pre-processing

inputs.nlpsol.nlpsolver='my_DiffEvol';

AMIGO_PE(inputs)           % Calls the task for Parameter Estimation


