% $Header: svn://.../trunk/AMIGO_R2012_cvodes/Examples/Arabidopsis_circadian/circadian_oed.m 2095 2015-09-15 08:23:21Z evabalsa $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: The circadian clock in Arabidopsis thaliana
%
%        Type :
%                > help circadian_tutorial
%        for a more detailed description of the model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%        INPUT FILE FOR OPTIMAL EXPERIMENTAL DESIGN
%        Default values are assigned to non defined inputs.
%
%        Minimum required inputs:
%           > Paths related data
%           > Model:               model_type; n_st; n_par; n_stimulus; 
%                                  st_names; par_names; stimulus_names;  
%                                  eqns; par
%           > Experimental scheme: n_exp; exp_y0{iexp}; t_f{iexp}; 
%                                  u_interp{iexp}; t_con{iexp}; u{iexp}
%                                  n_obs{iexp}; obs_names{iexp}; obs{iexp} 
%
%                (AMIGO_OED)==>>    n_s{iexp}; t_s{iexp}; 
%                                  data_type; noise_type; 
%                                  exp_data{iexp}; [error_data{iexp}]
%                                  id_global_theta; [id_global_theta_y0]
%                                  [id_local_theta{iexp}];[id_local_theta_y0{iexp}]global_theta_max; global_theta_min
%                                  [global_theta_y0_max];[global_theta_y0_min]
%                                  [local_theta_max{iexp}];[local_theta_min{iexp}]
%                                  [local_theta_y0_max{iexp}];[local_theta_yo_min{iexp}]
%                                  [global_theta_guess];[global_theta_y0_guess];
%                                  [local_theta_guess{iexp}];[local_theta_y0_guess{iexp}]
%                                  [PEcost_type];[lsq_type];[llk_type]
%                                  []:optional inputs
%                                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%======================
% PATHS RELATED DATA
%======================

inputs.pathd.results_folder='circadian-tutorial';         % Folder to keep results (in Results) for a given problem          
inputs.pathd.short_name='circadian';                      % To identify figures and reports for a given problem   

%======================
% MODEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelC';                % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                                           %                     'blackboxmodel'|'blackboxcost                                  
inputs.model.n_st=7;                                       % Number of states      
inputs.model.n_par=27;                                     % Number of model parameters 
inputs.model.n_stimulus=1;                                 % Number of inputs, stimuli or control variables   
inputs.model.st_names=char('CL_m','CL_c','CL_n','CT_m','CT_c','CT_n','CP_n');     % Names of the states                                              
inputs.model.par_names=char('n1','n2','g1','g2','m1','m2','m3','m4','m5','m6',...
                            'm7','k1','k2','k3','k4','k5','k6','k7','p1','p2',...
                            'p3','r1','r2','r3','r4','q1','q2');                  % Names of the parameters                     
inputs.model.stimulus_names=char('light');                                        % Names of the stimuli, inputs or controls                      
inputs.model.eqns=...                                      % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dCL_m=q1*CP_n*light+n1*CT_n/(g1+CT_n)-m1*CL_m/(k1+CL_m)',...
                    'dCL_c=p1*CL_m-r1*CL_c+r2*CL_n-m2*CL_c/(k2+CL_c)',...
                    'dCL_n=r1*CL_c-r2*CL_n-m3*CL_n/(k3+CL_n)',...
                    'dCT_m=n2*g2^2/(g2^2+CL_n^2)-m4*CT_m/(k4+CT_m)',...
                    'dCT_c=p2*CT_m-r3*CT_c+r4*CT_n-m5*CT_c/(k5+CT_c)',...
                    'dCT_n=r3*CT_c-r4*CT_n-m6*CT_n/(k6+CT_n)',...
                    'dCP_n=(1-light)*p3-m7*CP_n/(k7+CP_n)-q2*light*CP_n');              
                
inputs.model.par=[7.5038 0.6801 1.4992 3.0412 10.0982...   % Nominal value for the parameters, this allows to fix known parameters
                 1.9685 3.7511 2.3422 7.2482 1.8981 1.2 3.8045...
                 5.3087 4.1946 2.5356 1.4420 4.8600 1.2 2.1994...
                 9.4440 0.5 0.2817 0.7676 0.4364 7.3021 4.5703 1.0]; % These values may be updated during optimization  

