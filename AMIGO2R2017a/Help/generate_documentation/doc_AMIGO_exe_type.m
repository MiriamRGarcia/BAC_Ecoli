%%
% <html>
% <p style="color:#007946;font-size:18pt;text-align:right; margin-top: 1px; margin-bottom: 1px;"> <b>Enhanced execution modes with C</b></p>
% <hr align="left" width="820">
% </html>

%%
% <html>
% <div style="background-color: #E6FAE6; margin-left: 1px; margin-right: 5px; padding-bottom: 1px; padding-left: 8px; padding-right: 8px; padding-top: 2px; line-height: 1.25">
% <p>AMIGO2 offers several enhanced C based excution modes (inputs.model.exe_type):</p>
% <ul>
% <li> 'standard': generates model in C and the corresponding mex to solve it with CVODES</li>
% <li> 'costMex': evaluates the model plus the least squares (LSQ) function using C </li>
% <li> 'fullMex': generates mex that solves the parameter estimation problem with dn2fb </li>
% <li> 'fullC': generates a gcc command to solve parameter estimation problems from 
% Windows or Linux command-line </li>
% </div>
% </html>


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

  
%==================================
% EXPERIMENTAL DATA RELATED INFO
%==================================
                             
% EXPERIMENT 1
inputs.exps.data_type='real';                 % Type of data                                  

inputs.exps.exp_data{1}=[                     % Matrix of ns{iexp} x n_obs{iexp}         
    0.037642  0.059832                        % with experimental data         
    1.398618  0.983442
    1.606762  0.433379
    0.265345  0.628819
    1.417288  0.858973
    1.381613  0.496637
    0.504584  0.717923
    1.240249  0.862584
    1.180193  0.634508
    0.775945  0.679648
    1.514514  0.735783
    0.904653  0.593644
    0.753736  0.759013
    1.389312  0.678665
    0.833228  0.574736
    ];


% EXPERIMENT 2

inputs.exps.exp_data{2}=[
    0.146016  0.018152
    0.831813  1.002499
    1.874870  0.816779
    1.927580  0.544111
    1.139536  0.354476
    0.876938  0.520424
    0.559600  0.802322
    1.273548  0.939453
    1.696482  0.687495
    1.065496  0.577896
    0.847460  0.524076
    0.517520  0.738095
    1.162232  0.826737
    1.421504  0.779833
    1.340639  0.550493
    0.563822  0.515605
    0.402755  0.714877
    1.029856  0.871118
    1.490741  0.840174
    1.580873  0.692047
    0.696610  0.459481
    0.141546  0.646803
    0.804194  0.925806
    1.622378  0.824711
    1.525194  0.537398
    ];

%==================================
% PARAMETER ESTIMATION RELATED INFO
%==================================

inputs.PEsol.id_global_theta=...
   char('n1','n2','m1','m4','m6','m7','k1','k4','p3');  % List of parameters to be estimated
                                                        % Option
inputs.PEsol.global_theta_guess=[...                    % Initial guess for the parameter values
    6.09794                                             % Options: mean(max,min) if not provided
    0.710144
    8.92735
    2.38504
    2.11024
    1.29912
    4.32079
    2.45277
    0.493076]';
inputs.PEsol.global_theta_max=[ 60.9794                 % Upper bound for the parameter values
    7.1014
   89.2735
   23.8504
   21.1024
   12.9912
   43.2079
   24.5277
    4.9308]';
inputs.PEsol.global_theta_min=[ 0.0610                  % Lower bound for the parameter values
    0.0071
    0.0893
    0.0239
    0.0211
    0.0130
    0.0432
    0.0245
    0.0049]';

inputs.PEsol.id_local_theta_y0{1}=char('CL_c','CP_n');    % List of initial conditions to be locally 
inputs.PEsol.local_theta_y0_max{1}=[1 1];                 % estimated i.e. they get different values for
inputs.PEsol.local_theta_y0_min{1}=[0 0];                 % experiments 1 and 2
inputs.PEsol.local_theta_y0_guess{1}=[0.5 0.5];           % Default: 'none'

