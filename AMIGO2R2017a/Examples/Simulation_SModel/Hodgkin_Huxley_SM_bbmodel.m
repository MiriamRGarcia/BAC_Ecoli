% $Header: svn://.../trunk/AMIGO2R2016/Examples/Hodgkin-Huxley_model/HH_bbmodel.m 2410 2015-12-07 13:58:57Z evabalsa $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: The Hodgkin�Huxley model
% Type :
%           > help Hodgkin�Huxley
% for a more detailed description.
%
% NOTE!!!: [] indicates that the corresponding input may be omitted,
%              default value will be assigned
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================
% RESULTS PATHS RELATED DATA
%============================
results.pathd.results_folder='Hodgkin-Huxley_model'; % Folder to keep results (in Results) for a given problem                       
results.pathd.short_name='HH';                       % To identify figures and reports for a given problem 
                                                     % ADVISE: the user may introduce any names related to the problem at hand 
results.pathd.runident='run1';                       % [] Identifier required in order not to overwrite previous results
                                                     %    This may be modified from command line. 'run1'(default)
                                                     

%============================
% MODEL RELATED DATA
%============================
inputs.model.input_model_type='blackboxmodel';       % Model introduction: 'charmodel'|'matlabmodel'|'sbmlmodel'|'fortranmodel'|                        
                                                     %                     'blackboxmodel'|'blackboxcost    
inputs.model.blackboxmodel_file='HHbbmodel';         % File including the system dynamics
inputs.model.n_st=4;                                 % Number of states                                  
inputs.model.n_par=7;                                % Number of model parameters                                  
inputs.model.n_stimulus=1;                           % Number of inputs, stimuli or control variables   
inputs.model.names_type='custom';                    % [] Names given to states/pars/inputs: 'standard' (x1,x2,...p1,p2...,u1, u2,...) 
                                                     %                                       'custom'(default)
inputs.model.st_names=char('yv','yn','ym','yh');     % Names of the states                                         
inputs.model.par_names=char('gNa','gK','gL','VNa',...
                        'VK','VL','Cm');             % Names of the parameters                   
inputs.model.stimulus_names=char('TotalI');          % Names of the stimuli, inputs or controls                                  
             
inputs.model.par=[120 36 0.3 -115 12 -10.613 1];         % Nominal value for the parameters, this allows to fix known parameters
                                                      % These values may be updated during optimization  

%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================

 inputs.exps.n_exp=2;                                 % Number of experiments                                                                  
 inputs.exps.n_obs{1}=1;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{1}=char('obsV');               % Name of the observed quantities per experiment    
 inputs.exps.obs{1}=char('obsV=yv');                  % Observation function
 inputs.exps.exp_y0{1}=[0 0.3177 0.053 0.5959];       % Initial conditions for each experiment       
 inputs.exps.t_f{1}=40;                               % Experiments duration
 inputs.exps.n_s{1}=11;                               % Number of sampling times
 inputs.exps.t_s{1}=[0:4:40];                         % [] Sampling times, by default equidistant
 
 inputs.exps.u_interp{1}='pulse-down';                % [] Stimuli definition: u_interp: 'sustained' |'step'|'linear'(default)|
                                                      %                               'pulse-up'|'pulse-down'
 inputs.exps.n_pulses{1}=1;                           % Number of pulses
 inputs.exps.u_min{1}=0;inputs.exps.u_max{1}=5;       % Bounds for the stimuli
 inputs.exps.t_con{1}=[0 20 40];                      % Initial time-Times of changes for the stimuli- Final stimulation time
                                                              
 
%==================================
% EXPERIMENTAL DATA RELATED INFO
%==================================
inputs.exps.data_type='real';                         % Type of data: 'pseudo'|'pseudo_pos'|'real'             
inputs.exps.noise_type='homo_var';                    % Experimental noise type: Homoscedastic: 'homo'|'homo_var'(default) 
inputs.exps.exp_data{1}=[0.631115                     % Experimental data per experiment n_s{iexp}x n_obs{iexp}
     	2.984205                                      
 		3.898819                                      
 		5.230199
 		4.198258
 		6.030247
 		3.295123
 		2.757383
 		1.800544
 		2.646096
 		2.625807 ];
inputs.exps.error_data{1}=[0.631115                   % Experimental noise, n_s{iexp}x n_obs{iexp}
 	1.029894
	0.710533
	0.213145
	1.100637
    0.535369
	0.093470
	0.005238
    0.580152
	0.576005
    0.818062];


inputs.exps.n_obs{2}=1;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{2}=char('obsV');               % Name of the observed quantities per experiment    
 inputs.exps.obs{2}=char('obsV=yv');                  % Observation function
 inputs.exps.exp_y0{2}=[0 0.3177 0.053 0.5959];       % Initial conditions for each experiment       
 inputs.exps.t_f{2}=36;                               % Experiments duration
 inputs.exps.n_s{2}=10;                               % Number of sampling times
 inputs.exps.t_s{2}=[0:4:36];                         % [] Sampling times, by default equidistant
 
 inputs.exps.u_interp{2}='pulse-down';                % [] Stimuli definition: u_interp: 'sustained' |'step'|'linear'(default)|
                                                      %                               'pulse-up'|'pulse-down'
 inputs.exps.n_pulses{2}=1;                           % Number of pulses
 inputs.exps.u_min{2}=0;inputs.exps.u_max{2}=5;       % Bounds for the stimuli
 inputs.exps.t_con{2}=[0 20 36];                      % Initial time-Times of changes for the stimuli- Final stimulation time
                                                              
 
