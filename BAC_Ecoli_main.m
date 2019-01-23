
% Files BAC_Ecoli_main and BAC_Ecoli_model should be located inside the inputs folder in AMIGO path
% To Run this file go to the inputs folder in AMIGO path

%% ========================================================================
%               Initilize toolbox and model preprocessor
%  ========================================================================
clear all

amigo_path=input('write amigo path (example: foo/AMIGO2R2017a ) :','s')
run([amigo_path,'./AMIGO_Startup.m']);

% AMIGO prep has to be run only the first time or every time the equations of the model are changed
pick_experiments=1;
BAC_Ecoli_model;
AMIGO_Prep(inputs)


%% ========================================================================
%               Simulate final model
%  ========================================================================
pick_experiments=[1:6];
BAC_Ecoli_model;
% % uncomment the following 3 lines for Ecoli std bars different for each data point
% for ii=1:size(inputs.exps.error_data,2)
%     inputs.exps.error_data{i} = [Nlog_std{ii}' stdC*ones(size(C{ii}))];
% end
AMIGO_SData(inputs)
disp('--------------------------------------------------------------------')
disp('This is the simulation of the model with final set of parameters')
disp('Press Enter to continue')
disp('--------------------------------------------------------------------')

pause
close all

%% ========================================================================
%              Optimize set of parameters
% Maximixing log-likelihood with constant standard deviations for each state
%  ========================================================================
pick_experiments=[1:6];BAC_Ecoli_model;

%%% uncomment next to assume that the specific BAC uptake is constant
% inputs.model.par= [		3.2177 	1.34233 	1.07536 	6.74427 0];
% inputs.PEsol.global_theta_guess= inputs.model.par(1:4);
% inputs.PEsol.id_global_theta=char('k','x','n','a');                         % 'all'|User selected
% inputs.PEsol.global_theta_max=   [ 5  3 3 9 ];    % Maximum allowed values for the paramtersv
% inputs.PEsol.global_theta_min=  [ 1 1 1 0  ];       % Minimum allowed values for the parameters
% inputs.nlpsol.eSS.maxtime = 60;

AMIGO_PE(inputs)
disp('--------------------------------------------------------------------')
disp('This is the optimization of the parameters')
disp('Press Enter to continue')
disp('--------------------------------------------------------------------')

pause
close all
%% ========================================================================
%              Cross-validation
%  ========================================================================

for ii=1:6
    
pick_experiments=setdiff([1:6],ii);
BAC_Ecoli_model;
inputs.plotd.plotlevel='none';  
res=AMIGO_PE(inputs);


pick_experiments=ii;BAC_Ecoli_model;
inputs.model.par=res.fit.thetabest;

AMIGO_SData(inputs)

end
disp('--------------------------------------------------------------------')
disp('This is the cross-validation')
disp('--------------------------------------------------------------------')



