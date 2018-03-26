% $Header$
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model: Thermal isomerization of alfa-pinene
%       REF:   R.E. Fuguitt y J. E. Hawkins, 1947. Rate of thermal isomerization
%               of Alpha-pinene in the liquid phase. J. A. C. S., 69:461
% 
% For Model discrimination
% 
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='ModelDiscr'; % Folder to keep results (in Results) for a given problem                       
inputs.pathd.short_name='alphap_v1';                       % To identify figures and reports for a given problem 
                                                     % ADVISE: the user may introduce any names related to the problem at hand 
inputs.pathd.runident='run1';                         % [] Identifier required in order not to overwrite previous results
                                                     %    This may be modified from command line. 'run1'(default)
                                                     

%============================
% MODEL RELATED DATA
%============================
inputs.model.input_model_type='charmodelC';          % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
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
 p5=4e-5;

inputs.model.par=[p1 p2 p3 p4 p5];      % Nominal value for the parameters, this allows to fix known parameters
                                                      % These values may be updated during optimization  

%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================

 inputs.exps.n_exp=2;                                 % Number of experiments      
 
 %% EXP 1
 inputs.exps.n_obs{1}=5;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{1}=char('obsy1','obsy2','obsy3','obsy4','obsy5');                  % Observation function
 inputs.exps.obs{1}=char('obsy1=y1','obsy2=y2','obsy3=y3','obsy4=y4','obsy5=y5');
 inputs.exps.exp_y0{1}=[100 0 0 0 0];       % Initial conditions for each experiment       
 inputs.exps.t_f{1}=36420;                               % Experiments duration
 inputs.exps.n_s{1}=9;                               % Number of sampling times
 inputs.exps.t_s{1}=[0 1230 3060 4920 7800 10680 15030 22620 36420];                         % [] Sampling times, by default equidistant
 
 % EXP 2
 inputs.exps.n_obs{2}=5;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{2}=char('obsy1','obsy2','obsy3','obsy4','obsy5');                  % Observation function
 inputs.exps.obs{2}=char('obsy1=y1','obsy2=y2','obsy3=y3','obsy4=y4','obsy5=y5');
 inputs.exps.exp_y0{2}=[100 0 0 0 0];       % Initial conditions for each experiment       
 inputs.exps.t_f{2}=36420;                               % Experiments duration
 inputs.exps.n_s{2}=9;                               % Number of sampling times
 inputs.exps.t_s{2}=[0 1230 3060 4920 7800 10680 15030 22620 36420];                         % [] Sampling times, by default equidistant

%==================================
% EXPERIMENTAL DATA RELATED INFO
%==================================
inputs.exps.data_type='real';%'pseudo_pos';%'real';                         % Type of data: 'pseudo'|'pseudo_pos'|'real'             
inputs.exps.noise_type = 'homo';
for iexp = 1:2
inputs.exps.std_dev{iexp} = [0.1 0.1 0.1 0.1 0.1 ];
inputs.exps.exp_data{iexp}=[ 100.0	 0.0	 0.0	 0.0     0.0
    88.35    7.3     2.3     0.4     1.75
    76.4    15.6     4.5     0.7     2.8
    65.1    23.1     5.3     1.1     5.8
    50.4    32.9     6.0     1.5     9.3
    37.5    42.7     6.0     1.9    12.0
    25.9    49.1     5.9     2.2    17.0
    14.0    57.4     5.1     2.6    21.0
    4.5    63.1     3.8     2.9    25.7 ];

inputs.exps.error_data{iexp}=[
   0.0    0.0    0.0    0.0    0.0
   10.0000    6.3100    0.6000    0.2900    2.5700
   10.0000    6.3100    0.6000    0.2900    2.5700
   10.0000    6.3100    0.6000    0.2900    2.5700
   10.0000    6.3100    0.6000    0.2900    2.5700
   10.0000    6.3100    0.6000    0.2900    2.5700
   10.0000    6.3100    0.6000    0.2900    2.5700
   10.0000    6.3100    0.6000    0.2900    2.5700
   10.0000    6.3100    0.6000    0.2900    2.5700
    ];