%=====================================
%  EXPERIMENTAL SCHEME RELATED DATA
%=====================================
 inputs.exps.n_exp=3;                                 % Total number of experiments (available + experiments to be designed)     
 inputs.exps.exp_type{1}='fixed';                     % Indicates if the the experiment should
 inputs.exps.exp_type{2}='fixed';                     % or not be optimally designed : 'od' and 'fixed'
 inputs.exps.exp_type{3}='od';             

 for iexp=1:inputs.exps.n_exp   
% OBSEVABLES DEFINITION  
 inputs.exps.n_obs{iexp}=2;                            % Number of observed quantities per experiment  
 inputs.exps.obs_names{iexp}=char('Lum','mRNAa');      % Name of the observed quantities per experiment    
 inputs.exps.obs{iexp}=char('Lum=CL_m','mRNAa=CT_m'); 
 inputs.exps.exp_y0{iexp}=zeros(1,inputs.model.n_st);  % Initial conditions for each experiment  
 end           
 

 inputs.exps.u_interp{1}='sustained';                  % Stimuli definition for experiment 1:
                                                       % OPTIONS:u_interp: 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.exps.t_f{1}=120;                               % Experiment duration
 inputs.exps.t_con{1}=[0 120];                         % Input swithching times: Initial and final time    
 inputs.exps.u{1}=[1];                                 % Values of the inputs 
 inputs.exps.n_s{1}=15;                                % Number of sampling times for each experiment.
 
  inputs.exps.error_data{1}=[                            % Experimental noise, n_s{iexp}x n_obs{iexp}
		0.037642  0.059832
		0.072461  0.013999
		0.002877  0.020809
		0.050324  0.002705
		0.042936  0.017832
		0.044338  0.022538
		0.016335  0.017981
		0.164745  0.035301
		0.010631  0.102381
		0.127745  0.065791
		0.081671  0.049568
		0.126739  0.050306
		0.006308  0.018894
		0.054665  0.066953
		0.082163  0.015295
		];
 
 
 inputs.exps.u_interp{2}='pulse-down';                 % Stimuli definition for experiment 2
 inputs.exps.n_pulses{2}=5;                            % Number of pulses |-|_|-|_|-|_|-|_|-|_    
 inputs.exps.u_min{2}=0;inputs.exps.u_max{2}=1;        % Minimum and maximum value for the input
 inputs.exps.t_f{2}=120;                               % Experiment duration
 inputs.exps.t_con{2}=[0 :12: 120];                    % Times of switching: Initial time, Intermediate times, Final time
 inputs.exps.n_s{2}=25;                                % Number of sampling times for each experiment.
 
  
inputs.exps.error_data{2}=[
		0.146016  0.018152
		0.066547  0.045194
		0.184009  0.101495
		0.047431  0.030858
		0.175280  0.033712
		0.031945  0.048733
		0.107148  0.008715
		0.019847  0.072804
		0.111892  0.001840
		0.104932  0.058752
		0.059721  0.033324
		0.056537  0.000360
		0.051815  0.037473
		0.103393  0.028094
		0.008084  0.012024
		0.188444  0.022982
		0.046354  0.031981
		0.043436  0.003749
		0.030177  0.042560
		0.116245  0.110535
		0.059345  0.025112
		0.218587  0.000564
		0.115783  0.043708
		0.099239  0.002678
		0.010644  0.052990
		];
 
 
 
%
%  INPUTS FOR THE EXPERIMENT TO BE OPTIMALLY DESIGNED
%
 
 inputs.exps.u_type{3}='od';                           % Type of stimulation: 'fixed' | 'od' (to be designed) 
 inputs.exps.u_interp{3}='linear';                   % Stimuli definition for experiment 3:
                                                       % OPTIONS:u_interp:
                                                       % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.exps.n_linear{3}=5;                            % Number of interpolation points
 inputs.exps.u_min{3}=0.*ones(1,inputs.exps.n_linear{3});
 inputs.exps.u_max{3}=ones(1,inputs.exps.n_linear{3}); % Minimum and maximum value for the input
 inputs.exps.tf_type{3}='fixed';                       % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.t_f{3}=120;                               % Experiment duration
 inputs.exps.ts_type{3}='fixed';                       % [] Type of sampling times: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.n_s{3}=20;
 inputs.exps.std_dev{3}=0.1;                           % Standard deviation of the noise for each experiment: Ex: 0.05 <=> 5%


