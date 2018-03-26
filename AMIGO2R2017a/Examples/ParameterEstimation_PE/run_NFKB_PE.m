
% RUN NFKB parameter estimation example
clear all;

NFKB_PE              % Calls the script with the inputs: 
                     % Model
                     % Experimental scheme + data + noise
                     % PE problem formulation: cost function and unknowns to be estimated
                     % Numerical approaches for  simulation and optimization
thisC=computer;                    
switch thisC                    
case 'MACI64'       
cprintf('*[1,0,0]','\n\n --->IMPORTANT: Your are using a MAC computer');        
cprintf('*[1,0,0]','\n\n --->To use fortran based solvers n2fb or nl2sol you will need to update your gfortran library');
cprintf('*[1,0,0]','\n\n --->Please follow the instructions in README_EXAMPLES.');
cprintf('*[1,0,0]','\n\n --->For this run, solvers are being changed to an alternative.\n');

inputs.nlpsol.eSS.local.solver = 'lsqnonlin';
inputs.nlpsol.eSS.local.finish = 'lsqnonlin';
pause(10)
        
end
AMIGO_Prep(inputs)   % Calls the task for pre-processing

cprintf('*[1,0.5,0]','\n\n --->Parameter estimation using data from one experiment (sustained stimulation)');
pause(1)

AMIGO_PE(inputs)     % Calls the task for Parameter Estimation


cprintf('*[1,0.5,0]','\n\n --->Parameter estimation using data from two experiments (sustained + pulse downstimulation)');
pause(1)

inputs.exps.n_exp=2;
AMIGO_PE(inputs)     % Calls the task for Parameter Estimation