%==================================
% EXPERIMENTAL DATA RELATED INFO
%==================================
inputs.exps.data_type='real';                         % Type of data: 'pseudo'|'pseudo_pos'|'real'             
inputs.exps.noise_type='homo_var';                    % Experimental noise type: Homoscedastic: 'homo'|'homo_var'(default) 
inputs.exps.exp_data{2}=[0.631115                     % Experimental data per experiment n_s{iexp}x n_obs{iexp}
     	2.984205                                      
 		3.898819                                      
 		5.230199
 		4.198258
 		6.030247
 		3.295123
 		2.757383
 		1.800544
 		2.646096];
inputs.exps.error_data{2}=[0.631115                   % Experimental noise, n_s{iexp}x n_obs{iexp}
 	1.029894
	0.710533
	0.213145
	1.100637
    0.535369
	0.093470
	0.005238
    0.580152
	0.576005];

%==================================
% UNKNOWNS RELATED DATA
%==================================

% GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERIMENTS)

inputs.PEsol.id_global_theta='all';                         % 'all'|User selected 
inputs.PEsol.global_theta_max=[200 200 200 0 200 0 200];    % Maximum allowed values for the paramters
inputs.PEsol.global_theta_min=[0 0 0 -200 0 -200 1e-5 ];       % Minimum allowed values for the parameters
inputs.PEsol.global_theta_guess=[25.8253 14.0348 1.6784 -9.7663 17.9492 0 5.6786];                        % [] Initial guess


%==================================
% COST FUNCTION RELATED DATA
%==================================
         
inputs.PEsol.PEcost_type='lsq';                       % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'user_PEcost' 
inputs.PEsol.lsq_type='Q_I';                         % [] To be defined for lsq function, Weighting lsq matrix: 'Q_I' | 'Q_expmax' 
inputs.PEsol.llk_type='homo_var';                     % [] To be defined for llk function, 'homo' | 'homo_var' | 'hetero' 

%==================================
% NUMERICAL METHODS RELATED DATA
%==================================
%
% SIMULATION
inputs.ivpsol.ivpsolver='ode15s';                     % [] IVP solver: 'radau5'(default, fortran)|'rkf45'|'lsodes'|
                                                      %                'lsodesst'|'lsoda'|
                                                      %                'ode15s' (default, MATLAB, sbml)|'ode113'
inputs.ivpsol.senssolver='fdsens5';                    % [] Sensitivities solver: 'cvodes' (C)
                                                      %                          'sensmat' (matlab) |
                                                      %                          'fdsens2' (finite differences)
inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
inputs.ivpsol.atol=1.0D-7; 

%
% OPTIMIZATION
inputs.nlpsol.nlpsolver='ssm';                        % [] NLP solver: 
                                                      % LOCAL: 'local_fmincon'|'local_n2fb'|'local_dn2fb'|'local_dhc'|
                                                      %        'local_ipopt'|'local_solnp'|'local_nomad'| 
                                                      % MULTISTART:'multi_fmincon'|'multi_n2fb'|'multi_dn2fb'|'multi_dhc'|
                                                      %            'multi_ipopt'|'multi_solnp'|'multi_nomad'|'multi_fsqp'|'multi_misqp'
                                                      % GLOBAL: 'de'|'sres'
                                                      % HYBRID: 'hyb_de_fmincon'|'hyb_de_n2fb'|'hyb_de_dn2fb'|'hyb_de_dhc'|'hyp_de_ipopt'|
                                                      %         'hyb_de_solnp'|'hyb_de_nomad'|
                                                      %         'hyb_sres_fmincon'|'hyb_sres_n2fb'|'hyb_sres_dn2fb'|'hyb_sres_dhc'|
                                                      %         'hyp_sres_ipopt'|'hyb_sres_solnp'|'hyb_sres_nomad'
                                                      % METAHEURISTICS: 'ess' or 'eSS' (default)
                                                      
                                                      % Note that the corresponding defaults are in files: 
                                                      % OPT_solvers\DE\de_options.m; OPT_solvers\SRES\sres_options.m; 
                                                      % OPT_solvers\eSS_**\ess_options.m
                                                      
inputs.nlpsol.multi_starts=200;                       % [] Number of different initial guesses to run local methods in the multistart approach

%==================================
% RIdent or GRank DATA
%==================================
%

inputs.rid.conf_ntrials=500;                          % [] Number of trials for the robust confidence computation (default: 500)
inputs.rank.gr_samples=10000;                         % [] Number of samples for global sensitivities and global rank within LHS (default: 10000)    


%==================================
% DISPLAY OF RESULTS
%==================================

results.plotd.plotlevel='full';                       % [] Display of figures: 'full'|'medium'(default)|'min' |'noplot' 
results.plotd.epssave=0;                              % [] Figures may be saved in .eps (1) or only in .fig format (0) (default)
results.plotd.number_max_states=8;                    % [] Maximum number of states per figure
results.plotd.number_max_obs=8;                       % [] Maximum number of observables per figure
results.plotd.n_t_plot=100;                           % [] Number of times to be used for observables and states plots
results.plotd.contour_rtol=1e-7;                      % [] Integration tolerances for the contour plots. 
results.plotd.contour_atol=1e-7;                      %    ADVISE: These tolerances should be a little bit strict
results.plotd.nx_contour=60;                          % [] Number of points for plotting the contours x and y direction
results.plotd.ny_contour=60;                          %    ADVISE: >=50
results_def.plotd.number_max_hist=8;                  % [] Maximum number of unknowns histograms per figure (multistart)


