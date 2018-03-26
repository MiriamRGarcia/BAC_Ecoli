
% Computes and plots PE cost function contours

clear all;

cprintf('*[1,0.5,0]','\n\n ---> Computing contour plots for the LSQ function');

pause(1)
alpha_pinene_CP     % Calls the script with the inputs: 
                    % Model
                    % Experimental scheme + data + noise
                    % PE problem formulation: cost function and unknowns to be estimated
                    % Numerical approaches for  simulation and optimization

AMIGO_Prep(inputs)  % Calls the task for pre-processing      

AMIGO_ContourP(inputs)    % Calls the task for contour plot


cprintf('*[1,0.5,0]','\n\n ---> Computing contour plots for the LLK function');
pause(1)
inputs.pathd.runident='rllk';      % identifier for the results folder
inputs.PEsol.PEcost_type='llk';    % log-likelihood function
inputs.PEsol.llk_type='homo_var';     % homo noise - known constant noise
 
AMIGO_ContourP(inputs)    % Calls the task for contour plot