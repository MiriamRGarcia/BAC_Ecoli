% $Header: svn://.../trunk/AMIGO2R2016/Examples/regularization/alphaP_REG_PE.m 2410 2015-12-07 13:58:57Z evabalsa $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model: Thermal isomerization of alfa-pinene
%       REF:   R.E. Fuguitt y J. E. Hawkins, 1947. Rate of thermal isomerization
%               of Alpha-pinene in the liquid phase. J. A. C. S., 69:461
% 
% Objective function : simple least squares  
% Jacobian: automatically forward sensitivity
% Measurements: original real data
% 
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
%============================
% RESULTS PATHS RELATED DATA
%============================
inputs = AMIGO_default_options();
inputs.pathd.results_folder='alpha_pinene';          % Folder to keep results (in Results) for a given problem                       
inputs.pathd.short_name='pinene_REG';                % To identify figures and reports for a given problem 
                                                     % ADVISE: the user may introduce any names related to the problem at hand 
inputs.pathd.runident='r1';                          % [] Identifier required in order not to overwrite previous results
                                                     %    This may be modified from command line. 'run1'(default)
                                                     % Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
%============================
% MODEL RELATED DATA
%============================
inputs.model.input_model_type='charmodelC';          % Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
                                                     %                     'blackboxmodel'|'blackboxcost                   
inputs.model.n_st=5;                                 % Number of states                                  
inputs.model.n_par=5;                                % Number of model parameters                                  
inputs.model.n_stimulus=0;                           % Number of inputs, stimuli or control variables   
inputs.model.names_type='custom';                    % [] Names given to states/pars/inputs: 'standard' (x1,x2,...p1,p2...,u1, u2,...) 
                                                     %                                       'custom'(default)
inputs.model.st_names=char('y1','y2','y3','y4','y5');     % Names of the states                                         
inputs.model.par_names=char('p1','p2','p3','p4','p5');             % Names of the parameters                   
inputs.model.stimulus_names=[];          % Names of the stimuli, inputs or controls                                  
inputs.model.eqns=...                                % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
            char('dy1=-(p1+p2)*y1',...  
                 'dy2= p1*y1',...
                 'dy3= p2*y1-(p3+p4)*y3+p5*y5',...
                 'dy4= p3*y3',...
                 'dy5= p4*y3-p5*y5');
   
 p1=5.93e-5;
 p2=2.96e-5;
 p3=2.05e-5;
 p4=27.5e-5;
 p5=4e-5;% Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
inputs.model.par=[p1 p2 p3 p4 p5];      % Nominal value for the parameters, this allows to fix known parameters
                                                      % These values may be updated during optimization  % Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================% Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
 inputs.exps.n_exp=1;                                 % Number of experiments                                                                  
 inputs.exps.n_obs{1}=5;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{1}=char('obsy1','obsy2','obsy3','obsy4','obsy5');                  % Observation function
 inputs.exps.obs{1}=char('obsy1=y1','obsy2=y2','obsy3=y3','obsy4=y4','obsy5=y5');
 inputs.exps.exp_y0{1}=[100 0 0 0 0];       % Initial conditions for each experiment       
 inputs.exps.t_f{1}=36420;                               % Experiments duration
 inputs.exps.n_s{1}=9;                               % Number of sampling times
 inputs.exps.t_s{1}=[0 1230 3060 4920 7800 10680 15030 22620 36420];                         % [] Sampling times, by default equidistant
 % Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
%==================================
% EXPERIMENTAL DATA RELATED INFO
%==================================
inputs.exps.data_type='real';%'pseudo_pos';%'real';                         % Type of data: 'pseudo'|'pseudo_pos'|'real'             % Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
    
inputs.exps.exp_data{1}=[ 100.0	 0.0	 0.0	 0.0     0.0
    88.35    7.3     2.3     0.4     1.75
    76.4    15.6     4.5     0.7     2.8
    65.1    23.1     5.3     1.1     5.8
    50.4    32.9     6.0     1.5     9.3
    37.5    42.7     6.0     1.9    12.0
    25.9    49.1     5.9     2.2    17.0
    14.0    57.4     5.1     2.6    21.0
    4.5    63.1     3.8     2.9    25.7 ];% Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
%   
 %==================================
 % UNKNOWNS RELATED DATA
 %==================================
 
 % GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERIMENTS)
 
 inputs.PEsol.id_global_theta='all';                         % 'all'|User selected 
 inputs.PEsol.global_theta_max=[1 1 1 1 1];    % Maximum allowed values for the paramters
 inputs.PEsol.global_theta_min= [0 0 0 0 0];       % Minimum allowed values for the parameters
 inputs.PEsol.global_theta_guess = 0.5*( inputs.PEsol.global_theta_max +  inputs.PEsol.global_theta_min);
 %[5.9258e-005  2.9634e-005  2.0473e-005  2.7447e-004  3.9980e-005];%% Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
 %==================================
 % COST FUNCTION RELATED DATA
 %==================================% Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
inputs.PEsol.PEcost_type='lsq';                       % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'user_PEcost'
inputs.PEsol.lsq_type='Q_I';
inputs.PEsol.PEcostJac_type='lsq';% Model type:'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
 
 %==================================
 % NUMERICAL METHODS RELATED DATA
 %==================================
 %
 % SIMULATION
 inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'radau5'(default, fortran)|'rkf45'|'lsodes'|


 inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes' (C)


 inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0D-7; 
% 
% %
% % OPTIMIZATION
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
                                                       
inputs.nlpsol.eSS.log_var = 1:5;                        % Decision variables to be considered in log-scale. Suitable for this problem with parameters
                                                        % ranging from 0 to 1.
inputs.nlpsol.eSS.maxeval = 1000;
inputs.nlpsol.eSS.maxtime = 60;

inputs.nlpsol.eSS.local.solver = 'nl2sol';
inputs.nlpsol.eSS.local.finish = 'nl2sol';
inputs.nlpsol.eSS.local.nl2sol.maxiter = 20;




%======================
% REGULARIZATION
%======================

inputs.nlpsol.regularization.method = 'tikhonov';            %Regularization approach
inputs.nlpsol.regularization.tikhonov.gW = eye(5);           %Weighting matrix
inputs.nlpsol.regularization.tikhonov.gx0 = ones(1,5)*1e-4;  % Parameter reference values
inputs.nlpsol.regularization.alphaSet = [0 1e8 1e7 1e6 1e5]; % Alpha values to be considered


%======================
%Display of results
%======================

inputs.plotd.plotlevel='min';                           % [] Display of figures: 'full'|'medium'(default)|'min' |'noplot' 


 