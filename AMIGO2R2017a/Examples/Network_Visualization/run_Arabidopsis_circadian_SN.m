% Network visualization with cytoscape
clear;

cprintf('*[1,0.5,0]','\n\n --->Requirements to run the example: CYTOSCAPE');

pause(2)

cprintf('*[1,0.5,0]','\n\n --->Shows network');

pause(2)
Arabidopsis_circadian_SM;
inputs.model.shownetwork = 1;
AMIGO_Prep(inputs)


cprintf('*[1,0.5,0]','\n\n --->Shows network with observables');

pause(2)

Arabidopsis_circadian_SObs;
inputs.model.shownetwork = 1;
AMIGO_Prep(inputs)
