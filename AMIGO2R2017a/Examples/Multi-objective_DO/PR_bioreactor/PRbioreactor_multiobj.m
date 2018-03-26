%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TITLE: Park-Ramirez bioreactor  - Multi-Objective implementation
%
%Park, S., Ramirez, W. F. (1988). Optimal production of secreted protein in 
% fed-batch reactors. AIChE J. 34(8), 1550 – 1558.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%======================
% PATHS RELATED DATA
%======================

inputs.pathd.results_folder='PRbioreactor_multiobj';        % Folder to keep results (in Results) for a given problem          
inputs.pathd.short_name='PRmultiO';                         % To identify figures and reports for a given problem   
inputs.pathd.runident='20step';                             % Run identifier
%======================
% MODEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelC';                % Model introduction: 'charmodelF'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'fortranmodel'|                        
                                                           %                     'blackboxmodel'|'blackboxcost                             
inputs.model.n_st=6;                                       % Number of states      
inputs.model.n_par=9;                                      % Number of model parameters 
inputs.model.n_stimulus=1;                                 % Number of inputs, stimuli or control variables   
inputs.model.st_names=char('y1','y2','y3','y4','y5','ytf');                % Names of the states                                              
inputs.model.par_names=char('c1','c2','c3','c4','c5','c6','c7','c8','c9');                           % Names of the parameters                     
inputs.model.stimulus_names=char('uu');                    % Names of the stimuli, inputs or controls                      
inputs.model.eqns=...                                      % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
                char('g3=c1*y4/((c2 + y4)*(c3 + y4))',...
                     'g2=y4*exp(-c4*y4)/(c5+y4)',...
                     'g1=c6*g3/(c7+g3)',... 
                     'a=uu/y5',...
                     'dy1=g1*(y2-y1)-a*y1',...
                     'dy2=g2*y3-a*y2',...
                     'dy3=g3*y3-a*y3',...
                     'dy4=-c8*g3*y3+a*(c9-y4)',...
                     'dy5=uu',...
                     'dytf=1');
                 
                 
c1=21.870; c2=0.4; c3=62.50; c4=5.0; c5=0.10;
c6=4.75;; c7=0.12;; c8=7.3; c9=20.0;                 
inputs.model.par=[c1 c2 c3 c4 c5 c6 c7 c8 c9];               


%==========================================
% Dynamic optimization problem formulation
%==========================================
 inputs.DOsol.y0=[0 0 1 5 1 0];                                 %Initial conditions for each experiment   
 inputs.DOsol.tf_type='od';                                     % Experiments duration (fixed or od)
 inputs.DOsol.tf_guess=22.0;                                    % Initial guess final time
 inputs.DOsol.tf_min=12.0;                                       % Minimum and maximum process duration
 inputs.DOsol.tf_max=32.0;


  % COST FUNCTIONS
 inputs.DOsol.N_DOcost=2;
 
 inputs.DOsol.DOcost_type='min';                                % max/min
 inputs.DOsol.DOcost{2}='-y1*y5';                               % Production
 inputs.DOsol.DOcost{1}='ytf';                                  % Final process duration

 % ALGEBRAIC CONSTRAINTS
 
 % END POINT CONSTRAINTS. Note that to define PATH CONSTRAINTS new states have to be added to the system
 % dynamics. This allows to transform Path into final-time constraints.
  
 inputs.DOsol.n_const_eq_tf=0;
 inputs.DOsol.const_eq_tf=[];                                   % c(y,u,tf)=0
 inputs.DOsol.eq_const_max_viol=1.0e-6;
 inputs.DOsol.n_const_ineq_tf=1;
 inputs.DOsol.const_ineq_tf=char('y5-14.35');               % c(y,u,tf)<=0
 inputs.DOsol.ineq_const_max_viol=1.0e-6;


% CVP DETAILS 
 inputs.DOsol.u_interp='linearf';                                  % Stimuli definition for experiment 3:
                                                                   % OPTIONS:u_interp:
                                                                   % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.DOsol.n_linear=10;
 inputs.DOsol.u_guess=5*ones(1,inputs.DOsol.n_linear);             % Initial guess for the input 
 inputs.DOsol.u_min=0*ones(1,inputs.DOsol.n_linear);
 inputs.DOsol.u_max=10*ones(1,inputs.DOsol.n_linear);              % Minimum and maximum value for the input
 inputs.DOsol.t_con=linspace(0,inputs.DOsol.tf_guess,inputs.DOsol.n_linear);       % Input swithching times: Initial and final time   


 
 
 
 
%==================================
% NUMERICAL METHODS RELATED DATA
%==================================
%
% SIMULATION
 inputs.ivpsol.ivpsolver='cvodes';                        % [] IVP solver: 'cvodes' (Default)
 inputs.ivpsol.rtol=1.0D-7;                               % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0D-7; 
 
%
%  OPTIMIZATION
% 
inputs.nlpsol.nlpsolver='nsga2';                          % The multi-objective problems can be also solved with the weighted sum method
                                                          % using a inputs.nlpsol.global_solver or inputs.nlpsol.local_solver
inputs.nlpsol.nsga2.popsize = 100;                        % nsga2 population size
inputs.nlpsol.nsga2.maxGen  = 100;                        % nsga2 max number of generations
inputs.nlpsol.nsga2.plotInterval = 5;                     % nsga2 interval between two calls of "plotnsga". 
%inputs.nlpsol.nsga2.initfun={@initpop, 'populations.txt'} %nsga2 use previous results to refine
inputs.nlpsol.nsga2.mutation={'gaussian',0.1, 0.5};     % nsga2 type of mutation
%                                                 
% inputs.DOsol.n_wsm=51;                                  % Number of weights combinations in the wsm method 
% w1=sort(rand(inputs.DOsol.n_wsm,1));                    % Random wsm_mat
% inputs.DOsol.wsm_mat=[w1 ones(inputs.DOsol.n_wsm,1)-w1];

 