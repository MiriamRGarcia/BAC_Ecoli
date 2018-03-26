%%
% <html>
% <p style="color:#007946;font-size:18pt;text-align:right; margin-top: 1px; margin-bottom: 1px;"> <b>Stimuli definition</b></p>
% <hr align="left" width="820">
% </html>


%%
% AMIGO2 allows to parameterize the stimuli using piecewise low order
% interpolations. It also considers some usual types of stimulation, such as sustained or pulse-wise.
% Following possibilities are available:
%%
% * Sustained stimulation
% * Step-wise interpolation
% * Pulsed: pulse-up and pulse-down stimulation
% * Linear interpolation
% 
%%
% <<stimuli_interp.png>>
%%
% REMARK that linear interporlation can be used to define any of the other
% approximations.

%% Illustrative example: The circadian clock in Arabidopsis thaliana
 
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
  
inputs.model.par=[7.5038 0.6801 1.4992 3.0412 10.0982... % Nominal parameter
    1.9685 3.7511 2.3422 7.2482 1.8981 1.2 3.8045...     % values 
    5.3087 4.1946 2.5356 1.4420 4.8600 1.2 2.1994...
    9.4440 0.5 0.2817 0.7676 0.4364 7.3021 4.5703 1.0]; 

%============================================
% EXPERIMENTAL SCHEME (SIMULATION CONDITIONS)    
%============================================

inputs.exps.n_exp=1;                          % Number of experiments               
 
% EXPERIMENT 1
   
inputs.exps.exp_y0{1}=[0 0 0 0 0 0 0];        % Initial conditions
inputs.exps.t_f{1}=120;                       % Experiments duration     
   
inputs.exps.n_obs{1}=2;                       % Number of observables            
inputs.exps.obs_names{1}=char('Lum','mRNAa'); % Names of the observables    
inputs.exps.obs{1}=char('Lum=CL_m',...        % Observation function
                          'mRNAa=CT_m');         
          
AMIGO_Prep(inputs);

%% Illustrative example: Sustained stimulation 

inputs.exps.u_interp{1}='sustained';          % Stimuli definition for experiment 1
inputs.exps.t_con{1}=[0 120];                 % Input swithching times including: 
                                              % Initial and final time             
inputs.exps.u{1}=1;                           % Values of the inputs for exp 1   


AMIGO_SObs(inputs);


%% Illustrative example: Pulse-down stimulation 
%  Stimulation starts in its maximum value and follows a pulse-wise profile
inputs.exps.n_s{1}=2;                       % Experiments duration 
inputs.exps.t_s{1}=[0 120];                       % Experiments duration
inputs.exps.u_interp{1}='pulse-down';                 
inputs.exps.n_pulses{1}=5;                     % Number of pulses            
inputs.exps.u_min{1}=0;inputs.exps.u_max{1}=1; % Min and Max stimuli value       
inputs.exps.t_con{1}=0:120/(2*5):120;          % Stimuli switching times plus initial & final time
                                               % Dimension: 2*n_pulses+1;  |-|_|-|_
                                              

AMIGO_SObs(inputs);

%% Illustrative example: Pulse-up stimulation 
%  Stimulation starts in its minimum value and follows a pulse-wise profile
inputs.exps.u_interp{1}='pulse-up';                 
inputs.exps.n_pulses{1}=4;                     % Number of pulses   
inputs.exps.u_min{1}=0;inputs.exps.u_max{1}=1; % Min and Max stimuli value      
inputs.exps.t_con{1}=0:120/(2*4+1):120;        % Stimuli switching times plus initial & final time
                                               % Dimension: 2*n_pulses+2; _|-|_|-|_

AMIGO_SObs(inputs);


%% Illustrative example: Step wise stimulation
inputs.exps.u_interp{1}='step';                 
inputs.exps.n_steps{1}=5;                      % Number of steps
inputs.exps.u{1}=[0 0.5 1 0.5 0]               % Stimuli value during each step - 
                                               % Dimension: n_steps
inputs.exps.t_con{1}=[0 20 40 80 100 120];     % Stimuli switching times plus initial & final time   
                                               % Dimension: n_steps+1


AMIGO_SObs(inputs);

%% Illustrative example: Linear interpolation

inputs.exps.u_interp{1}='linear';                                           
inputs.exps.n_linear{1}=7;                     % Number of interpolating points
inputs.exps.u{1}=[0 1 0 1 0 1 1];              % Value of the stimuli in every switching point
                                               % Dimension: n_linear
inputs.exps.t_con{1}=0:20:120;                 % Stimuli switching times plus initial & final time   
                                               % Dimension: n_linear


AMIGO_SObs(inputs);

%AMIGO_htmldoc_inputs(inputs,fullfile(pwd,'html','stimex1.html'));



