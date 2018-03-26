
% Computes Hodgkin-Huxley model local parametric sensitivities and 
% rank or parameters 

clear all;

Hodgkin_Huxley_rank % Calls the script with the inputs: 
                    % Model
                    % Experimental scheme + data + noise
                    % PE problem formulation: cost function and unknowns to be estimated
                    % Numerical approaches for  simulation and optimization

AMIGO_Prep(inputs)  % Calls the task for pre-processing

AMIGO_LRank(inputs)    % Calls the task for Local Rank


