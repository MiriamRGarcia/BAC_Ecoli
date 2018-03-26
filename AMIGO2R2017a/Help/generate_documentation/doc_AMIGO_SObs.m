%%
% <<logo_AMIGO2_small.png>>
%
% <html>
% <p style="color:#007946;font-size:18pt;text-align:right; margin-top: 1px; margin-bottom: 1px;"> <b>AMIGO_SObs</b></p>
% <hr align="left" width="820">
% </html>

%% Task description

%%
% <html>
% <div style="background-color: #E6FAE6; margin-left: 1px; margin-right: 5px; padding-bottom: 1px; padding-left: 8px; padding-right: 8px; padding-top: 2px; line-height: 1.25">
% <dl> Solves model under a given experimental scheme and plots observables evolution vs time.    
% By default inputs.model.par and inputs.exps.exp_y0{iexp} are used for
% simulation. </dl>
% <dl> Alternatively, inputs.PEsol.global_theta_guess, .global_theta_y0_guess, 
% .local_theta_guess{iexp} and .local_theta_y0_guess{iexp}, 
% will be used, if supplied by the user. </dl> 
% </div>
% </html>
%


%% Call AMIGO_SObs from command line

%%
% It is recommended to keep all inputs in a *'problem_file'.m*. SObs task can then be called in two different ways:
%
% 1. Using the *inputs structure*:
%
%    > problem_file   
%
%    > AMIGO_SObs(inputs)     
%
% 2. Using the *input file*:
%
%    > AMIGO_SObs('problem_file') 
%
%    > AMIGO_SObs('problem_file','run_ident')  
%

%% Example

  
% TITLE: The circadian clock in Arabidopsis thaliana
%%
%
% <<circadian.png>>
%
%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='arabidopsis';  % Folder to keep results (in Results\) 
inputs.pathd.short_name='arabidopsis';      % Label to identify figures and reports 

%============================
% MODEL DEFINITION    
%============================           
inputs.model.n_st=7;                        % Number of states                   
inputs.model.n_par=27;                      % Number of parameters             
inputs.model.n_stimulus=1;                  % Number of stimuli              
inputs.model.st_names=char('CL_m','CL_c',...% Names of the states 
    'CL_n','CT_m','CT_c','CT_n','CP_n');    

inputs.model.par_names=char('n1','n2','g1','g2','m1','m2','m3','m4','m5','m6',...
    'm7','k1','k2','k3','k4','k5','k6','k7','p1','p2',...
    'p3','r1','r2','r3','r4','q1','q2');    % Names of the parameters       

inputs.model.stimulus_names=char('light');  % Names of the stimuli               
inputs.model.eqns=...                       % Model equations               
    char('dCL_m=q1*CP_n*light+n1*CT_n/(g1+CT_n)-m1*CL_m/(k1+CL_m)',...
    'dCL_c=p1*CL_m-r1*CL_c+r2*CL_n-m2*CL_c/(k2+CL_c)',...
    'dCL_n=r1*CL_c-r2*CL_n-m3*CL_n/(k3+CL_n)',...
    'dCT_m=n2*g2^2/(g2^2+CL_n^2)-m4*CT_m/(k4+CT_m)',...
    'dCT_c=p2*CT_m-r3*CT_c+r4*CT_n-m5*CT_c/(k5+CT_c)',...
    'dCT_n=r3*CT_c-r4*CT_n-m6*CT_n/(k6+CT_n)',...
    'dCP_n=(1-light)*p3-m7*CP_n/(k7+CP_n)-q2*light*CP_n');
    %% 
    % IMPORTANT:
    %
    % User may select any customised name but: n, t, u, y, ydot, par, tlast,
    % told, pend and v which are reserved words
  
inputs.model.par=[7.5038 0.6801 1.4992 3.0412 10.0982... % Nominal parameter
    1.9685 3.7511 2.3422 7.2482 1.8981 1.2 3.8045...     % values 
    5.3087 4.1946 2.5356 1.4420 4.8600 1.2 2.1994...
    9.4440 0.5 0.2817 0.7676 0.4364 7.3021 4.5703 1.0]; 

%============================================
% EXPERIMENTAL SCHEME (SIMULATION CONDITIONS)    
%============================================

inputs.exps.n_exp=2;                          % Number of experiments               
 
% EXPERIMENT 1
   
inputs.exps.exp_y0{1}=[0 0 0 0 0 0 0];        % Initial conditions
inputs.exps.t_f{1}=120;                       % Experiments duration     
   
inputs.exps.n_obs{1}=2;                       % Number of observables            
inputs.exps.obs_names{1}=char('Lum','mRNAa'); % Names of the observables    
inputs.exps.obs{1}=char('Lum=CL_m',...        % Observation function
                          'mRNAa=CT_m');         
   
inputs.exps.u_interp{1}='sustained';          % Stimuli definition for experiment 1
inputs.exps.t_con{1}=[0 120];                 % Input swithching times including: 
                                              % Initial and final time             
inputs.exps.u{1}=1;                           % Values of the inputs for exp 1            
inputs.exps.n_s{1}=15;                        % Number of sampling times


% EXPERIMENT 2

inputs.exps.exp_y0{2}=[0 0 0 0 0 0 0];        % Initial conditions
inputs.exps.t_f{2}=120;                       % Experiments duration     
   
inputs.exps.n_obs{2}=2;                       % Number of observables            
inputs.exps.obs_names{2}=char('Lum','mRNAa'); % Names of the observables    
inputs.exps.obs{2}=char('Lum=CL_m',...        % Observation function
                          'mRNAa=CT_m');  

inputs.exps.u_interp{2}='pulse-down';         % Stimuli definition for experiment 2              
inputs.exps.n_pulses{2}=5;                    % Number of pulses              
inputs.exps.u_min{2}=0;                       % Minimum and maximum of inputs
inputs.exps.u_max{2}=1;        
inputs.exps.t_con{2}=0:12:120;                % Input switching times          
inputs.exps.n_s{2}=25;                        % Number of sampling times


%%
%
% <<stimuli_interp.png>>
%

    %%
    % More information regarding the inputs used in this example can be
    % found <sobsex1.html here>. 


%================================
% CALL AMIGO2 from COMMAND LINE    
%================================
AMIGO_Prep(inputs);           % To preprocess the model & generate Fortran, C or MATLAB code 
AMIGO_SObs(inputs);         % To perform task SObs



%% See also

    %%
    % * <doc_AMIGO_ivpsol.html IVP solvers in AMIGO2>
    % * <doc_AMIGO_Input.html How to input a problem in AMIGO2>
    %

%% References

%%
% Model was taken from:
%
% Locke J.C.W; A.J. Millar; M.S. Turner. Modelling genetic networks with noisy and varied 
% experimental data: the circadian clock in Arabidopsis thaliana. J Theor Biol,2005, 234:383-393. 
%

AMIGO_htmldoc_inputs(inputs,fullfile(pwd,'html','sobsex1.html'));   



   