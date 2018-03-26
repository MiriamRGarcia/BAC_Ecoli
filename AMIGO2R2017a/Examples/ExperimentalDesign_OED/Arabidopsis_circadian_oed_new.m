% $Header: svn://.../trunk/AMIGO2R2016/Examples/Arabidopsis_circadian/circadian_oed_new.m 2398 2015-12-04 07:06:07Z evabalsa $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: The circadian clock in Arabidopsis thaliana
%
%        Type :
%                > help circadian_tutorial
%        for a more detailed description of the model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%        INPUT FILE FOR OPTIMAL EXPERIMENTAL DESIGN
%        Default values are assigned to non defined inputs.
%
%        Minimum required inputs:
%           > Paths related data
%           > Model:               model_type; n_st; n_par; n_stimulus; 
%                                  st_names; par_names; stimulus_names;  
%                                  eqns; par
%           > Experimental scheme: n_exp; exp_y0{iexp}; t_f{iexp}; 
%                                  u_interp{iexp}; t_con{iexp}; u{iexp}
%                                  n_obs{iexp}; obs_names{iexp}; obs{iexp} 
%
%                (AMIGO_OED)==>>    n_s{iexp}; t_s{iexp}; 
%                                  data_type; noise_type; 
%                                  exp_data{iexp}; [error_data{iexp}]
%                                  id_global_theta; [id_global_theta_y0]
%                                  [id_local_theta{iexp}];[id_local_theta_y0{iexp}]global_theta_max; global_theta_min
%                                  [global_theta_y0_max];[global_theta_y0_min]
%                                  [local_theta_max{iexp}];[local_theta_min{iexp}]
%                                  [local_theta_y0_max{iexp}];[local_theta_yo_min{iexp}]
%                                  [global_theta_guess];[global_theta_y0_guess];
%                                  [local_theta_guess{iexp}];[local_theta_y0_guess{iexp}]
%                                  [PEcost_type];[lsq_type];[llk_type]
%                                  []:optional inputs
%                                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%======================
% PATHS RELATED DATA
%======================

inputs.pathd.results_folder='new_circadian';         % Folder to keep results (in Results) for a given problem          
inputs.pathd.short_name='circadian';                      % To identify figures and reports for a given problem   

%======================
% MODEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelC';                % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                                           %                     'blackboxmodel'|'blackboxcost                                  
inputs.model.n_st=7;                                       % Number of states      
inputs.model.n_par=27;                                     % Number of model parameters 
inputs.model.n_stimulus=1;                                 % Number of inputs, stimuli or control variables   
inputs.model.st_names=char('CL_m','CL_c','CL_n','CT_m','CT_c','CT_n','CP_n');     % Names of the states                                              
inputs.model.par_names=char('n1','n2','g1','g2','m1','m2','m3','m4','m5','m6',...
                            'm7','k1','k2','k3','k4','k5','k6','k7','p1','p2',...
                            'p3','r1','r2','r3','r4','q1','q2');                  % Names of the parameters                     
inputs.model.stimulus_names=char('light');                                        % Names of the stimuli, inputs or controls                      
inputs.model.eqns=...                                      % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dCL_m=q1*CP_n*light+n1*CT_n/(g1+CT_n)-m1*CL_m/(k1+CL_m)',...
                    'dCL_c=p1*CL_m-r1*CL_c+r2*CL_n-m2*CL_c/(k2+CL_c)',...
                    'dCL_n=r1*CL_c-r2*CL_n-m3*CL_n/(k3+CL_n)',...
                    'dCT_m=n2*g2^2/(g2^2+CL_n^2)-m4*CT_m/(k4+CT_m)',...
                    'dCT_c=p2*CT_m-r3*CT_c+r4*CT_n-m5*CT_c/(k5+CT_c)',...
                    'dCT_n=r3*CT_c-r4*CT_n-m6*CT_n/(k6+CT_n)',...
                    'dCP_n=(1-light)*p3-m7*CP_n/(k7+CP_n)-q2*light*CP_n');              
                
