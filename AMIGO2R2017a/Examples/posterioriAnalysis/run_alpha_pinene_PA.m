% Tutorial example 2. 
% coded: Attila Gabor
clc
clear
% In this tutorial we do a parameter estmation defined in AMIGO:
alphaPinene_postAnalisis_pe;

% this generates the inputs structure.
AMIGO_Prep(inputs);
 
% Do the parameter estimation:
results = AMIGO_PE(inputs);

% run the test. See the commandline for the details. 
stat = AMIGO_PEPostAnalysis(inputs, results);