% $Header: svn://.../trunk/AMIGO_R2012_cvodes/Examples/batch_bac_growth/batch_bac_growth_OED.m 2087 2015-09-09 10:13:12Z evabalsa $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: The Hodgkin–Huxley model
% Type :
%           > help Hodgkin–Huxley
% for a more detailed description.
%
% NOTE!!!: [] indicates that the corresponding input may be omitted,
%              default value will be assigned
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='Bacterial_batch_growth'; % Folder to keep results (in Results) for a given problem                       
inputs.pathd.short_name='bbg';                       % To identify figures and reports for a given problem 
                                                     % ADVISE: the user may introduce any names related to the problem at hand 
inputs.pathd.runident='r1';                         % [] Identifier required in order not to overwrite previous results
                                                     %    This may be modified from command line. 'run1'(default)
                                                     

%============================
% MODEL RELATED DATA
%============================
inputs.model.input_model_type='charmodelC';          % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                                     %                     'blackboxmodel'|'blackboxcost                   
inputs.model.n_st=2;                                 % Number of states                                  
inputs.model.n_par=4;                                % Number of model parameters                                  
inputs.model.n_stimulus=0;                           % Number of inputs, stimuli or control variables   
inputs.model.names_type='custom';                    % [] Names given to states/pars/inputs: 'standard' (x1,x2,...p1,p2...,u1, u2,...) 
                                                     %                                       'custom'(default)
inputs.model.st_names=char('cb','cs');     % Names of the states                                         
inputs.model.par_names=char('mumax','ks','kd','yield');             % Names of the parameters                   
inputs.model.stimulus_names=[];          % Names of the stimuli, inputs or controls                                  
inputs.model.eqns=...                                % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
            char('dcb=((mumax*cs*cb)/(ks+cs))-kd*cb',...  
                 'dcs= -((mumax*cs*cb)/(ks+cs))/yield');
   
 mumax=0.4; %0.4
 ks=5.0;  %
 kd=0.05;  % r1:0.0
 yield=0.5;  %r1:0.55;            
 inputs.model.par=[mumax ks kd yield];      % Nominal value for the parameters, this allows to fix known parameters
                                                      % These values may be updated during optimization  

%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================

 inputs.exps.n_exp=2;                                 % Number of experiments         
 
 %==================================
 % DEFINITION OF EXPERIMENT 1: FIXED
 %==================================
 inputs.exps.exp_type{1}='fixed';  
 inputs.exps.n_obs{1}=2;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{1}=char('obsB','obsS');               % Name of the observed quantities per experiment    
 inputs.exps.obs{1}=char('obsB=cb','obsS=cs');                  % Observation function
 inputs.exps.exp_y0{1}=[2 30];       % Initial conditions for each experiment   
 inputs.exps.t_f{1}=10;                               % Experiments duration
 inputs.exps.n_s{1}=11;                               % Number of sampling times
 inputs.exps.t_s{1}=[0:1:10];                         % [] Sampling times, by default equidistant
                                                                      
% 		Error data 1: 
		inputs.exps.error_data{1}=[
		0.642563  1.418734
		0.750319  1.656654
		0.755610  1.668335
		0.831913  1.836808
		0.658943  1.454901
		0.370148  0.817263
		0.848267  1.872915
		0.920692  2.032825
		1.140131  2.517332
		0.092449  0.204122
		0.850306  1.877418
		];

 %===========================================
 % DEFINITION OF EXPERIMENT 2: TO BE DESIGNED
 %===========================================
 inputs.exps.exp_type{2}='od';     
 inputs.exps.n_obs{2}=2;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{2}=char('obsB','obsS');        % Name of the observed quantities per experiment    
 inputs.exps.obs{2}=char('obsB=cb','obsS=cs');        % Observation function
 
 %Initial conditions to be designed
 inputs.exps.exp_y0_type{2}='od';
 inputs.exps.id_y0{2}=char('cb','cs');
 inputs.exps.y0_min{2}=[1 5];                         % MIN: Initial conditions for each experiment 
 inputs.exps.y0_max{2}=[5 40];                        % MAX:Initial conditions for each experiment 
 inputs.exps.y0_guess{2}=[3 20];                      % MAX:Initial conditions for each experiment 

 inputs.exps.tf_type{2}='fixed';                   % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.t_f{2}=15;
 
 inputs.exps.ts_type{2}='od';                      % [] Type of sampling times: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.ts_0{2}=0;                            % First sampling time. By default=0 
 inputs.exps.ts_min_dist{2}=1;                     % Minimum distance between sampling times
 inputs.exps.max_ns{2} = 10;                        % Maximum number of sampling times 
 inputs.exps.std_dev{2}=[0.1 0.1];                 % Standard deviation of the noise for each experiment: Ex: 0.05 <=> 5%
                                                                 
  
 
%======================================
% PARAMETERS TO BE CONSIDERED FOR OED
%======================================
 inputs.PEsol.id_global_theta='all';    
 inputs.PEsol.global_theta_guess=[0.411636590271240 6.744866335047434 0.039525613375224 0.482112704417673]; % best obtained with llk   
      

 %==================================
 % COST FUNCTION RELATED DATA
 %==================================
 inputs.exps.noise_type='hetero';                    % Type of experimental noise: 'homo' |'homo_var'| 'hetero'     
 inputs.OEDsol.OEDcost_type='Eopt';                  % FIM based criterium: 'Dopt'|'Eopt'|'Aopt'|'Emod'|'DoverE'
 
 %==================================
 % NUMERICAL METHODS RELATED DATA
 %==================================
 %
 % SIMULATION
 inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'cvodes'(default, C)|'ode15s' (default, MATLAB, sbml)|'ode113'|'ode45'
 inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes'(default, C)| 'sensmat'(matlab)|'fdsens2'|'fdsens5' 

 inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0D-7; 
% 
% 
% OPTIMIZATION

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
%inputs.nlpsol.eSS.log_var = 1:4;
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
 results.plotd.nx_contour=100;                          % [] Number of points for plotting the contours x and y direction
 results.plotd.ny_contour=100;                          %    ADVISE: >=50
% results.plotd.number_max_hist=8;                      % [] Maximum number of unknowns histograms per figure (multistart)
% 
%  
