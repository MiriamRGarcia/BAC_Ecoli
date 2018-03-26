% $Header$
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model: Thermal isomerization of alfa-pinene
%       REF:   R.E. Fuguitt y J. E. Hawkins, 1947. Rate of thermal isomerization
%               of Alpha-pinene in the liquid phase. J. A. C. S., 69:461
% 
% For Model discrimination
%  original model
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='alpha_pinene';          % Folder to keep results (in Results) for a given problem                       
inputs.pathd.short_name='pinene';                    % To identify figures and reports for a given problem 
                                                     % ADVISE: the user may introduce any names related to the problem at hand 
inputs.pathd.runident='';                            % [] Identifier required in order not to overwrite previous results
                                                     %    This may be modified from command line. 'run1'(default)
                                                     

%============================
% MODEL RELATED DATA
%============================
inputs.model.input_model_type='charmodelC';          % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                                     %                     'blackboxmodel'|'blackboxcost                   
inputs.model.n_st=5;                                 % Number of states                                  
inputs.model.n_par=5;                                % Number of model parameters                                  
inputs.model.n_stimulus=0;                           % Number of inputs, stimuli or control variables   
inputs.model.names_type='custom';                    % [] Names given to states/pars/inputs: 'standard' (x1,x2,...p1,p2...,u1, u2,...) 
                                                     %                                       'custom'(default)
inputs.model.st_names=char('y1','y2','y3','y4','y5');% Names of the states                                         
inputs.model.par_names=char('p1','p2','p3','p4','p5');% Names of the parameters                   
inputs.model.stimulus_names=[];                      % Names of the stimuli, inputs or controls                                  
inputs.model.eqns=...                                % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
            char('dy1=-(p1+p2)*y1',...  
                 'dy2= p1*y1',...
                 'dy3= p2*y1-(p3+p4)*y3+p5*y5',...
                 'dy4= p3*y3',...
                 'dy5= p4*y3-p5*y5');
   
 p1=5.93e-5;
 p2=2.96e-5;
 p3=2.05e-5;
 p4=27.5e-5;
 p5=4e-5;

inputs.model.par=[p1 p2 p3 p4 p5];      % Nominal value for the parameters, this allows to fix known parameters
                                                      % These values may be updated during optimization  

%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================

 inputs.exps.n_exp=1;                                 % Number of experiments                                                                  
 inputs.exps.n_obs{1}=5;                              % Number of observed quantities per experiment                         
 inputs.exps.obs_names{1}=char('obsy1','obsy2','obsy3','obsy4','obsy5');                  % Observation function
 inputs.exps.obs{1}=char('obsy1=y1','obsy2=y2','obsy3=y3','obsy4=y4','obsy5=y5');
 inputs.exps.exp_y0{1}=[100 0 0 0 0];                 % Initial conditions for each experiment       
 inputs.exps.t_f{1}=36420;                            % Experiments duration
 inputs.exps.n_s{1}=9;                                % Number of sampling times
 inputs.exps.t_s{1}=[0 1230 3060 4920 7800 10680 15030 22620 36420];                         % [] Sampling times, by default equidistant
 

%==================================
% EXPERIMENTAL DATA RELATED INFO
%==================================
inputs.exps.data_type='pseudo';                     % Type of data: 'pseudo'|'pseudo_pos'|'real'             


 
 %==================================
 % NUMERICAL METHODS RELATED DATA
 %==================================
 %
 % SIMULATION
 inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'radau5'(default, fortran)|'rkf45'|'lsodes'|


 inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes' (C)


 inputs.ivpsol.rtol=1.0e-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0e-7; 
