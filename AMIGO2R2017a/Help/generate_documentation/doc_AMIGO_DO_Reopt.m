%% AMIGO_DO -- Dynamic Optimization with re-optimization

%%
% Re-optimization is used to iteratively smooth stimulation profiles with stepf interpolation. In this way, large control discretization levels
% can be achieved with reasonable computational effort. The idea is to solve the DO problem with a a coarse
% discretization level and from the optimal solution run the optimization
% with twice the discretization level. Re-optimizations can be run as many
% times as desired.
% Re-optimization is typically used in combination with local optimizers. 
%

%%
%
% <<CVP_Reopt.png>>
%
%%
% Options:

%%
% * 'run_identifier' to keep different folders for different runs, this avoids overwriting
% * 'nlp_solver' to rapidly change the optimization method
% * 'reopt' to activate ('on') re-optimization
% * 'reopt_local_solver' solver for reoptimization
% * 'n_reOpts' number of reoptimizations

%% See also

%%
% * <doc_AMIGO_ivpsol.html IVP solvers>
% * <doc_AMIGO_Input.html How to input a problem in AMIGO>
% * <doc_AMIGO_DO.html AMIGO_DO: How to solve unconstrained dynamic optimization problems>
% * <doc_AMIGO_DO_const.html How to solve a problem with constraints>
%% Example

%%
%
% The objective is to simultaneously minimize the amplitude of the
% oscillations and the control effort subject to the oscillator
% dynamics and maximum and minimum allowed values for the control $$ u $$:

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
% The problem will be first solved with a discretization level of 10 steps.
% Re-optimizations will be performed till a final discretization of 


clear;

%===========================
%RESULTS  PATHS RELATED DATA
%===========================

inputs.pathd.results_folder='vpol';  % Folder to keep results (in Results\) 
inputs.pathd.short_name='vpol';      % To identify figures and reports    
   

%======================
% MODEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelF';               % Model type                          
inputs.model.n_st=3;                                      % Number of states  
inputs.model.n_par=0;                                     % Number of parameters
inputs.model.n_stimulus=1;                                % Number of stimuli    
inputs.model.st_names=char('y1','y2','y3');               % Names of the states                                                           
inputs.model.stimulus_names=char('uu');                   % Names of the stimuli                     
inputs.model.eqns=char(...                                % Model
    'dy1=(1-y2*y2)*y1-y2+uu',...
    'dy2=y1',...
    'dy3=y1*y1+y2*y2+uu*uu');


%==========================================
% Dynamic optimization problem formulation
%==========================================
inputs.DOsol.y0=[0 1 0];                               %Initial conditions
inputs.DOsol.tf_type='fixed';                          %Process duration type: fixed or free
inputs.DOsol.tf_guess=5;                               %Process duration

%COST FUNCTION
inputs.DOsol.DOcost_type='min';                        %Type of problem: max/min
inputs.DOsol.DOcost='y3';                              %Cost functional

%CVP (Control Vector Parameterization) DETAILS
inputs.DOsol.u_interp='stepf';                         %Control definition 
                                                       %'sustained' |'stepf'|'step'|'linear'|
inputs.DOsol.n_steps=10;
inputs.DOsol.u_guess=0.7.*ones(1,inputs.DOsol.n_steps);% Initial guess for the input
inputs.DOsol.u_min=-0.3.*ones(1,inputs.DOsol.n_steps);
inputs.DOsol.u_max=1.*ones(1,inputs.DOsol.n_steps);    % Minimum and maximum value for the input
inputs.DOsol.t_con=0:5/inputs.DOsol.n_steps:5;         % Input swithching times, including intial and
                                                       % final times

%==================================
% NUMERICAL METHDOS RELATED DATA
%==================================

% SIMULATION
inputs.ivpsol.ivpsolver='radau5';
inputs.ivpsol.senssolver='odessa';

inputs.ivpsol.rtol=1.0D-7;
inputs.ivpsol.atol=1.0D-7;

%OPTIMIZATION
inputs.nlpsol.reopt='on';                             % Re-optimization: 'on' | 'off' 
inputs.nlpsol.nlpsolver='local_ipopt';                % In this case the problem can be solved with 
                                                      % a local optimizer

inputs.nlpsol.reopt_local_solver='local_fmincon';     % Solver used for re-optimization          
inputs.nlpsol.n_reOpts=3;                             % Number of re-optimizations
                                                      % Final discretization level: 80 (2x(2x(2x10))

%%
% More information regarding the inputs used in this example can be
% found <doinputsr.html here>.

AMIGO_Prep(inputs);
AMIGO_DO(inputs);


%% References

%%
%
% Balsa-Canto, E.; Banga, J. R.; Alonso, A.A.; Vassiliadis, V.S. Dynamic optimization of chemical and biochemical processes using
% restricted second-order information. Compt. & Chem. Eng. 2001, 25: 539-546.
%


AMIGO_htmldoc_inputs(inputs,fullfile(pwd,'html','doinputsr.html'));
