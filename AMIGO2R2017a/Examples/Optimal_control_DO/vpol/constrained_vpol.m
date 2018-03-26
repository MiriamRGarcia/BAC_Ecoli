%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE:Van der Pol DO problem
%                                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%======================
% PATHS RELATED DATA
%======================

inputs.pathd.results_folder='constrained_vpol';            % Folder to keep results (in Results) for a given problem          
inputs.pathd.short_name='cvpol';                           % To identify figures and reports for a given problem   
inputs.pathd.runident='20step';                            % To identify this specific run
%======================
% MODEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelC';                % Model introduction: 'charmodelF'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'fortranmodel'|                        
                                                           %                     'blackboxmodel'|'blackboxcost                             
inputs.model.n_st=5;                                       % Number of states      
inputs.model.n_par=0;                                      % Number of model parameters 
inputs.model.n_stimulus=1;                                 % Number of inputs, stimuli or control variables   
inputs.model.st_names=char('y1','y2','y3','yc1','yc2');                % Names of the states                                              
%inputs.model.par_names=char('nopars');                           % Names of the parameters                     
inputs.model.stimulus_names=char('uu');                    % Names of the stimuli, inputs or controls                      
inputs.model.eqns=...                                      % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
                char('dy1=(1-y2*y2)*y1-y2+uu',...
                     'dy2=y1',...
                    'dy3=y1*y1+y2*y2+uu*uu',...
                     'dyc1=(fmax(y1,0))^2',...
                     'dyc2=(fmax(-0.4-y1,0))^2');
                

%==========================================
% Dynamic optimization problem formulation
%==========================================
 inputs.DOsol.y0=[0 1 0 0 0];                           %Initial conditions  
 inputs.DOsol.tf_type='fixed';                          %Duration (fixed or free)
 inputs.DOsol.tf_guess=5;
 


 % COST FUNCTION
 
 inputs.DOsol.DOcost_type='min';                        % max/min
 inputs.DOsol.DOcost='y3';

 % ALGEBRAIC CONSTRAINTS
 
 % END POINT CONSTRAINTS. Note that to define PATH CONSTRAINTS new states have to be added to the system
 % dynamics. This allows to transform Path into final-time constraints.
  
%  inputs.DOsol.n_const_eq_tf=0;
%  inputs.DOsol.const_eq_tf=[];                                 % c(y,u,tf)=0
%  inputs.DOsol.eq_const_max_viol=1.0e-6;

 inputs.DOsol.n_const_ineq_tf=2;
 inputs.DOsol.const_ineq_tf=char('yc1','yc2');                    % c(y,u,tf)<=0
 inputs.DOsol.ineq_const_max_viol=1.0e-6;
 
    

% CVP DETAILS 
 inputs.DOsol.u_interp='stepf';                                    % Stimuli definition for experiment 3:
                                                                   % OPTIONS:u_interp:
                                                                   % 'sustained' |'step'|'linear'
 inputs.DOsol.n_steps=20;
 inputs.DOsol.u_guess=0.4*ones(1,inputs.DOsol.n_steps);            % Initial guess for the input 
 inputs.DOsol.u_min=-0.3*ones(1,inputs.DOsol.n_steps);
 inputs.DOsol.u_max=1*ones(1,inputs.DOsol.n_steps);                % Minimum and maximum value for the input
 inputs.DOsol.t_con=linspace(0,inputs.DOsol.tf_guess,inputs.DOsol.n_steps+1);       % Input swithching times: Initial and final time   
 
 
 
%==================================
% NUMERICAL METHODS RELATED DATA
%==================================
%
 
% SIMULATION
inputs.ivpsol.ivpsolver='cvodes';                      % [] IVP solver: 'cvodes'(default, C)|'ode15s' (default, MATLAB, sbml)|'ode113'|'ode45'
inputs.ivpsol.rtol=1.0D-7;                             % [] IVP solver integration tolerances
inputs.ivpsol.atol=1.0D-7; 
 
 
% 
% OPTIMIZATION
%
inputs.nlpsol.nlpsolver='local_solnp';                  % [] NLP solver: 
%                                                       % LOCAL: 'local_fmincon'|'local_n2fb'|'local_dn2fb'|'local_dhc'|
%                                                       %        'local_ipopt'|'local_solnp'|'local_nomad'|
%                                                       % MULTISTART:'multi_fmincon'|'multi_n2fb'|'multi_dn2fb'|'multi_dhc'|
%                                                       %            'multi_ipopt'|'multi_solnp'|'multi_nomad'|
%                                                       % GLOBAL: 'de'|'sres'
%                                                       % HYBRID: 'hyb_de_fmincon'|'hyb_de_n2fb'|'hyb_de_dn2fb'|'hyb_de_dhc'|'hyp_de_ipopt'|
%                                                       %         'hyb_de_solnp'|'hyb_de_nomad'|
%                                                       %         'hyb_sres_fmincon'|'hyb_sres_n2fb'|'hyb_sres_dn2fb'|'hyb_sres_dhc'|
%                                                       %         'hyp_sres_ipopt'|'hyb_sres_solnp'|'hyb_sres_nomad'
%                                                       % METAHEURISTICS:
%                                                       % 'ess' or 'eSS' (default)
%                                                       % Note that the corresponding defaults are in files: 
%                                                       % OPT_solvers\DE\de_options.m; OPT_solvers\SRES\sres_options.m; 
%                                                       % OPT_solvers\eSS_**\ess_options.m
%                                                       
inputs.nlpsol.reopt='off';                     % Reoptimization after convergence
inputs.nlpsol.reopt_local_solver='solnp';     % Optimizer for reoptimization
inputs.nlpsol.n_reOpts=2;                     % Number of reoptimizations