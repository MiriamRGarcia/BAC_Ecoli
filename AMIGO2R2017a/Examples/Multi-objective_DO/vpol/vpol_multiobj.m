%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE:Van der Pol DO problem
% Multi-objective formulation                                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%======================
% PATHS RELATED DATA
%======================
inputs.pathd.results_folder='vpol_multiO';             % Folder to keep results (in Results) for a given problem          
inputs.pathd.short_name='vpolm';                       % To identify figures and reports for a given problem   
inputs.pathd.runident='7linear';                       % Run identifier
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
 inputs.DOsol.y0=[0 1 0 0 ];                                %Initial conditions for each experiment   
 inputs.DOsol.tf_type='fixed';                              % Experiments duration (fixed or free)
 inputs.DOsol.tf_guess=5;
 


 % COST FUNCTIONS 
 inputs.DOsol.N_DOcost=2;                                   % Number of costs
 inputs.DOsol.DOcost_type='min';                            % max/min
 inputs.DOsol.DOcost{1}='y3';                               % Definition of costs
 inputs.DOsol.DOcost{2}='yu';


 % CVP DETAILS
  
 inputs.DOsol.u_interp='linear';                            % Stimuli definition                                                                   
 inputs.DOsol.n_linear=7;                                   % Control discretization level             
 inputs.DOsol.u_guess=0*ones(1,inputs.DOsol.n_linear);      % Initial guess for the input 
 inputs.DOsol.u_min=-0.3*ones(1,inputs.DOsol.n_linear);
 inputs.DOsol.u_max=1*ones(1,inputs.DOsol.n_linear);        % Minimum and maximum value for the input
 inputs.DOsol.t_con=[0:5/(inputs.DOsol.n_linear-1):5];      % Guess control switching times         
 inputs.DOsol.min_stepduration=0.25;                        % Min / Max control step duration
 inputs.DOsol.max_stepduration=1.0;


%==================================
 % NUMERICAL METHODS RELATED DATA
 %==================================
 %
 % SIMULATION
 inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'radau5'(default, fortran)|'rkf45'|'lsodes'|
 inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0D-7; 
 
% 
% OPTIMIZATION
%
inputs.nlpsol.nlpsolver='nsga2';                        % nsga2 Multiobjective global solver 
%                                                       
%                                                       

inputs.nlpsol.nsga2.popsize = 100;                      % nsga2 populaion size
inputs.nlpsol.nsga2.maxGen  = 100;                      % nsga2 max number of generations
inputs.nlpsol.nsga2.plotInterval = 5;                   % nsga2 interval between two calls of "plotnsga". 
%inputs.nlpsol.nsga2.initfun={@initpop, 'populations.txt'} %nsga2 use previous results to refine
inputs.nlpsol.nsga2.mutation={'gaussian',0.1, 0.5};     % nsga2 type of mutation


%==================================
% DISPLAY OF RESULTS
%==================================
inputs.plotd.number_max_pareto=5;                      % Maximum number of figures - pareto solutions