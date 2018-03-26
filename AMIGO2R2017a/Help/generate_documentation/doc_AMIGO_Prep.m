%%
% <<logo_AMIGO2_small.png>>
%
% <html>
% <p style="color:#007946;font-size:18pt;text-align:right; margin-top: 1px; margin-bottom: 1px;"> <b>AMIGO_Prep</b></p>
% <hr align="left" width="820">
% </html>

%% Task description

   %%
   % <html>
   % <div style="background-color: #E6FAE6; margin-left: 1px; margin-right: 5px; padding-bottom: 1px; padding-left: 8px; padding-right: 8px; padding-top: 2px; line-height: 1.25">
   % <dl>Previous to any other task in AMIGO2, models need to be preprocessed. 
   % AMIGO_Prep interprets the inputs structure and creates the necessary
   % files for other tasks.</dl>
   % <dl> </dl>
   % <dl>The user may input the model directly by means of MATLAB, FORTRAN or
   % C functions. In these cases AMIGO_Prep will compile files and generate
   % mexfunctions when required.</dl>
   % <dl> </dl>
   % <dl>Alternatively user may input equations as strings in inputs.model.eqns. 
   % In this case AMIGO_Prep will generate functions for model simulation
   % and sensitivitiy analysis, as well as the necessary mex files.
   % In this scenario the user may select to generate:</dl>
   % <dl> </dl>
   % <ul>
   % <li> MATLAB code, inputs.model.input_model_type='charmodelM';</li>
   % <li> FORTRAN code, inputs.model.input_model_type='charmodelF';</li>  
   % <li> C code, inputs.model.input_model_type='charmodelC'. </li></ul></div>
   % </html>
   %

        
%% Call AMIGO_Prep from command line
   
%%
% It is recommended to keep all inputs in a *'problem_file'.m*. SObs task can then be called in two different ways:
%
% 1. Using the *inputs structure*:
%
%    > problem_file   
%
%    > AMIGO_Prep(inputs)     
%
% 2. Using the *input file*:
%
%    > AMIGO_Prep('problem_file') 
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
    
    
    
%% MATLAB model generation: charmodelM 
%
    %%
    % 
    % By defatult, AMIGO2 uses models implemented in MATLAB together with
    % MATLAB IVP solver ode15s.
    %%
    % This means that inputs.model.input_model_type is set to 'charmodelM';
    % In this case AMIGO_Prep will generate a .m file: *fcn_inputs.pathd.short_name*.m in the Results
    % folder: *AMIGO_PATH\Results\inputs.pathd.results_folder*
    
    inputs.model.input_model_type='charmodelM';
    MInputs=AMIGO_Prep(inputs);

    %%
    % You can inspect the model file:
    
    disp(MInputs.model.odes_file);

    %%
    % By default ode15s will be used to solve model equations and sensmat
    % to compute sensitivities. Check <doc_AMIGO_ivpsol.html IVP> solvers
    % for alternatives.
 
%%
%
%% FORTRAN model generation: charmodelF 
%
 
    %%
    % To enhance efficiency of simulation, the user may select to generate 
    % FORTRAN models. AMIGO_Prep will generate FORTRAN subroutines to solve
    % model equations and sensitivities. 
    % FORTRAN codes will be kept in folder: *AMIGO_PATH\Results\inputs.pathd.results_folder*
    %%
    % In addition, the FORTRAN codes will be mexed with the selected
    % FORTRAN IVP solver (RADAU5 is the default for model solution; ODESSA
    % is the default to compute sesitivities).
    % The following mexfiles will be created:
    % inputs.ivpsol.ivpsolverg_inputs.pathd.short_name.mexw32 and
    % odessag_inputs.pathd.short_name.mexw32.
    % Mexfiles will be kept in folder: *AMIGO_PATH\Results\inputs.pathd.results_folder*
   
    %%
    % Check <doc_AMIGO_ivpsol.html IVP> solvers to learn about more
    % options.
    
    inputs.model.input_model_type='charmodelF';
    FInputs=AMIGO_Prep(inputs);
    
    %%
    % The following files were generated
    
    disp(FInputs.model.odes_file);
    disp(FInputs.model.sens_file);
    disp([FInputs.pathd.problem_folder_path '\' FInputs.ivpsol.ivpmex '.mexw32']);
    disp([FInputs.pathd.problem_folder_path '\' FInputs.ivpsol.sensmex '.mexw32']);

    %% C model generation: charmodelC 
    % To enhance efficiency of simulation, the user may select to generate 
    % C models. AMIGO_Prep will generate a C funtion to solve model equations and sensitivities. 
    % C codes will be kept in folder: *AMIGO_PATH\Results\|inputs.pathd.results_folder*
    %%
    % CVODES will be used to solve C models.
    
inputs.model.input_model_type='charmodelC';
CInputs=AMIGO_Prep(inputs);

disp(CInputs.model.odes_file);
disp([CInputs.pathd.problem_folder_path '\' CInputs.ivpsol.ivpmex '.mexw32']);

    
   
   %% See also 

    %%
    % * <doc_AMIGO_Input.html How to input a problem in AMIGO2>
    % * <doc_AMIGO_ivpsol.html Initial value problem solvers in AMIGO2>
    % * <doc_AMIGO_exe_type.html C execution modes in AMIGO2>

    
    
    %% Important note
    
    %%
    % AMIGO_Prep must be excuted any time the model is modified. 
    % The only exception to this is the costMex and fullMex
    % execution modes for which AMIGO_Prep must be executed if either the model or
    % the observation function are modified.


    
