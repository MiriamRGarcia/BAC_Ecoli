
% RUN Hodgkin-Huxley model simulation -- shows observables
clear all;

Hodgkin_Huxley_SObs        % Calls the script with the inputs: 
                           % Model
                           % Experimental scheme (number of experiments initial 
                           % & stimulation conditions, OBSERVBLES, final time - per experiment) 
                           % Numerical approaches for simulation 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_SObs(inputs)         % Calls the task for simulating observables


