%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: Bacterial growth in batch culture 
% Author: E. Balsa-Canto
% Read batch_bac_growht.pdf for details on the implementation and use of 
% this script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='Bacterial_batch_growth'; % Folder to keep results (in Results) for a given problem                       
inputs.pathd.short_name='bbg';                        % To identify figures and reports for a given problem 
                                                       % ADVISE: the user may introduce any names related to the problem at hand 
inputs.pathd.runident='r1';                           % [] Identifier required in order not to overwrite previous results
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
inputs.model.st_names=char('cb','cs');               % Names of the states                                         
inputs.model.par_names=char('mumax','ks','kd','yield');             % Names of the parameters                   
inputs.model.stimulus_names=[];                      % Names of the stimuli, inputs or controls                                  
inputs.model.eqns=...                                % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
            char('dcb=((mumax*cs*cb)/(ks+cs))-kd*cb',...  
                 'dcs= -((mumax*cs*cb)/(ks+cs))/yield');
   
 mumax=0.4;  ks=5.0;  kd=0.05;  yield=0.5;             
 inputs.model.par=[mumax ks kd yield];               % Nominal value for the parameters, this allows to fix known parameters
                                                     % These values may be updated during optimization  

%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================
 inputs.exps.n_exp=1;                                 % Number of experiments                                                                  
 inputs.exps.n_obs{1}=2;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{1}=char('obsB','obsS');               % Name of the observed quantities per experiment    
 inputs.exps.obs{1}=char('obsB=cb','obsS=cs');                  % Observation function
 inputs.exps.exp_y0{1}=[2 30];       % Initial conditions for each experiment       
 inputs.exps.t_f{1}=10;                               % Experiments duration
 inputs.exps.n_s{1}=11;                               % Number of sampling times
 inputs.exps.t_s{1}=[0:1:10];                         % [] Sampling times, by default equidistant                                                            
 
%==================================
% EXPERIMENTAL DATA RELATED INFO
%==================================
 inputs.exps.data_type='real';                         % Type of data: 'pseudo'|'pseudo_pos'|'real'             
 inputs.exps.noise_type='homo_var';                    % Experimental noise type: Homoscedastic: 'homo'|'homo_var'(default) 
 
%Experimental data 1: 
		inputs.exps.exp_data{1}=[
		2  30
		3.427416  30.070197
		4.327182  27.982535
		5.573109  25.398668
		6.903522  21.463701
		7.746591  14.732211
		11.144492  12.144533
		11.502175  2.846148
		14.727507  3.754483
		13.532032  0.378159
		13.708051  1.899270];

%Error data 1: 
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
		0.850306  1.877418];

  
 %==================================
 % UNKNOWNS RELATED DATA
 %==================================
 
 % GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERIMENTS)
 inputs.PEsol.id_global_theta='all';             % 'all'|User selected 
 inputs.PEsol.global_theta_max=[10 10 10 10];    % Maximum allowed values for the paramters
 inputs.PEsol.global_theta_min= [0 0 0 0];       % Minimum allowed values for the parameters
 inputs.PEsol.global_theta_guess=[   0.4116
    6.7445
    0.0395
    0.4821]';                                    % [] Initial guess values for the parameters
                                                 %    OPTIMUM found

 %==================================
 % COST FUNCTION RELATED DATA
 %==================================       
 inputs.PEsol.PEcost_type='llk';                       % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'user_PEcost' 
  
 inputs.PEsol.lsq_type='Q_I';
 inputs.PEsol.llk_type='homo_var';                     % [] To be defined for llk function, 'homo' | 'homo_var' | 'hetero' 
 
%==================================
% NUMERICAL METHODS RELATED DATA
%==================================

% SIMULATION
inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'cvodes'(default, C)|'ode15s' (default, MATLAB, sbml)|'ode113'|'ode45'
                                                       %                'lsodesst'|'lsoda'|
                                                       %                'ode15s' (default, MATLAB, sbml)|'ode113'
inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes'(default, C)| 'sensmat'(matlab)|'fdsens2'|'fdsens5' 
                                                       %                          'sensmat' (matlab) |
                                                       %                          'fdsens2','fdsens5' (finite differences)
 inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0D-7; 
 

% OPTIMIZATION

inputs.nlpsol.nlpsolver='local_lsqnonlin';                        % [] NLP solver: 
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


 
%==================================
% RIdent or GRank DATA
%==================================
 inputs.rid.conf_ntrials=500;                          % [] Number of trials for the robust confidence computation (default: 500)

 
%==================================
% DISPLAY OF RESULTS
%==================================
% 
inputs.plotd.plotlevel='full';                        % [] Display of figures: 'full'|'medium'(default)|'min' |'noplot' 
inputs.plotd.figsave=1;
% inputs.plotd.epssave=0;                              % [] Figures may be saved in .eps (1) or only in .fig format (0) (default)
% inputs.plotd.number_max_states=8;                    % [] Maximum number of states per figure
% inputs.plotd.number_max_obs=8;                       % [] Maximum number of observables per figure
% inputs.plotd.n_t_plot=100;                           % [] Number of times to be used for observables and states plots
% inputs.plotd.number_max_hist=8;                      % [] Maximum number of unknowns histograms per figure (multistart)
inputs.plotd.nx_contour=100;                          % Number of points for plotting the contours x and y direction
inputs.plotd.ny_contour=100;                          % ADVISE: >50
