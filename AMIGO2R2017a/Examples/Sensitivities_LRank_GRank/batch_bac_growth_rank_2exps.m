% $Header: svn://.../trunk/AMIGO2R2016/Examples/batch_bac_growth/batch_bac_growth_2exps.m 2410 2015-12-07 13:58:57Z evabalsa $
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
inputs.pathd.runident='2exps';                         % [] Identifier required in order not to overwrite previous results
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
 inputs.exps.n_obs{1}=2;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{1}=char('obsB','obsS');               % Name of the observed quantities per experiment    
 inputs.exps.obs{1}=char('obsB=cb','obsS=cs');                  % Observation function
 inputs.exps.exp_y0{1}=[2 30];       % Initial conditions for each experiment       
 inputs.exps.t_f{1}=10;                               % Experiments duration
 inputs.exps.n_s{1}=11;                               % Number of sampling times
 inputs.exps.t_s{1}=[0:1:10];                         % [] Sampling times, by default equidistant
 
 inputs.exps.u_interp{1}=[];                % [] Stimuli definition: u_interp: 'sustained' |'step'|'linear'(default)|
                                                      %                               'pulse-up'|'pulse-down'
 inputs.exps.n_pulses{1}=[];                           % Number of pulses
 inputs.exps.u_min{1}=0;inputs.exps.u_max{1}=[];       % Bounds for the stimuli
 inputs.exps.t_con{1}=[];                      % Initial time-Times of changes for the stimuli- Final stimulation time
 
 
 inputs.exps.n_obs{2}=2;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{2}=char('obsB','obsS');               % Name of the observed quantities per experiment    
 inputs.exps.obs{2}=char('obsB=cb','obsS=cs');                  % Observation function
 inputs.exps.exp_y0{2}=[2 15];       % Initial conditions for each experiment       
 inputs.exps.t_f{2}=10;                               % Experiments duration
 inputs.exps.n_s{2}=11;                               % Number of sampling times
 inputs.exps.t_s{2}=[0:1:10];                         % [] Sampling times, by default equidistant
 
 inputs.exps.u_interp{2}=[];                % [] Stimuli definition: u_interp: 'sustained' |'step'|'linear'(default)|
                                                      %                               'pulse-up'|'pulse-down'
 inputs.exps.n_pulses{2}=[];                           % Number of pulses
 inputs.exps.u_min{2}=0;inputs.exps.u_max{1}=[];       % Bounds for the stimuli
 inputs.exps.t_con{2}=[]; 
 

    
 %==================================
 % UNKNOWNS RELATED DATA
 %==================================
 
 % GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERIMENTS)
 
 inputs.PEsol.id_global_theta='all';                         % 'all'|User selected 
 inputs.PEsol.global_theta_max=[10 10 10 10];    % Maximum allowed values for the paramters
 inputs.PEsol.global_theta_min= [0 0 0 0];       % Minimum allowed values for the parameters

 
 %==================================
% NUMERICAL METHODS RELATED DATA
%==================================

% SIMULATION
inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'cvodes'(default, C)|'ode15s' (default, MATLAB, sbml)|'ode113'|'ode45'           
                                                      %                'ode15s' (default, MATLAB, sbml)|'ode113'
inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes'(default, C)
                                                      %                          'sensmat' (matlab) |
                                                      %                          'fdsens2','fdsens5' (finite differences)
inputs.ivpsol.rtol=1.0D-8;                            % [] IVP solver integration tolerances
inputs.ivpsol.atol=1.0D-8; 
 

%==================================
% GRank DATA
%==================================
 
 inputs.rank.gr_samples=10000;                         % [] Number of samples for global sensitivities and global rank within LHS (default: 10000)    
% 
% 
%==================================
% DISPLAY OF RESULTS
%==================================
% 
inputs.plotd.plotlevel='full';                        % [] Display of figures: 'full'|'medium'(default)|'min' |'noplot' 
% inputs.plotd.figsave=1;
% inputs.plotd.epssave=0;                              % [] Figures may be saved in .eps (1) or only in .fig format (0) (default)
% inputs.plotd.number_max_states=8;                    % [] Maximum number of states per figure
% inputs.plotd.number_max_obs=8;                       % [] Maximum number of observables per figure
% inputs.plotd.n_t_plot=100;                           % [] Number of times to be used for observables and states plots
% inputs.plotd.number_max_hist=8;                      % [] Maximum number of unknowns histograms per figure (multistart)
% inputs.plotd.nx_contour=100;                          % Number of points for plotting the contours x and y direction
% inputs.plotd.ny_contour=100;                          % ADVISE: >50