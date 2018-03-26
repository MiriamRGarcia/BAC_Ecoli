
% Computes confidence intervals by means of Monte Carlo approach

clear all;

cprintf('*[1,0.5,0]','\n\n --->Robust Identifiability analysis. This may take a while...')

pause(1)
alpha_pinene_RI     % Calls the script with the inputs: 
                    % Model
                    % Experimental scheme + data + noise
                    % PE problem formulation: cost function and unknowns to be estimated
                    % Numerical approaches for  simulation and optimization

AMIGO_Prep(inputs)  % Calls the task for pre-processing      

AMIGO_RIdent(inputs)    % Calls the task for contour plot


