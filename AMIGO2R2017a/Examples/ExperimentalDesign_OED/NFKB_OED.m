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
inputs.pathd.results_folder='NFKB';                    % Name of the folder to keep results
inputs.pathd.short_name='NFKB';                        % To be used for problem results folders and files

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


%----------------------------------------------------------------------------------------------------------------
%
% EXPERIMENTAL SCHEME RELATED DATA
%

 inputs.exps.n_exp=3;                                   % Number of experiments
                                                        % Initial conditions per experiment

                                                       
%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================

inputs.exps.n_exp=3;  

% EXPERIMENT 1
inputs.exps.n_obs{1}=6; 
inputs.exps.obs_names{1}=char('NFkB_n','TIkBa_c','A20mRNA','TIKK','IKK_a','IkBa_t');% names of observables
inputs.exps.obs{1}=char('NFkB_n=NFkBn',...
                            'TIkBa_c=IkBa+IkBaNFkB',...
                            'A20mRNA=A20t',...
                            'TIKK=IKKn+IKKa+IKKi',...
                            'IKK_a=IKKa',...
                            'IkBa_t=IkBat');
inputs.exps.exp_y0{1}= [0.2  0 0 0 0  3.155e-004 2.2958e-003 ...
                 4.78285e-003 2.8697e-006 2.50663e-003...
                 3.43573e-003 2.86971e-006 0.06 ...
                 7.888e-005 2.86971e-006];  
             
inputs.exps.t_f{1}=3*3600;  

inputs.exps.u_interp{1}='sustained';                  %Stimuli definition for experiment 1:
                                                       %OPTIONS:u_interp: 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
inputs.exps.t_con{1}=[0 3*3600];                         % Input swithching times: Initial and final time    
inputs.exps.u{1}=[1];     
inputs.exps.n_s{1}=10;                                % [] Number of sampling times for each experiment.

% 		Error data 1: 
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
		inputs.exps.error_data{1}=[
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

% EXPERIMENT 2
inputs.exps.n_obs{2}=6; 
inputs.exps.obs_names{2}=char('NFkB_n','TIkBa_c','A20mRNA','TIKK','IKK_a','IkBa_t'); % names of observables
inputs.exps.obs{2}=char('NFkB_n=NFkBn',...
                            'TIkBa_c=IkBa+IkBaNFkB',...
                            'A20mRNA=A20t',...
                            'TIKK=IKKn+IKKa+IKKi',...
                            'IKK_a=IKKa',...
                            'IkBa_t=IkBat');
inputs.exps.exp_y0{2}= [0.2  0 0 0 0  3.155e-004 2.2958e-003 ...
                 4.78285e-003 2.8697e-006 2.50663e-003...
                 3.43573e-003 2.86971e-006 0.06 ...
                 7.888e-005 2.86971e-006];  
             
inputs.exps.t_f{2}=3*3600;  

inputs.exps.u_interp{2}='pulse-down';                 %Stimuli definition for experiment 2
inputs.exps.n_pulses{2}=1;                            %Number of pulses |-|_
inputs.exps.u_min{2}=0;inputs.exps.u_max{2}=1;        %Minimum and maximum value for the input
inputs.exps.t_con{2}=[0 180 3*3600];                %Times of switching: Initial time, Intermediate times, Final time
inputs.exps.n_s{2}=15;                              % [] Number of sampling times for each experiment.

% 		Error data 2: 
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
% 		Standard deviation: 15%
		inputs.exps.error_data{2}=[
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
 % EXPERIMENT TO BE DESIGNED - exp 3
 %==================================
 inputs.exps.exp_type{3}='od';                        % Indicates if the the experiment should

                                                        
 inputs.exps.exp_y0_type{3}='fixed';               % Indicates if the initial conditions should or 
                                                      % not be optimally designed: 'od' and 'fixed'                                                    
 inputs.exps.exp_y0{3}=[0.2  0 0 0 0  3.155e-004 2.2958e-003 ...
                 4.78285e-003 2.8697e-006 2.50663e-003...
                 3.43573e-003 2.86971e-006 0.06 ...
                 7.888e-005 2.86971e-006];       
             
             
inputs.exps.n_obs{3}=6; 
inputs.exps.obs_names{3}=char('NFkB_n','TIkBa_c','A20mRNA','TIKK','IKK_a','IkBa_t'); % names of observables
inputs.exps.obs{3}=char('NFkB_n=NFkBn',...
                            'TIkBa_c=IkBa+IkBaNFkB',...
                            'A20mRNA=A20t',...
                            'TIKK=IKKn+IKKa+IKKi',...
                            'IKK_a=IKKa',...
                            'IkBa_t=IkBat');

 inputs.exps.u_type{3}='od';                           % Type of stimulation: 'fixed' | 'od' (to be designed) 
 inputs.exps.u_interp{3}='step';                       % Stimuli definition for experiment 3:
                                                       % OPTIONS:u_interp:
                                                       % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.exps.n_steps{3}=3;                             % Number of pulses _|-|_|-|_ 
 inputs.exps.u_min{3}=0*ones(1,inputs.exps.n_steps{3});
 inputs.exps.u_max{3}=1*ones(1,inputs.exps.n_steps{3});% Minimum and maximum value for the input
 inputs.exps.tf_type{3}='fixed';                       % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.t_f{3}=3*60*60;                               % Experiment duration
 inputs.exps.ts_type{3}='fixed';                       % [] Type of sampling times: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.ts_type{3}='od';                          % [] Type of sampling times: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.ts_0{3}=0;                                % First sampling time. By default=0 
 inputs.exps.ts_min_dist{3}=3*60*60/(3*60);            % Minimum distance between sampling times
 inputs.exps.max_ns{3} = 15;                           % Maximum number of sampling times 
 inputs.exps.std_dev{3}=0.15;                          % Standard deviation of the noise for each experiment: Ex: 0.05 <=> 5%

                  


 
%----------------------------------------------------------------------------------------------------------------
%
% EXPERIMENTAL DESIGN RELATED PARAMETERS
% 
 
% Parameters to which the OED is intended
inputs.PEsol.id_global_theta=char('t1','c5','k1','k2','kprod','kdeg','i1');     % global unknown parameters: 'all', 'none' or the names
% Nominal values for the parameters for which the OED is intended
inputs.PEsol.global_theta_guess=[4.3785e-02 3.6158e-04 9.8310e-03 5.3551e-02 2.6086e-05 1.2244e-04  9.7044e-01 ];

%==================================
% COST FUNCTION RELATED DATA
%==================================    

 inputs.exps.noise_type='homo';                    % Type of experimental noise: 'homo' |'homo_var'| 'hetero'     
 inputs.OEDsol.OEDcost_type='Eopt';                % FIM based criterium: 'Dopt'|'Eopt'|'Aopt'|'Emod'|'DoverE'
 