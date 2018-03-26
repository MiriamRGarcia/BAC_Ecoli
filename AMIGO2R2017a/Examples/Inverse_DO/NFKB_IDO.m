%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: The NFKB module
%
%  The model considered in this work was proposed in:
%  Lipniacki T, Paszek P, Brasier A, Luxon B, Kimmel M: Mathematical model of
%  NFkB regulatory module. J Theor Biol 2004, 228:195-215.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%======================
% PATHS RELATED DATA
%======================
inputs.pathd.results_folder='NFKBI';                    % Name of the folder to keep results
inputs.pathd.short_name='NFKBI';                        % To be used for problem results folders and files

%======================
% MODEL RELATED DATA
%======================
inputs.model.input_model_type='charmodelC';  % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                             %                     'blackboxmodel'|'blackboxcost  
inputs.model.n_st=15;                                   %  Number of states  
inputs.model.n_par=29;                                  %  Number of parameters in the model
inputs.model.n_stimulus=1;                              %  Number of stimulus in the model
inputs.model.st_names=char('IKKn','IKKa','IKKi','IKKaIkBa','IKKaIkBaNFkB','NFkB','NFkBn','A20','A20t',...
                           'IkBa','IkBan','IkBat','IkBaNFkB','IkBanNFkBn','cgent');                    
inputs.model.par_names=char('a1','a2','t1','a3','t2','c1a','c2a','c3a','c4a','c5a',...
                            'c6a','c1','c2','c3','c4','c5','k1','k2','k3','kprod','kdeg',...
                            'kv','i1','e2a','i1a','e1a','c1c','c2c','c3c');
                                                        % Names of the stimulus                         
