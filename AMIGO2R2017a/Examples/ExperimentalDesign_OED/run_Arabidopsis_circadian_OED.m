ed
% RUN Arabidopsis circadian clock optimal design of experiments

clear all;

cprintf('*[1,0.5,0]','\n\n --->Design of a new experiment: step-wise interpolation and Eopt design')

Arabidopsis_circadian_OED_step  % Calls the script with the inputs: 
                                % Model
                                % Experimental scheme +  noise info
                                % OED problem formulation: cost function
                                % and unknowns to be considered
                                % Numerical approaches for  simulation and optimization

AMIGO_Prep(inputs)         % Calls the task for pre-processing

warning off
AMIGO_OED(inputs)           % Calls the task for Parameter Estimation


