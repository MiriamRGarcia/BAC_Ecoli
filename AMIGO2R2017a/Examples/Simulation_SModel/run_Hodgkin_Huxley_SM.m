% RUNS simulation with C Model, Matlab model and blackbox model
warning off;
% RUN Hodgkin-Huxley model simulation
clear all;
cprintf('*[1,0.5,0]','\n\n --->Simulating the model with C model and CVODES ....')
pause(1)

Hodgkin_Huxley_SM          % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme (number of experiments initial 
                           % & stimulation conditions, final time - per experiment) 
                           % Numerical approaches for simulation 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_SModel(inputs)       % Calls the task for Model simulation


clear all;
close all;


cprintf('*[1,0.5,0]','\n\n --->Simulating the model with a MATLAB model provided by user and ode45 ....')
pause(1)

Hodgkin_Huxley_SM_matlabmodel          % Calls the script with the inputs: 
                                       % Model function
                                       % Experimental scheme (number of experiments initial 
                                       % & stimulation conditions, final time - per experiment) 
                                       % Numerical approaches for simulation 

AMIGO_Prep(inputs)                     % Calls the task for pre-processing

AMIGO_SModel(inputs)                   % Calls the task for Model simulation


clear all;
close all;


cprintf('*[1,0.5,0]','\n\n --->Simulating the model with a BLACKBOX model provided by user ....')
pause(1)

Hodgkin_Huxley_SM_bbmodel              % Calls the script with the inputs: 
                                       % Model simulator
                                       % Experimental scheme (number of experiments initial 
                                       % & stimulation conditions, final time - per experiment) 

AMIGO_Prep(inputs)                     % Calls the task for pre-processing

AMIGO_SModel(inputs)                   % Calls the task for Model simulation


clear all;