inputs.model.stimulus_names=char('Tr');
                                                        % Eqns (equations): ODEs or DAEs 
                                                        % ODES:
                                                        % ydot =f (ydot,y,u,theta,t)  
                                                        % DAES:
                                                        % delta=ydot-f(ydot,y,u,
                  
                                                       
inputs.model.eqns=char('dIKKn=kprod-kdeg*IKKn-Tr*k1*IKKn',... 
                       'dIKKa=Tr*k1*IKKn-k3*IKKa-Tr*k2*IKKa*A20-kdeg*IKKa-a2*IKKa*IkBa+t1*IKKaIkBa-a3*IKKa*IkBaNFkB+t2*IKKaIkBaNFkB',...
                       'dIKKi=k3*IKKa+Tr*k2*IKKa*A20-kdeg*IKKi',...
                       'dIKKaIkBa=a2*IKKa*IkBa-t1*IKKaIkBa',...
                       'dIKKaIkBaNFkB=a3*IKKa*IkBaNFkB-t2*IKKaIkBaNFkB',...
                       'dNFkB=c6a*IkBaNFkB-a1*NFkB*IkBa+t2*IKKaIkBaNFkB-i1*NFkB',...
                       'dNFkBn=i1*kv*NFkB-a1*IkBan*NFkBn',...
                       'dA20=c4*A20t-c5*A20',...
                       'dA20t=c2+c1*NFkBn-c3*A20t',...
                       'dIkBa=-a2*IKKa*IkBa-a1*IkBa*NFkB+c4a*IkBat-c5a*IkBa-i1a*IkBa+e1a*IkBan',...
                       'dIkBan=-a1*IkBan*NFkBn+i1a*kv*IkBa-e1a*kv*IkBan',...
                       'dIkBat=c2a+c1a*NFkBn-c3a*IkBat',...
                       'dIkBaNFkB=a1*IkBa*NFkB-c6a*IkBaNFkB-a3*IKKa*IkBaNFkB+e2a*IkBanNFkBn',...
                       'dIkBanNFkBn=a1*IkBan*NFkBn-e2a*kv*IkBanNFkBn',...
                       'dcgent=c2c+c1c*NFkBn-c3c*cgent');
                  
inputs.model.par=[0.5 0.2 0.1 1 0.1 5e-7 0 0.0004 0.5 ...
                 0.0001 0.00002 5e-7 0 0.0004 0.5 0.0003 ...
                 0.0025 0.1 0.0015 0.000025 0.000125 5 ...
                 0.0025 0.01 0.001 0.0005 5e-7 0 0.0004];  % Nominal parameter values when available



inputs.model.alpha=0;   % Parameter value to handle control regularization (any real number)
                        % 0: means no regularization
inputs.model.beta=0;    % Paremeter value to handle regularization in PE (any real number)
                        % 0: means no regularization

%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================

inputs.exps.n_exp=2;  
e1=1;
e2=2;
% EXPERIMENT 1
inputs.exps.n_obs{e1}=6; 
inputs.exps.obs_names{e1}=char('NFkB_n','TIkBa_c','A20mRNA','TIKK','IKK_a','IkBa_t');% names of observables
inputs.exps.obs{e1}=char('NFkB_n=NFkBn',...
                            'TIkBa_c=IkBa+IkBaNFkB',...
                            'A20mRNA=A20t',...
                            'TIKK=IKKn+IKKa+IKKi',...
                            'IKK_a=IKKa',...
                            'IkBa_t=IkBat');
inputs.exps.exp_y0{e1}= [0.2  0 0 0 0  3.155e-004 2.2958e-003 ...
                 4.78285e-003 2.8697e-006 2.50663e-003...
                 3.43573e-003 2.86971e-006 0.06 ...
                 7.888e-005 2.86971e-006];  
             
inputs.exps.t_f{e1}=3*3600;  
inputs.exps.n_s{e1}=10;                                % [] Number of sampling times for each experiment.


% EXPERIMENT 2
inputs.exps.n_obs{e2}=6; 
inputs.exps.obs_names{e2}=char('NFkB_n','TIkBa_c','A20mRNA','TIKK','IKK_a','IkBa_t'); % names of observables
inputs.exps.obs{e2}=char('NFkB_n=NFkBn',...
                            'TIkBa_c=IkBa+IkBaNFkB',...
                            'A20mRNA=A20t',...
                            'TIKK=IKKn+IKKa+IKKi',...
                            'IKK_a=IKKa',...
                            'IkBa_t=IkBat');
inputs.exps.exp_y0{e2}= [0.2  0 0 0 0  3.155e-004 2.2958e-003 ...
                 4.78285e-003 2.8697e-006 2.50663e-003...
                 3.43573e-003 2.86971e-006 0.06 ...
                 7.888e-005 2.86971e-006];  
             
inputs.exps.t_f{e2}=3*3600;  

inputs.exps.n_s{e2}=15;                              % [] Number of sampling times for each experiment.


%==================================
% EXPERIMENTAL DATA RELATED INFO
%================================== 
 
%Experimental data 1: 
		inputs.exps.exp_data{e1}=[
		0.0022958  0.0625066  2.8697e-06  0.2  0.00408305  2.49244e-05
		0.280189  0.00467196  6.86945e-05  0.19975  0.0313034  0.000124283
		0.179116  0.0551386  0.000185294  0.199659  0.00242943  0.000185294
		0.0602467  0.0790326  0.000150592  0.1695  0.00136392  0.000178386
		0.0478324  0.087306  0.000146805  0.199582  0.00290063  9.12168e-05
		0.0275788  0.0678271  7.96966e-05  0.199726  0.00531155  7.96966e-05
		0.106199  0.0513687  5.49521e-05  0.229907  0.00541197  8.27462e-05
		0.170697  0.0323058  0.000110803  0.229925  0.00132831  0.000110803
		0.135664  0.0554921  0.000121925  0.229865  0.00125362  0.000121925
		0.104688  0.0701139  0.000110885  0.199846  0.0028709  8.30912e-05
		];


% 		Error data 1: 
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
		inputs.exps.error_data{e1}=[
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		0.0420283  0.0118549  2.77941e-05  0.03  0.00408305  2.77941e-05
		];

		
%Experimental data 2: 
		inputs.exps.exp_data{e2}=[
		0.0022958  0.0625066  2.8697e-06  0.169982  0  3.15982e-05
		0.290717  0.00126314  5.18389e-05  0.199873  0.0626187  5.18389e-05
		0.240132  0.0112809  0.000129413  0.229752  0.0108227  0.000158141
		0.189161  0.03966  0.00015322  0.199709  0.00243166  0.000181948
		0.113419  0.0794977  0.000220252  0.19982  0.0101428  0.000220252
		0.0433262  0.140044  0.000126  0.229979  0.000289304  0.000154729
		0.0423222  0.108177  0.000113704  0.200061  0.00925592  0.000142433
		0.0423942  0.175793  5.4797e-05  0.230122  0.00932652  8.35254e-05
		8.14443e-06  0.161062  6.13533e-05  0.170101  3.26825e-05  3.26248e-05
		4.72758e-06  0.193112  4.5066e-05  0.200121  0.0093765  7.37945e-05
		0.0423728  0.196096  3.31023e-05  0.230134  8.20027e-06  3.31023e-05
		2.93236e-06  0.170917  2.43146e-05  0.200108  4.13984e-06  4.41385e-06
		2.70401e-06  0.169562  1.78601e-05  0.2001  2.09368e-06  1.78601e-05
		2.67944e-06  0.192575  1.31198e-05  0.170074  0.00939175  1.56087e-05
		0.0423735  0.189093  1.90909e-05  0.200084  0.00939334  9.63761e-06
		];


% 		Error data 2: 
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
		inputs.exps.error_data{e2}=[
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		0.0423763  0.0256376  2.87285e-05  0.0300181  0.00939281  2.87285e-05
		];
 


%==================================
% UNKNOWNS RELATED DATA
%==================================

% GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERIMENTS)

