%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE:Van der Pol DO problem
%                                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%======================
% PATHS RELATED DATA
%======================
inputs.pathd.results_folder='vpol_multiO';                % Folder to keep results (in Results) for a given problem          
inputs.pathd.short_name='vpolm';                          % To identify figures and reports for a given problem   
inputs.pathd.runident='20step_11wsm';                     % Run identifier
%======================
% MODEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelC';                % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                                           %                     'blackboxmodel'|'blackboxcost                             
inputs.model.n_st=4;                                       % Number of states      
inputs.model.n_par=0;                                      % Number of model parameters 
inputs.model.n_stimulus=1;                                 % Number of inputs, stimuli or control variables   
inputs.model.st_names=char('y1','y2','y3','yu');                % Names of the states                                                          
inputs.model.stimulus_names=char('uu');                    % Names of the stimuli, inputs or controls                      
inputs.model.eqns=...                                      % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dy1=(1-y2*y2)*y1-y2+uu',...
                    'dy2=y1',...
                    'dy3=y1*y1+y2*y2',...
                    'dyu=uu*uu');


%==========================================
% Dynamic optimization problem formulation
%==========================================
 inputs.DOsol.y0=[0 1 0 0 ];                                          %Initial conditions for each experiment   
 inputs.DOsol.tf_type='fixed';                                     % Experiments duration (fixed or free)
 inputs.DOsol.tf_guess=5;
 


 % COST FUNCTIONS
 inputs.DOsol.N_DOcost=2;
 
 inputs.DOsol.DOcost_type='min';                                    % max/min
 inputs.DOsol.DOcost{1}='y3';
 inputs.DOsol.DOcost{2}='yu';


 % CVP DETAILS
  
 inputs.DOsol.u_interp='stepf';                             %Control definition
                                                            % 'sustained' |'stepf'|'step'|'linear'|'pulse-up'|'pulse-down' 
 inputs.DOsol.n_steps=20;
 inputs.DOsol.u_guess=0.7*ones(1,inputs.DOsol.n_steps);     % Initial guess for the input 
 inputs.DOsol.u_min=-0.3*ones(1,inputs.DOsol.n_steps);
 inputs.DOsol.u_max=1*ones(1,inputs.DOsol.n_steps);         % Minimum and maximum value for the input
 
 inputs.DOsol.t_con=[0:5/inputs.DOsol.n_steps:5];           % Input swithching times: Initial and final time   


%==================================
 % NUMERICAL METHODS RELATED DATA
 %==================================
 %
 % SIMULATION
 inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'radau5'(default, fortran)|'rkf45'|'lsodes'|


 inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes' (C)


 inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0D-7; 
 
% 
% OPTIMIZATION
                                    

inputs.nlpsol.nlpsolver='wsm_fmincon';                  % The multi-objective problems can be also solved with the weighted sum method
                                                        % using a inputs.nlpsol.global_solver or inputs.nlpsol.local_solver
                                                
inputs.DOsol.n_wsm=11;                                  % Number of weights combinations in the wsm method 
inputs.DOsol.wsm_mat=[ 1 0;
                        0.9 0.1;
                        0.8 0.2; 
                        0.7 0.3;
                        0.6 0.4;
                        0.5 0.5;
                        0.4 0.6;
                        0.3 0.7;
                        0.2 0.8;
                        0.1 0.9
                        0  1];
% w1=sort(rand(inputs.DOsol.n_wsm,1));                    % Random wsm_mat
% inputs.DOsol.wsm_mat=[w1 ones(inputs.DOsol.n_wsm,1)-w1];

%==================================
% DISPLAY OF RESULTS
%==================================
inputs.plotd.number_max_pareto=5;                      % Maximum number of figures - pareto solutions