inputs.model.par=[7.5038 0.6801 1.4992 3.0412 10.0982...   % Nominal value for the parameters, this allows to fix known parameters
                 1.9685 3.7511 2.3422 7.2482 1.8981 1.2 3.8045...
                 5.3087 4.1946 2.5356 1.4420 4.8600 1.2 2.1994...
                 9.4440 0.5 0.2817 0.7676 0.4364 7.3021 4.5703 1.0]; % These values may be updated during optimization  

%=====================================
%  EXPERIMENTAL SCHEME RELATED DATA
%=====================================
 inputs.exps.n_exp=3;                                 % Total number of experiments (available + experiments to be designed)     
 inputs.exps.exp_type{1}='fixed';                     % Indicates if the the experiment should
 inputs.exps.exp_type{2}='fixed';                     % or not be optimally designed : 'od' and 'fixed'
%   inputs.exps.exp_type{6}='od';
 for iexp=1:inputs.exps.n_exp   
% OBSEVABLES DEFINITION  
 inputs.exps.n_obs{iexp}=2;                            % Number of observed quantities per experiment  
 inputs.exps.obs_names{iexp}=char('Lum','mRNAa');      % Name of the observed quantities per experiment    
 inputs.exps.obs{iexp}=char('Lum=CL_m','mRNAa=CT_m');   % Observation function
 inputs.exps.exp_y0{iexp}=zeros(1,inputs.model.n_st);  % Initial conditions for each experiment    
 end           
 

 inputs.exps.u_interp{1}='sustained';                  % Stimuli definition for experiment 1:
                                                       % OPTIONS:u_interp: 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.exps.t_f{1}=120;                               % Experiment duration
 inputs.exps.t_con{1}=[0 120];                         % Input swithching times: Initial and final time    
 inputs.exps.u{1}=[1];                                 % Values of the inputs 
 inputs.exps.n_s{1}=15;                                % Number of sampling times for each experiment.
 
 inputs.exps.u_interp{2}='pulse-down';                 % Stimuli definition for experiment 2
 inputs.exps.n_pulses{2}=5;                            % Number of pulses |-|_|-|_|-|_|-|_|-|_    
 inputs.exps.u_min{2}=0;inputs.exps.u_max{2}=1;        % Minimum and maximum value for the input
 inputs.exps.t_f{2}=120;                               % Experiment duration
 inputs.exps.t_con{2}=[0 :12: 120];                    % Times of switching: Initial time, Intermediate times, Final time
 inputs.exps.n_s{2}=25;                                % Number of sampling times for each experiment.
 
 
 
%
%  INPUTS FOR THE EXPERIMENT TO BE OPTIMALLY DESIGNED
%

for iexp=3:5
 inputs.exps.exp_type{iexp}='od';  
 inputs.exps.obs_type{iexp}='od'; 
 inputs.exps.obs{iexp}='states';
 inputs.exps.max_obs{iexp}=5;
 inputs.exps.u_type{iexp}='od';                           % Type of stimulation: 'fixed' | 'od' (to be designed) 
 inputs.exps.u_interp{iexp}='step';                   % Stimuli definition for experiment 3:
                                                       % OPTIONS:u_interp:
                                                       % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.exps.n_steps{iexp}=3;                            % Number of pulses _|-|_|-|_ 
 inputs.exps.u_min{iexp}=0*ones(1,inputs.exps.n_steps{3});
 inputs.exps.u_max{iexp}=1*ones(1,inputs.exps.n_steps{3});        % Minimum and maximum value for the input
  inputs.exps.tf_type{iexp}='fixed';                       % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.tf_type{iexp}='od';                       % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.tf_max{iexp}=120;                               % Experiment duration
 inputs.exps.tf_min{iexp}=60;                               % Experiment duration
 inputs.exps.ts_type{iexp}='fixed';                          % [] Type of sampling times: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.n_s{iexp}=20;
