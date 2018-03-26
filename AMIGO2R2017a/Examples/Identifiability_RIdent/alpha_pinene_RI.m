%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: Thermal isomerization of alfa-pinene
% REF:   R.E. Fuguitt y J. E. Hawkins, 1947. Rate of thermal isomerization
% of ?-pinene in the liquid phase. J. A. C. S., 69:461
% 
% NOTE!!!: [] indicates that the corresponding input may be omitted,
%              default value will be assigned
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='alpha_pinene'; % Folder to keep results (in Results) for a given problem                       
inputs.pathd.short_name='pinene';                       % To identify figures and reports for a given problem 
                                                     % ADVISE: the user may introduce any names related to the problem at hand 
inputs.pathd.runident='r1';                         % [] Identifier required in order not to overwrite previous results
                                                     %    This may be modified from command line. 'run1'(default)
                                                     

%============================
% MODEL RELATED DATA
%============================
inputs.model.input_model_type='charmodelC';          % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                     
                                                     %                     'blackboxmodel'|'blackboxcost                   
inputs.model.n_st=5;                                 % Number of states                                  
inputs.model.n_par=5;                                % Number of model parameters                                  
inputs.model.n_stimulus=0;                           % Number of inputs, stimuli or control variables   
inputs.model.names_type='standard';                    % [] Names given to states/pars/inputs: 'standard' (x1,x2,...p1,p2...,u1, u2,...) 
                                                     %                                       'custom'(default)
                              
inputs.model.eqns=...                                % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
            char('dx1=-(p1+p2)*x1',...  
                 'dx2= p1*x1',...
                 'dx3= p2*x1-(p3+p4)*x3+p5*x5',...
                 'dx4= p3*x3',...
                 'dx5= p4*x3-p5*x5');
   
 p1=5.93e-5;  p2=2.96e-5;  p3=2.05e-5;  p4=27.5e-5;  p5=4e-5;
             
 inputs.model.par=[p1 p2 p3 p4 p5];                   % Nominal value for the parameters, this allows to fix known parameters
                                                      % These values may be updated during optimization  
%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================
 inputs.exps.n_exp=1;                                 % Number of experiments                                                                  
 inputs.exps.n_obs{1}=4;                              % Number of observed quantities per experiment                         
 inputs.exps.obs{1}=char('y1=x1','y2=x2','y3=x3','y4=x5');
 inputs.exps.exp_y0{1}=[100 0 0 0 0];       % Initial conditions for each experiment       
 inputs.exps.t_f{1}=36420;                            % Experiments duration
 inputs.exps.n_s{1}=8;                                % Number of sampling times
 inputs.exps.t_s{1}=[1230 3060 4920 7800 10680 15030 22620 36420];                         % [] Sampling times, by default equidistant
                                                            
%==================================
% EXPERIMENTAL DATA RELATED INFO
%==================================
 inputs.exps.data_type='real';                         % Type of data: 'pseudo'|'pseudo_pos'|'real'             
 inputs.exps.noise_type='homo';
 inputs.exps.std_dev{1}=[0.01 0.01 0.01 0.01]; % 1% error
 
%Experimental data 1: 
 inputs.exps.exp_data{1}=[
	88.35 7.3   2.3  1.75
    76.4  15.6  4.5  2.8
    65.1  23.1  5.3  5.8
    50.4  32.9  6.0  9.3
    37.5  42.7  6.0  12.0
    25.9  49.1  5.9  17.0
    14.0  57.4  5.1  21.0
    4.5   63.1  3.8  25.7
   ];


  
 %==================================
 % UNKNOWNS RELATED DATA
 %==================================
 
 % GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERIMENTS)
 
 inputs.PEsol.id_global_theta='all';               % 'all'|User selected 

