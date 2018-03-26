
% RUN Park-Ramirez bioreactor optimal control 


clear all;

% Case 1: Step-wise control interpolation 

cprintf('*[1,0.5,0]','\n\n ---> Solving Park-Ramirez bioreactor optimal control problem with 20 STEPS- CONTROL INTERPOLATION');
PRbioreactor                    % Calls the script with the inputs: 
                           % Model, objective and constraints
                           % CPV implementation
                           % Numerical approaches for simulation & optimization 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_DO(inputs)           % Calls the task for dynamic optimization


% Case 2: Step-wise control interpolation with mesh refining

cprintf('*[1,0.5,0]','\n\n ---> Solving Park-Ramirez bioreactor optimal control problem with CONTROL REFINEMENT');
pause(2)
clear all;


PRbioreactor 
inputs.pathd.runident='20step_2reopt';        % Run identifieer
inputs.nlpsol.reopt='on';                     % Reoptimization after convergence

AMIGO_DO(inputs)             % Calls the task for dynamic optimization



% Case 3: LinearF-wise control interpolation

cprintf('*[1,0.5,0]','\n\n ---> Solving Park-Ramirez bioreactor optimal control problem with LINEARF CONTROL INTERPOLATION PLUS REFINEMENT');
pause(2)
clear all;


PRbioreactor_linearf 

AMIGO_DO(inputs)             % Calls the task for dynamic optimization



% Case 4: Linear-wise control interpolation

cprintf('*[1,0.5,0]','\n\n ---> Solving Park-Ramirez bioreactor optimal control problem with LINEAR CONTROL ');
pause(2)
clear all;


PRbioreactor_linear 
AMIGO_DO(inputs)             % Calls the task for dynamic optimization