%======================================
% PARAMETERS TO BE CONSIDERED FOR OED
%======================================


% Parameters to be considered for OED 
inputs.PEsol.id_global_theta='all';  %  'all'|User selected  
% Nominal value of the parameters to compute the FIM
inputs.PEsol.global_theta_guess=inputs.model.par; 


%==================================
% COST FUNCTION RELATED DATA
%==================================    

 inputs.exps.noise_type='hetero';                    % Type of experimental noise: 'homo' |'homo_var'| 'hetero'     
 inputs.OEDsol.OEDcost_type='Eopt';                % FIM based criterium: 'Dopt'|'Eopt'|'Aopt'|'Emod'|'DoverE'
 
 
%==================================
% NUMERICAL METHODS RELATED DATA
%==================================
%
% SIMULATION

 inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0D-7; 
 
 
% OPTIMIZATION
%
inputs.nlpsol.nlpsolver='eSS';                        % [] NLP solver: 
%                                                       % LOCAL: 'local_fmincon'|'local_n2fb'|'local_dn2fb'|'local_dhc'|
%                                                       %        'local_ipopt'|'local_solnp'|'local_nomad'||'local_nl2sol'
%                                                       %        'local_lsqnonlin'
%                                                       % MULTISTART:'multi_fmincon'|'multi_n2fb'|'multi_dn2fb'|'multi_dhc'|
%                                                       %            'multi_ipopt'|'multi_solnp'|'multi_nomad'|'multi_nl2sol'
%                                                       %            'multi_lsqnonlin'
%                                                       % GLOBAL: 'de'|'sres'
%                                                       % HYBRID: 'hyb_de_fmincon'|'hyb_de_n2fb'|'hyb_de_dn2fb'|'hyb_de_dhc'|'hyp_de_ipopt'|
%                                                       %         'hyb_de_solnp'|'hyb_de_nomad'|
%                                                       %         'hyb_sres_fmincon'|'hyb_sres_n2fb'|'hyb_sres_dn2fb'|'hyb_sres_dhc'|
%                                                       %         'hyp_sres_ipopt'|'hyb_sres_solnp'|'hyb_sres_nomad'
%                                                       % METAHEURISTICS:
%                                                       % 'ess' or 'eSS' (default)
%                                                       % Note that the corresponding defaults are in files: 
%                                                       % OPT_solvers\DE\de_options.m; OPT_solvers\SRES\sres_options.m; 
%                                                       % OPT_solvers\eSS_**\ess_options.m
%                                                       

inputs.nlpsol.eSS.maxeval = 10000;
inputs.nlpsol.eSS.maxtime = 60;
inputs.nlpsol.eSS.local.solver = 'fmincon';
inputs.nlpsol.eSS.local.finish = 'fmincon';
                                                       
inputs.nlpsol.multi_starts=500;                        % [] Number of different initial guesses to run local methods in the multistart approach
inputs.nlpsol.multistart.maxeval = 20000;            % Maximum number of function evaluations for the multistart
inputs.nlpsol.multistart.maxtime = 120;                % Maximum allowed time for the optimization
inputs.nlpsol.eSS.local.nl2sol.maxiter             =     300;        % max number of iteration
inputs.nlpsol.eSS.local.nl2sol.maxfeval            =     400;         % max number of function evaluation
% 
% 
% %==================================
% % DISPLAY OF RESULTS
% %==================================
% 
 results.plotd.plotlevel='full';                       % [] Display of figures: 'full'|'medium'(default)|'min' |'noplot' 
% results.plotd.epssave=0;                              % [] Figures may be saved in .eps (1) or only in .fig format (0) (default)
% results.plotd.number_max_states=8;                    % [] Maximum number of states per figure
% results.plotd.number_max_obs=8;                       % [] Maximum number of observables per figure
% results.plotd.n_t_plot=100;                           % [] Number of times to be used for observables and states plots
% results.plotd.contour_rtol=1e-7;                      % [] Integration tolerances for the contour plots. 
% results.plotd.contour_atol=1e-7;                      %    ADVISE: These tolerances should be a little bit strict
%  results.plotd.nx_contour=100;                          % [] Number of points for plotting the contours x and y direction
%  results.plotd.ny_contour=100;                          %    ADVISE: >=50
% results.plotd.number_max_hist=8;                      % [] Maximum number of unknowns histograms per figure (multistart)
% 
%  




