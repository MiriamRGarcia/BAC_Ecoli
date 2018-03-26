
% Computes Hodgkin-Huxley model global parametric sensitivities and 
% rank or parameters 

clear all;

cprintf('*[1,0.5,0]','\n\n --->Computing global sensitivities, this may take a while...');

Hodgkin_Huxley_rank % Calls the script with the inputs: 
                    % Model
                    % Experimental scheme + data + noise
                    % PE problem formulation: cost function and unknowns to be estimated
                    % Numerical approaches for  simulation and optimization

AMIGO_Prep(inputs)  % Calls the task for pre-processing

AMIGO_GRank(inputs)    % Calls the task for Global Rank