end
for iexp=6:7
 inputs.exps.exp_type{iexp}='od';  
 inputs.exps.obs_type{iexp}='fixed'; 
 inputs.exps.obs{iexp}='states';
% inputs.exps.max_obs{iexp}=5;
 inputs.exps.u_type{iexp}='od';                           % Type of stimulation: 'fixed' | 'od' (to be designed) 
 inputs.exps.u_interp{iexp}='step';                   % Stimuli definition for experiment 3:
                                                       % OPTIONS:u_interp:
                                                       % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.exps.n_steps{iexp}=5;                            % Number of pulses _|-|_|-|_ 
 inputs.exps.u_min{iexp}=0*ones(1,inputs.exps.n_steps{6});
 inputs.exps.u_max{iexp}=1*ones(1,inputs.exps.n_steps{6});        % Minimum and maximum value for the input
  inputs.exps.tf_type{iexp}='fixed';                       % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.tf_type{iexp}='od';                       % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.tf_max{iexp}=120;                               % Experiment duration
 inputs.exps.tf_min{iexp}=60;                               % Experiment duration
 inputs.exps.ts_type{iexp}='fixed';                          % [] Type of sampling times: 'fixed'(default) | 'od' (to be designed) 
 inputs.exps.n_s{iexp}=20;
end

