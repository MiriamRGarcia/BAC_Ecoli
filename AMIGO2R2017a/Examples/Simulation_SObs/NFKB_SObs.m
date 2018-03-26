% $Header: svn://.../trunk/AMIGO2R2016/Examples/NFkB/nfkb_model.m 2398 2015-12-04 07:06:07Z evabalsa $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: The NFKB module
%
%  The model considered in this work was proposed in:
%  Lipniacki T, Paszek P, Brasier A, Luxon B, Kimmel M: Mathematical model of
%  NFkB regulatory module. J Theor Biol 2004, 228:195-215.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


inputs.pathd.results_folder='NFKB';                    % Name of the folder to keep results
inputs.pathd.short_name='NFKB';                        % To be used for problem results folders and files

%----------------------------------------------------------------------------------------------------------------
%
% MODEL RELATED DATA
%
inputs.model.input_model_type='charmodelC';            % Model introduction: |'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                                       %                     'blackboxmodel'|'blackboxcost       
inputs.model.n_st=15;                                  %  Number of states  
inputs.model.n_par=29;                                 %  Number of parameters in the model
inputs.model.n_stimulus=1;                             %  Number of stimulus/inputs/controls in the model
                                                       %  Names of the states in the model
inputs.model.st_names=char('IKKn','IKKa','IKKi','IKKaIkBa','IKKaIkBaNFkB','NFkB','NFkBn','A20','A20t',...
                           'IkBa','IkBan','IkBat','IkBaNFkB','IkBanNFkBn','cgent');

                                                        % Names of the model parameters                          
inputs.model.par_names=char('a1','a2','t1','a3','t2','c1a','c2a','c3a','c4a','c5a',...
                            'c6a','c1','c2','c3','c4','c5','k1','k2','k3','kprod','kdeg',...
                            'kv','i1','e2a','i1a','e1a','c1c','c2c','c3c');
                                                        % Names of the stimulus                         
inputs.model.stimulus_names=char('Tr');
                                                        % Ordinary differential equations 
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
     
                                                        % Nominal parameter values when available
inputs.model.par=[0.5 0.2 0.1 1 0.1 5e-7 0 0.0004 0.5 ...
                 0.0001 0.00002 5e-7 0 0.0004 0.5 0.0003 ...
                 0.0025 0.1 0.0015 0.000025 0.000125 5 ...
                 0.0025 0.01 0.001 0.0005 5e-7 0 0.0004];


%----------------------------------------------------------------------------------------------------------------
%
% EXPERIMENTAL SCHEME RELATED DATA
%

 inputs.exps.n_exp=2;                                   % Number of experiments
                                                        % Initial conditions per experiment
 for iexp=1:inputs.exps.n_exp   
 inputs.exps.exp_y0{iexp}=[0.2  0 0 0 0  3.155e-004 2.2958e-003 ...
                 4.78285e-003 2.8697e-006 2.50663e-003...
                 3.43573e-003 2.86971e-006 0.06 ...
                 7.888e-005 2.86971e-006];        
 end
                                                        % Final time per experiment
 for iexp=1:inputs.exps.n_exp
 inputs.exps.t_f{iexp}=3*60*60;  
 end

                                                        % Stimulus related data    
 inputs.exps.u_interp{1}='sustained';                   % [] Stimuli definition: u_interp: 'sustained' |'step'|'linear'(default)|
                                                        %                               'pulse-up'|'pulse-down'
 inputs.exps.t_con{1}=[0 3*60*60];                      % stimulus swithching times, experiment 1  
 inputs.exps.u{1}(1,:)=1;                               % stimulus values, experiment 1
 
 inputs.exps.u_interp{2}='pulse-down';                  % [] Stimuli definition: u_interp: 'sustained' |'step'|'linear'(default)|
                                                        %                              'pulse-up'|'pulse-down'
 inputs.exps.n_pulses{2}=1;                             % Number of pulses
 inputs.exps.u_min{2}=0;inputs.exps.u_max{2}=1;         % Bounds for the stimuli
 inputs.exps.t_con{2}=[0 30*60 3*60*60];                % Initial time-Times of changes for the stimuli- Final stimulation time   

 
 for iexp=1:inputs.exps.n_exp                                    
 inputs.exps.n_obs{iexp}=6;                             % number of observables
                                                        % names of observables
 inputs.exps.obs_names{iexp}=char('NFkBn','TIkBa_c','A20mRNA','TIKK','IKK_a','IkBa_t');
                                                        % Observables definition
 inputs.exps.obs{iexp}=char('NFkB_n=NFkBn',...
                            'TIkBa_c=IkBa+IkBaNFkB',...
                            'A20mRNA=A20t',...
                            'TIKK=IKKn+IKKa+IKKi',...
                            'IKK_a=IKKa',...
                            'IkBa_t=IkBat');
 end    
                                                    
 