inputs.IDOsol.id_par=char('t1','t2','c3a','c4a','c5','k1','k2','k3','kprod','kdeg','i1','e2a','i1a');  %  'all'|User selected  
inputs.IDOsol.par_max=0.5*ones(1,13);                                          % Maximum allowed values for the paramters
inputs.IDOsol.par_min=1e-6*ones(1,13);                                        % Minimum allowed values for the paramters
%inputs.IDOsol.par_ref=inputs.IDOsol.par_guess;                                  % Reference for regularization
% STIMULI CONDITIONS CVP

%TIME VARYING STIMULI/CONTROL
 
 inputs.IDOsol.u_interp='step';                                    % Stimuli definition for experiment 3:
 inputs.IDOsol.n_steps{1}=3;  
 inputs.IDOsol.n_steps{2}=3;  % OPTIONS:u_interp:
 for iexp=1:inputs.exps.n_exp                                                                   % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.IDOsol.u_min{iexp}(1,:)=0*ones(1,inputs.IDOsol.n_steps{iexp});
 inputs.IDOsol.u_max{iexp}(1,:)=1*ones(1,inputs.IDOsol.n_steps{iexp});           % Minimum and maximum value for the input
 inputs.IDOsol.u_guess{iexp}(1,:)=0.5*ones(1,inputs.IDOsol.n_steps{iexp});       % Guess value for the input
 inputs.IDOsol.u_ref{iexp}=inputs.IDOsol.u_guess{iexp};                          % Reference for regularization
 inputs.IDOsol.t_con{iexp}=linspace(0,inputs.exps.t_f{iexp},inputs.IDOsol.n_steps{iexp}+1);       % Input swithching times: Initial and final time   
 inputs.DOsol.min_stepduration{iexp}=100;                                  %Minimum control element duration 
 inputs.DOsol.max_stepduration{iexp}=inputs.exps.t_f{iexp}/ inputs.IDOsol.n_steps{iexp};  %Maximum control element duration 
 end
% 

% COST FUNCTION RELATED DATA
%==================================
         
inputs.IDOsol.IDOcost_type='llk';                  % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'user_PEcost' 
inputs.IDOsol.lsq_type='Q_expmax';                 % 'Q_I' identity matrix; 'Q_expmax' maximum expdata per observable; 'Q_expmean'
                                                   % llk_type:
                                                   % 'homo','homo_var','hetero'
inputs.IDOsol.llk_type='hetero';

%==================================
% NUMERICAL METHODS RELATED DATA
%==================================
%
% DEFAULTS ARE BEING USED FOR SIMULATION
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
                                                       
%inputs.nlpsol.eSS.log_var = 1:length(inputs.PEsol.global_theta_guess); % Decision variables to be considered in log-scale. Suitable for this problem with parameters
                                                                       % ranging from 0 to 1.
inputs.nlpsol.eSS.maxeval = 100000;
inputs.nlpsol.eSS.maxtime = 120;

inputs.nlpsol.eSS.local.solver = 'nl2sol';
inputs.nlpsol.eSS.local.finish = 'fminsearch';
inputs.nlpsol.eSS.log_var=[1:1:13]
inputs.nlpsol.multi_starts=100;
inputs.plotd.figsave=1;
