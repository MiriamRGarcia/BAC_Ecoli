%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE:Lee-Ramirez bioreactor
%                                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%======================
% PATHS RELATED DATA
%======================

inputs.pathd.results_folder='LRbioreactor';        % Folder to keep re(u1+u2)lts (in Re(u1+u2)lts) for a given problem          
inputs.pathd.short_name='LR';                      % To identify figures and reports for a given problem   
inputs.pathd.runident='20stepf';                   % Run identifieer
%======================
% MODEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelC';                % Model introduction: 'charmodelF'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'fortranmodel'|                        
                                                           %                     'blackboxmodel'|'blackboxcost                             
inputs.model.n_st=8;                                       % Number of states      
inputs.model.n_par=3;                                      % Number of model parameters 
inputs.model.n_stimulus=2;                                 % Number of inputs, stimuli or control variables   
inputs.model.st_names=char('y1','y2','y3','y4','y5','y6','y7','y8');                % Names of the states                                              
inputs.model.par_names=char('c1','c2','c3');                           % Names of the parameters                     
inputs.model.stimulus_names=char('u1','u2');                    % Names of the stimuli, inputs or controls                      
inputs.model.eqns=...                                      % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
                char( 't1 = 14.35+y3+(y3^2/111.5)',...
                     't2 = 0.22+y5',...
                     't3 = y6+0.22/t2*y7',...
                     'g1 = y3/t1*(y6+y7*0.22/t2)',...
                     'g2 = 0.233*y3/t1*((0.0005+y5)/(0.022+y5))',...
                     'g3 = 0.09*y5/(0.034+y5)',...
                     'dy1 = u1+u2',...
                     'dy2 = g1*y2-(u1+u2)*y2/y1',...
                     'dy3 = u1/y1*c1-(u1+u2)*y3/y1-g1*y2/c2',...
                     'dy4 = g2*y2-(u1+u2)*y4/y1',...
                     'dy5 = u2*c3/y1-(u1+u2)*y5/y1',...
                     'dy6 = -g3*y6',...
                     'dy7 = g3*(1-y7)',...
                     'dy8 = u2');

c1 = 100; c2 = 0.51; c3 = 4.0;
inputs.model.par=[c1 c2 c3];


%==========================================
% Dynamic optimization problem formulation
%==========================================
 inputs.DOsol.y0=[1.0 0.1 40.0 0.0 0.0 1.0 0.0 0.0];               %Initial conditions for each experiment   
 inputs.DOsol.tf_type='fixed';                                     % Experiments duration (fixed or free)
 inputs.DOsol.tf_guess=10.0;
 


 % COST FUNCTION
 
 inputs.DOsol.DOcost_type='max';                                    % max/min
 inputs.DOsol.DOcost='y1*y4-0.0*y8';                               % Formulation with Q=0, no inducer cost

% CVP DETAILS 
 inputs.DOsol.u_interp='stepf';                                    % Stimuli definition for experiment 3:
                                                                   % OPTIONS:u_interp:
                                                                   % 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.DOsol.n_steps=[20];
 inputs.DOsol.u_guess(1,:)=0.5*ones(1,inputs.DOsol.n_steps);       % Initial guess for the input 
 inputs.DOsol.u_min(1,:)=0*ones(1,inputs.DOsol.n_steps);
 inputs.DOsol.u_max(1,:)=1*ones(1,inputs.DOsol.n_steps);           % Minimum and maximum value for the input
 
 inputs.DOsol.u_guess(2,:)=0.5*ones(1,inputs.DOsol.n_steps);        % Initial guess for the input 
 inputs.DOsol.u_min(2,:)=0*ones(1,inputs.DOsol.n_steps);
 inputs.DOsol.u_max(2,:)=1.0*ones(1,inputs.DOsol.n_steps);           % Minimum and maximum value for the input
 
 inputs.DOsol.t_con=linspace(0,inputs.DOsol.tf_guess,inputs.DOsol.n_steps+1);       % Input swithching times: Initial and final time   
 

 
 %==================================
 % NUMERICAL METHODS RELATED DATA
 %==================================
 %
 % SIMULATION
 inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver
 inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
 inputs.ivpsol.atol=1.0D-7; 
 
 % OPTIMIZATION
inputs.nlpsol.nlpsolver='local_fmincon';               % Local SQP method
inputs.nlpsol.reopt='off';                              % Reoptimization after convergence
inputs.nlpsol.reopt_local_solver='fmincon';            % Optimizer for reoptimization
inputs.nlpsol.n_reOpts=2;                              % Number of reoptimizations
 
 