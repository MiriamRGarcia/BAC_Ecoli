%% AMIGO_DO -- Dynamic Optimization with constraints

%%
% AMIGO_DO can handle non-linear path and point constraints as well as bounds on the
% stimuli. Path constraints and point constraints (except for end-point
% constraints) will be handled by forcing an integral measure of their
% violation to a value close to zero (violation tolerance). This will imply
% a modification of the model to incorporate constraint violation over
% time or at specific times.
% 

%% See also

%%
% * <doc_AMIGO_ivpsol.html IVP solvers>
% * <doc_AMIGO_Input.html How to input a problem in AMIGO>
% * <doc_AMIGO_DO.html How to solve unconstrained dynamic optimization problems>
% * <doc_AMIGO_DO_Reopt.html How to re-optimize to refine stimulation profiles in CVP>
% * <doc_AMIGO_MultiObj_DO.html How to solve multi-objective dynamic optimization
%   problems>
% * <doc_AMIGO_MultiWSM_DO.html How to solve multi-objective dynamic optimization
%   problems with the weighted sum method (WSM)>
%% Example

%%
% This is a well know dynamic optimization problem often used as a
% benchmark case for DO methods.
% The objective is to simultaneously minimize the amplitude of the
% oscillations and the control effort subject to the oscillator
% dynamics and maximum and minimum allowed values for the control $$ u $$.
%
% REMARK: two path constraints are impossed:
%           -0.4<=y_1(t) , t in [0,t_f]
%           y_1(t)<=0, t in [0, t_f]    

%%        
% $$ min_u ~~  J=y_3(t_f) $$

%%
% $$ \frac{dy_1}{dt}=(1-y_2*y_2)*y_1-y_2+u $$

%%
% $$ \frac{dy_2}{dt}=y_1 $$

%%
% $$ \frac{dy_3}{dt}=y_1^2+y_2^2+u^2 $$

%%
% $$ -0.3\leq u(t)\leq 1 $$

%%
% $$ -0.4\leq y_1(t) \leq 0 $$ 

clear;

%======================
% PATHS RELATED DATA
%======================

inputs.pathd.results_folder='constrained_vpol';   % Folder to keep results (in Results\)          
inputs.pathd.short_name='cvpol';                  % To identify figures and reports    

%======================
% MODEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelC';               % Model type                          
inputs.model.n_st=5;                                      % Number of states      
inputs.model.n_par=0;                                     % Number of parameters
inputs.model.n_stimulus=1;                                % Number of stimuli    
inputs.model.st_names=char('y1','y2','y3','yc1','yc2');   % Names of the states                                                           
inputs.model.stimulus_names=char('uu');                   % Names of the stimuli                     
 inputs.model.eqns=...                                    % Model
                char('dy1=(1-y2*y2)*y1-y2+uu',...
                     'dy2=y1',...
                    'dy3=y1*y1+y2*y2+uu*uu',...
                     'dyc1=(fmax(y1,0))^2',...        % Handles path constraint violation (see Figure)
                     'dyc2=(fmax(-0.4-y1,0))^2');     % Handles path constraint violation (see Figure)
%%
%
% <<CVP_Constraint.png>>
%

%==========================================
% Dynamic optimization problem formulation
%==========================================
 inputs.DOsol.y0=[0 1 0 0 0];                         % Initial conditions   
 inputs.DOsol.tf_type='fixed';                        % Experiments duration (fixed or free)
 inputs.DOsol.tf_guess=5;
 


% COST FUNCTION
 
 inputs.DOsol.DOcost_type='min';                     % max/min
 inputs.DOsol.DOcost='y3';

% ALGEBRAIC CONSTRAINTS
 
% END POINT CONSTRAINTS. Note that to define PATH CONSTRAINTS new states have 
% to be added to the system dynamics. 
%This allows to transform Path into final-time constraints.
  
%  inputs.DOsol.n_const_eq_tf=0;
%  inputs.DOsol.const_eq_tf=[];                           % c(y,u,tf)=0
%  inputs.DOsol.eq_const_max_viol=1.0e-6;

 inputs.DOsol.n_const_ineq_tf=2;                          % Constraint violation must be close to zero 
 inputs.DOsol.const_ineq_tf=char('yc1','yc2');            % c(y,u,tf)<=0
 inputs.DOsol.ineq_const_max_viol=1.0e-6;
 

% CVP DETAILS 
 inputs.DOsol.u_interp='stepf';                           % Stimuli interpolation 
 inputs.DOsol.n_steps=20;                                 % Number of steps
 inputs.DOsol.u_guess=0.4*ones(1,inputs.DOsol.n_steps);   % Initial guess for the input 
 inputs.DOsol.u_min=-0.3*ones(1,inputs.DOsol.n_steps);
 inputs.DOsol.u_max=1*ones(1,inputs.DOsol.n_steps);       % Minimum and maximum value for the input
 inputs.DOsol.t_con=[0:5/inputs.DOsol.n_steps:5];         % Input swithching times   
 

%==================================
% NUMERICAL METHDOS RELATED DATA
%==================================

% SIMULATION                                              % Default for charmodel C: CVODES 

%OPTIMIZATION
inputs.nlpsol.nlpsolver='local_ipopt';                    % In this case the problem can be solved with 
                                                          % a local optimizer


%%
% More information regarding the inputs used in this example can be
% found <doinputsc.html here>.

AMIGO_Prep(inputs);
AMIGO_DO(inputs);


%% References

%%
% Vassiliadis, V. S.; Balsa-Canto, E.; Banga, J. R. Second order
% sensitivities of general dynamic systems with application
% to optimal control problems. Chem. Eng. Sci. 1999, 54, 3851.
%


AMIGO_htmldoc_inputs(inputs,fullfile(pwd,'html','doinputsc.html'));