% 
% %
% %  INPUTS FOR THE EXPERIMENT TO BE OPTIMALLY DESIGNED
% %
%   inputs.exps.obs{4}='states';
%   inputs.exps.u_type{4}='fixed';                           % Type of stimulation: 'fixed' | 'od' (to be designed) 
%   inputs.exps.u_interp{4}='step';                   % Stimuli definition for experiment 3:
% %                                                        % OPTIONS:u_interp:
% %                                                        % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
%   inputs.exps.n_steps{4}=4;                            % Number of pulses _|-|_|-|_ 
%   %inputs.exps.u_min{4}=0*ones(1,inputs.exps.n_steps{4});
%   %inputs.exps.u_max{4}=1*ones(1,inputs.exps.n_steps{4});        % Minimum and maximum value for the input
%   inputs.exps.u{4}=[1.0000	  0.0000	  0.5209	  0.0000	  0.9999	  0.3752	  0.3048];
%   inputs.exps.t_con{4}=[0.0000	 10.9523	 17.8372	 24.6263	 35.8015	 38.5715	 48.8467	 62.1829];
%   inputs.exps.tf_type{4}='fixed';                       % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
%   inputs.exps.t_f{4}=62.1829;                               % Experiment duration
%   inputs.exps.ts_type{4}='fixed';                          % [] Type of sampling times: 'fixed'(default) | 'od' (to be designed) 
%   inputs.exps.n_s{4}=20;
% %   inputs.exps.ts_type{4}='od';                      % [] Type of sampling times: 'fixed' | 'od' (to be designed) 
% %   inputs.exps.ts_0{4}=0;                          % First sampling time 
% %   inputs.exps.ts_min_dist{4}=5;                  % Minimum distance between sampling times
% % 
% 
% 
%   inputs.exps.obs{5}='states';
%   inputs.exps.u_type{5}='od';                           % Type of stimulation: 'fixed' | 'od' (to be designed) 
%   inputs.exps.u_interp{5}='step';                   % Stimuli definition for experiment 3:
% %                                                        % OPTIONS:u_interp:
% %                                                        % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
%   inputs.exps.n_steps{5}=5;                            % Number of pulses _|-|_|-|_ 
%   inputs.exps.u_min{5}=0*ones(1,inputs.exps.n_steps{3});
%   inputs.exps.u_max{5}=1*ones(1,inputs.exps.n_steps{3});        % Minimum and maximum value for the input
%   inputs.exps.tf_type{5}='od';                       % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
%   inputs.exps.tf_max{5}=120;                               % Experiment duration
%   inputs.exps.tf_min{5}=60;                               % Experiment duration
%   inputs.exps.ts_type{5}='fixed';                          % [] Type of sampling times: 'fixed'(default) | 'od' (to be designed) 
%   inputs.exps.n_s{5}=20;
% 
%  inputs.exps.ts_type{5}='od';                      % [] Type of sampling times: 'fixed' | 'od' (to be designed) 
%  inputs.exps.ts_0{5}=0;                          % First sampling time 
%  inputs.exps.ts_min_dist{5}=3;                  % Minimum distance between sampling times
% %    inputs.exps.tf_type{3}='od';                       % [] Type of sampling times: 'fixed' | 'od' (to be designed)
% %    inputs.exps.tf_min{3}=80;                        % Minimum allowed experiment duration
% %    inputs.exps.tf_guess{3}=100;                     % Initial guess for the experiment duration (to be optimized)
% %    inputs.exps.tf_max{3}=120;                       % Maximum allowed
% %    experiment duration
% 
%  inputs.exps.obs{6}='states';
%  inputs.exps.u_type{6}='od';                           % Type of stimulation: 'fixed' | 'od' (to be designed) 
%  inputs.exps.u_interp{6}='step';                   % Stimuli definition for experiment 3:
%                                                        % OPTIONS:u_interp:
%                                                        % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
%  inputs.exps.n_steps{6}=8;                            % Number of pulses _|-|_|-|_ 
%  inputs.exps.u_min{6}=0*ones(1,inputs.exps.n_steps{3});
%  inputs.exps.u_max{6}=1*ones(1,inputs.exps.n_steps{3});        % Minimum and maximum value for the input
%  inputs.exps.tf_type{6}='fixed';                       % [] Type of experiment duration: 'fixed'(default) | 'od' (to be designed) 
%  inputs.exps.t_f{6}=120;                               % Experiment duration
% %  inputs.exps.ts_type{3}='fixed';                          % [] Type of sampling times: 'fixed'(default) | 'od' (to be designed) 
% %  inputs.OEDsol.n_s{3}=20;
% 
%  inputs.exps.ts_type{6}='od';                      % [] Type of sampling times: 'fixed' | 'od' (to be designed) 
%  inputs.exps.ts_0{6}=0;                          % First sampling time 
%  inputs.exps.ts_min_dist{6}=5;                  % Minimum distance between sampling times
% %    inputs.exps.tf_type{3}='od';                       % [] Type of sampling times: 'fixed' | 'od' (to be designed)
% %    inputs.exps.tf_min{3}=80;                        % Minimum allowed experiment duration
% %    inputs.exps.tf_guess{3}=100;                     % Initial guess for the experiment duration (to be optimized)
% %    inputs.exps.tf_max{3}=120;                       % Maximum allowed
%    experiment duration


%======================================
% PARAMETERS TO BE CONSIDERED FOR OED
%======================================


% Parameters to be considered for OED 
inputs.PEsol.id_global_theta='all';  %  'all'|User selected  
% Nominal value of the parameters to compute the FIM
inputs.PEsol.global_theta_guess=inputs.model.par; 
inputs.PEsol.PEcost_type='lsq';
inputs.PEsol.lsq_type='Q_I';

%==================================
% COST FUNCTION RELATED DATA
%==================================    

 inputs.exps.noise_type='homo';                    % Type of experimental noise: 'homo' |'homo_var'| 'hetero'     

 inputs.exps.std_dev{3}=0.05;                      % Standard deviation of the noise for each experiment: Ex: 0.05 <=> 5%
 inputs.OEDsol.OEDcost_type='Eopt';                % FIM based criterium: 'Dopt'|'Eopt'|'Aopt'|'Emod'|'DoverE'
 