inputs.PEsol.id_local_theta_y0{2}=char('CL_c','CP_n');
inputs.PEsol.local_theta_y0_max{2}=[1 1];
inputs.PEsol.local_theta_y0_min{2}=[0 0];
inputs.PEsol.local_theta_y0_guess{2}=[0.5 0.5];

%====================================
% PARAMETER ESTIMATION COST FUNCTION
%====================================

inputs.PEsol.PEcost_type='lsq';                           % Least squares is the only possibility for 
                                                          % 'costMex', 'fullMex', 'fullC' 
inputs.PEsol.lsq_type='Q_I';                              % Identity matrix is used to weight least 
                                                          % squares


%% Example Standard

inputs.model.input_model_type='charmodelC';               % Model type must be 'charmodelC' to use C
inputs.model.exe_type='standard';                         % To generate model in C and solve it with 
                                                          % CVODES

%================================
% CALL AMIGO2 from COMMAND LINE    
%================================

CInputs=AMIGO_Prep(inputs);                               % Generates model equations and mex for 
                                                          % CVODES

disp(CInputs.model.odes_file);
disp([CInputs.pathd.problem_folder_path '\' CInputs.ivpsol.ivpmex '.mexw32']);

%% Example costMex

inputs.model.input_model_type='charmodelC';              % Model type must be 'charmodelC' to use C      
inputs.model.exe_type='costMex';                         % To generate Least squares function in C

%================================
% CALL AMIGO2 from COMMAND LINE    
%================================

[inputs privstruct]=AMIGO_Prep(inputs);

    %%
    % You can use the mexfile to evaluate the objetive function value.

feval(inputs.model.mexfunction,'cost_LSQ');
fprintf(1,'Objective function value=%e\n',outputs.f);

    %%
    % The mexfile is located in:

disp(inputs.model.mexfile);

    %%
    % We can also compute the trajectories

feval(inputs.model.mexfunction,'sim_CVODES');

    %%
    % We can also compute sensitivities

feval(inputs.model.mexfunction,'sens_FSA_CVODES');


    %% Example fullMex

inputs.model.input_model_type='charmodelC';              % Model type must be 'charmodelC' to use C
inputs.model.exe_type='fullMex';                         % Generates mex to solve the parameter 
                                                         % estimation problem in C
inputs.nlpsol.nlpsolver='local_dn2fb';                   % Optimization solver - least squares solver
inputs.nlpsol.cvodes_gradient=1;                         % To activate gradient evaluation
inputs.nlpsol.iterprint=0;                               % To dissable printing

%================================
% CALL AMIGO2 from COMMAND LINE    
%================================

AMIGO_Prep(inputs);                                      % Generates fullMex 
AMIGO_PE(inputs);                                        % Solves the parameter estimation problem



    %% Example fullC

inputs.model.input_model_type='charmodelC';              % Model type must be 'charmodelC' to use C
inputs.model.exe_type='fullC';                           % Generates gcc command
inputs.nlpsol.nlpsolver='local_dn2fb';                   % Optimization solver - least squares solver
inputs.nlpsol.cvodes_gradient=1;                         % To activate gradient evaluation
[inputs privstruct]=AMIGO_Prep(inputs);

      %%
    % The data will be necessary.
    
save('fullC_data','inputs','privstruct')

    %%
    % We return a gcc command you can use in the windows or linux
    % command-line
   
disp(inputs.model.comp_fullC);

res=regexp(inputs.model.comp_fullC,'\n*\n','split');
system(res{3});


switch computer
    
    case {'PCWIN','PCWIN64'}
        
        system('main fullC_data.mat save_fullC_data.mat sim_CVODES');
        
    otherwise
        
        system('./main fullC_data.mat save_fullC_data.mat sim_CVODES');
end

    %%
    % The results are stored in save_fullC_data,mat
 
load save_fullC_data;
figure;
plot(outputs.simulation{1});

%% See also

    %%
    % * <doc_AMIGO_Input.html How to input a problem in AMIGO2>
    % * <doc_AMIGO_PE.html How to solve parameter estimation problems>
    %%
    %


    %%
    %
    
AMIGO_htmldoc_inputs(inputs,fullfile(pwd,'html','extypeex1.html'));     
clear;