end
% 
% % Experimental data 1: 
% 		inputs.exps.exp_data{1}=[
% 		98.7655  0.405133  -0.0514788  0.143161  0.379067
% 		93.6304  10.1338  3.28087  0.796575  0.836232
% 		79.8872  14.7635  5.90562  -0.447055  6.26825
% 		65.9462  37.7563  5.93682  0.31603  8.22038
% 		72.8602  36.1093  5.77506  0.717804  6.05675
% 		39.5912  55.4115  5.64632  1.15495  10.1966
% 		19.2677  39.8579  5.35577  2.53723  18.5619
% 		-2.70984  53.0364  4.70818  2.77677  23.4239
% 		9.27474  62.2922  4.64648  3.478  22.7581
% 		];
% 
% 
% % 		Error data 1: 
% % 		Standard deviation: 10%
% % 		Standard deviation: 10%
% % 		Standard deviation: 10%
% % 		Standard deviation: 10%
% % 		Standard deviation: 10%
% 		inputs.exps.error_data{1}=[
% 		1.23452  0.405133  0.0514788  0.143161  0.379067
% 		3.98846  3.22457  0.390745  0.7572  0.316923
% 		3.70432  1.12353  0.6999  0.643984  3.74077
% 		1.37411  14.1244  0.246056  0.101108  3.02437
% 		22.8739  2.74815  0.667973  0.0767769  3.35809
% 		0.89588  14.5187  0.488792  0.0122589  2.91296
% 		7.01739  9.31302  0.122382  0.852216  1.18103
% 		16.0964  4.7384  0.117861  0.314187  1.63809
% 		5.34948  1.79364  0.822284  0.156877  1.77177
% % 		];
%   
 %==================================
 % UNKNOWNS RELATED DATA
 %==================================
 
 % GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERIMENTS)
 
 inputs.PEsol.id_global_theta='all';                         % 'all'|User selected 
 inputs.PEsol.global_theta_max=[1 1 1 1 1];    % Maximum allowed values for the paramters
 inputs.PEsol.global_theta_min= [0 0 0 0 0];       % Minimum allowed values for the parameters
 inputs.PEsol.global_theta_guess = 0.5*( inputs.PEsol.global_theta_max +  inputs.PEsol.global_theta_min);%[5.9258e-005  2.9634e-005  2.0473e-005  2.7447e-004  3.9980e-005];%
 %[5.9258e-005  2.9634e-005  2.0473e-005  2.7447e-004  3.9980e-005];%

 %==================================
 % COST FUNCTION RELATED DATA
 %==================================

%inputs.PEsol.PEcost_type='lsq';         % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'user_PEcost'
inputs.PEsol.PEcost_type='llk'; 
inputs.PEsol.llk_type='hetero';
%inputs.PEsol.lsq_type = 'Q_I';%'Q_exp';
inputs.PEsol.PEcostJac_type='llk';

 
 %==================================
 % NUMERICAL METHODS RELATED DATA
 %==================================
 %
 % SIMULATION
 inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'radau5'(default, fortran)|'rkf45'|'lsodes'|


 inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes' (C)


 inputs.ivpsol.rtol=1.0e-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0e-7; 
% 
% %
% % OPTIMIZATION
inputs.nlpsol.nlpsolver='ess';                        % [] NLP solver: 
                                                    
inputs.nlpsol.eSS.log_var = 1:5;                                                    
inputs.nlpsol.eSS.maxeval = 5000;
inputs.nlpsol.eSS.maxtime = 60;
inputs.nlpsol.eSS.local.solver = 'nl2sol';
inputs.nlpsol.eSS.local.finish = 'nl2sol';
inputs.nlpsol.eSS.local.nl2sol.maxiter = 150;


 