% Optimal solution found in optimization
%  	p1 : 5.9405e-05  +-  9.4468e-07 (    1.59%); (bound active) 
% 	p2 : 2.8344e-05  +-  1.5690e-06 (    5.54%); (bound active) 
% 	p3 : 8.3436e-06  +-  1.4184e-05 (     170%); (bound active) 
% 	p4 : 2.8955e-04  +-  4.8968e-05 (    16.9%); 
% 	p5 : 4.5436e-05  +-  1.7841e-05 (    39.3%); (bound active) 
%   x1 : 9.8920e+01  +-  1.0771e+00 (    1.09%); 
 
 inputs.PEsol.global_theta_guess= [5.94048376954083e-05 
      2.83441777581245e-05
      8.34362220608288e-06
      0.000289546731794319
      4.54361603172493e-05]';                            % BEST solution achieved in optimization
 
 FIM_conf_interval=[9.44682247235014e-07       1.5689667826703e-06      1.41843878174451e-05      4.89684690318076e-05      1.78411008858483e-05];
 
 inputs.PEsol.global_theta_max=inputs.PEsol.global_theta_guess+ 2.*FIM_conf_interval;   % Maximum allowed values for the paramters
 inputs.PEsol.global_theta_min= inputs.PEsol.global_theta_guess- 2.*FIM_conf_interval;  % Minimum allowed values for the parameters
 

 % % GLOBAL INITIAL CONDITIONS
 inputs.PEsol.id_global_theta_y0='x1';                  % [] 'all'|User selected| 'none' (default)
 
 inputs.PEsol.global_theta_y0_guess=[98.9201037052239]; % [] Initial guess
 FIM_conf_y0=1.0771;
 inputs.PEsol.global_theta_y0_max=inputs.PEsol.global_theta_y0_guess+ 2.*FIM_conf_y0;   % Maximum allowed values for the initial conditions
 inputs.PEsol.global_theta_y0_min=inputs.PEsol.global_theta_y0_guess- 2.*FIM_conf_y0;   % Minimum allowed values for the initial conditions
 
% 
% % LOCAL UNKNOWNS (DIFFERENT VALUES FOR DIFFERENT EXPERIMENTS)
% 
% inputs.PEsol.id_local_theta{1}='none';                % [] 'all'|User selected| 'none' (default)
% % inputs.PEsol.local_theta_max{iexp}=[];              % Maximum allowed values for the paramters
% % inputs.PEsol.local_theta_min{iexp}=[];              % Minimum allowed values for the parameters
% % inputs.PEsol.local_theta_guess{iexp}=[];            % [] Initial guess
% inputs.PEsol.id_local_theta_y0{1}='none';             % [] 'all'|User selected| 'none' (default)
% % inputs.PEsol.local_theta_y0_max{iexp}=[];           % Maximum allowed values for the initial conditions
% % inputs.PEsol.local_theta_y0_min{iexp}=[];           % Minimum allowed values for the initial conditions
% % inputs.PEsol.local_theta_y0_guess{iexp}=[];         % [] Initial guess
 
 
 %==================================
 % COST FUNCTION RELATED DATA
 %==================================
          
 inputs.PEsol.PEcost_type='llk';                       % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'user_PEcost' 
 inputs.PEsol.lsq_type='homo';
% inputs.PEsol.llk_type='homo_var';                     % [] To be defined for llk function, 'homo' | 'homo_var' | 'hetero' 
 
 
 %==================================
 % NUMERICAL METHODS RELATED DATA
 %==================================
 %
 % SIMULATION
 inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'radau5'(default, fortran)|'rkf45'|'lsodes'|


 inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes' (C)


 inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0D-7; 


 % %
% % OPTIMIZATION
inputs.nlpsol.nlpsolver='local_lsqnonlin';              % [] NLP solver: 
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
                                                       
inputs.nlpsol.eSS.log_var = 1:5;                     % Decision variables to be considered in log-scale. Suitable for this problem with parameters
                                                     % ranging from 0 to 1.
inputs.nlpsol.eSS.maxeval = 10000;
inputs.nlpsol.eSS.maxtime = 20;                      % Only 20 s for RIdent

inputs.nlpsol.eSS.local.solver = 'nl2sol';
inputs.nlpsol.eSS.local.finish = 'nl2sol';

inputs.nlpsol.multi_starts=500;                      % [] Number of different initial guesses to run local methods in the multistart approach
inputs.nlpsol.multistart.maxeval = 20000;            % Maximum number of function evaluations for the multistart
inputs.nlpsol.multistart.maxtime = 120;              % Maximum allowed time for the optimization

 
 
 

%inputs.plotd.plotlevel='full';                        % [] Display of figures: 'full'|'medium'(default)|'min' |'noplot' 
%inputs.plotd.figsave=1;
% inputs.plotd.epssave=0;                              % [] Figures may be saved in .eps (1) or only in .fig format (0) (default)
% inputs.plotd.number_max_states=8;                    % [] Maximum number of states per figure
% inputs.plotd.number_max_obs=8;                       % [] Maximum number of observables per figure
% inputs.plotd.n_t_plot=100;                           % [] Number of times to be used for observables and states plots
% inputs.plotd.number_max_hist=8;                      % [] Maximum number of unknowns histograms per figure (multistart)
%inputs.plotd.nx_contour=100;                          % Number of points for plotting the contours x and y direction
%inputs.plotd.ny_contour=100;                          % ADVISE: >50
