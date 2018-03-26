
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: Dynamic Flux Balance Analysis of Diauxic Growth in Escherichia
%        coli
%        From:
%        Mahadevan R., Edwards J.S., Doyle FJ III
%        Biophysical J. 83:1331-1340, 2002
%
%        This example considers the Instantaneous Objective function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Case 1: Run the problem for final biomass maximization -step
% interpolation

cprintf('*[1,0.5,0]','\n\n ---> Solving DFBA problem with step-wise flux interpolation- Final biomass');
mahadevan_final_obj        % Calls the script with the inputs: 
                           % Model, objective and constraints
                           % CPV implementation
                           % Numerical approaches for simulation & optimization 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_DO(inputs)           % Calls the task for dynamic optimization
 

% Case 2: Run the problem for final biomass maximization -linear
% interpolation
clear all;
cprintf('*[1,0.5,0]','\n\n ---> Solving DFBA problem with Linear flux interpolation- Final biomass');
mahadevan_final_obj_linear % Calls the script with the inputs: 
                           % Model, objective and constraints
                           % CPV implementation
                           % Numerical approaches for simulation & optimization 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_DO(inputs)           % Calls the task for dynamic optimization


% Case 3: Run the problem for instant biomass maximization -step
% interpolation
clear all;
cprintf('*[1,0.5,0]','\n\n ---> Solving DFBA problem with step-wise flux interpolation- Instant biomass');
mahadevan_instant_obj        % Calls the script with the inputs: 
                           % Model, objective and constraints
                           % CPV implementation
                           % Numerical approaches for simulation & optimization 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_DO(inputs)           % Calls the task for dynamic optimization
 

% Case 4: Run the problem for instat biomass maximization -linear
% interpolation
clear all;
cprintf('*[1,0.5,0]','\n\n ---> Solving DFBA problem with Linear flux interpolation- Instant biomass');
mahadevan_instant_obj_linear % Calls the script with the inputs: 
                           % Model, objective and constraints
                           % CPV implementation
                           % Numerical approaches for simulation & optimization 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_DO(inputs)           % Calls the task for dynamic optimization