%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: Bacterial growth in batch culture 
% Author: E. Balsa-Canto
% Read batch_bac_growht.pdf for details on the implementation and use of 
% this script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='Bacterial_batch_growth'; % Folder to keep results (in Results) for a given problem                       
inputs.pathd.short_name='bbg';                        % To identify figures and reports for a given problem 
                                                       % ADVISE: the user may introduce any names related to the problem at hand 
inputs.pathd.runident='r1';                           % [] Identifier required in order not to overwrite previous results
                                                       %    This may be modified from command line. 'run1'(default)
                                                     

%============================
% MODEL RELATED DATA
%============================
inputs.model.input_model_type='charmodelC';          % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                                     %                     'blackboxmodel'|'blackboxcost                   
inputs.model.n_st=2;                                 % Number of states                                  
inputs.model.n_par=4;                                % Number of model parameters                                  
inputs.model.n_stimulus=0;                           % Number of inputs, stimuli or control variables   
inputs.model.names_type='custom';                    % [] Names given to states/pars/inputs: 'standard' (x1,x2,...p1,p2...,u1, u2,...) 
                                                     %                                       'custom'(default)
inputs.model.st_names=char('cb','cs');               % Names of the states                                         
inputs.model.par_names=char('mumax','ks','kd','yield');             % Names of the parameters                   
inputs.model.stimulus_names=[];                      % Names of the stimuli, inputs or controls                                  
inputs.model.eqns=...                                % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
            char('dcb=((mumax*cs*cb)/(ks+cs))-kd*cb',...  
                 'dcs= -((mumax*cs*cb)/(ks+cs))/yield');
   
 mumax=0.4;  ks=5.0;  kd=0.05;  yield=0.5;             
 inputs.model.par=[mumax ks kd yield];               % Nominal value for the parameters, this allows to fix known parameters
                                                     % These values may be updated during optimization  

%==================================
% SIMULATION RELATED DATA
%==================================
 inputs.exps.n_exp=1;                                 % Number of experiments                                                                  
 inputs.exps.exp_y0{1}=[2 30];                        % Initial conditions for each experiment       
 inputs.exps.t_f{1}=10;                               % Experiments duration
                                                          
 
%==================================
% DISPLAY OF RESULTS
%==================================
% 
inputs.plotd.plotlevel='full';                        % [] Display of figures: 'full'|'medium'(default)|'min' |'noplot' 
inputs.plotd.figsave=1;                               % Save plots in .fig format 1 (yes), 0(no)

