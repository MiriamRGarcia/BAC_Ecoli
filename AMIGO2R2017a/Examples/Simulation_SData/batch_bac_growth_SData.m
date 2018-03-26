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
		13.708051  1.899270
		];


% 		Error data 1: 
% 		Standard deviation: 10.000000%
% 		Standard deviation: 10.000000%
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

  %Experimental data 2: 
		inputs.exps.exp_data{2}=[
		2.000000  15.00000
		2.577833  13.692386
		2.739831  10.946097
		3.998508  9.849170
		5.666208  9.070507
		5.253874  3.802611
		6.032305  1.468778
		7.268508  1.429832
		7.698270  1.355763
		6.709135  0.604001
		7.397835  1.306151
		];


%		Error data 2: 
%		Standard deviation: 10.000000%
%		Standard deviation: 10.000000%
		inputs.exps.error_data{2}=[
		0.124137  0.255795
		0.018472  0.038064
		0.506847  1.044398
		0.067257  0.138587
		0.673764  1.388345
		0.691883  1.425681
		0.726280  1.496558
		0.046039  0.094867
		0.418766  0.862901
		0.373876  0.437600
		0.606683  1.250118
		];
    
    
 