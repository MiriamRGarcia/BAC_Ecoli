
% RUN vpol dynamic optimization 


clear all;

% Case 1: Step-wise control interpolation 

cprintf('*[1,0.5,0]','\n\n ---> Solving VPOL optimal control problem with two objectives and NSGA2');

vpol_multiobj              % Calls the script with the inputs: 
                           % Model, objective and constraints
                           % CPV implementation
                           % Numerical approaches for simulation & optimization 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_DO(inputs)           % Calls the task for dynamic optimization


% Case 2: Step-wise control interpolation with mesh refining

cprintf('*[1,0.5,0]','\n\n ---> Solving VPOL optimal control problem with two objectives and WSM');

pause(2)
clear all;


vpol_multiobj_wsm

AMIGO_DO(inputs)             % Calls the task for dynamic optimization



