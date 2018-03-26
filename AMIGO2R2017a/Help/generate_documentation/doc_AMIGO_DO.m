%%
% <<logo_AMIGO2_small.png>>
%
% <html>
% <p style="color:#007946;font-size:18pt;text-align:right; margin-top: 1px; margin-bottom: 1px;"> <b>AMIGO_DO: Dynamic Optimization</b></p>
% <hr align="left" width="820">
% </html>


%%
% AMIGO_DO: solves multi- and single- objective dynamic optimization problems using the Control Vector Parameterization (CVP) approach
% This tool can be used for optimization based modeling (dynamic flux
% balance analysis (DFBA), enzyme activation optimization, etc.) and for
% stimulation design (dynamic metabolic engineering, bioprocess
% optimization, etc.)
%

%%
% It may handle:

%%
% * Single or multi-objective cases
% * Constraints on decision variables
% * Constraints on state variables

%%
% It may call several optimizers:

%%
% * LOCAL optimization methods: indirect and direct methods
% * MULTISTART of local methods
% * GLOBAL optimization methods: DE, SRES
% * HYBRID optimization methods: eSS, sequential hybrids
% * MULTI-objective solvers: NSGAII plus the weighted sum method;
%   Epsilon-constraint approach can be implemented using constraints

%%
% Options:

%%
% * 'run_identifier' to keep different folders for different runs, this avoids overwriting
% * 'nlp_solver' to rapidly change the optimization method
% * 'reopt' to activate ('on') re-optimization
% * 'reopt_local_solver' solver for reoptimization
% * 'n_reOpts' number of reoptimizations


%% Example

%%
% This is a well know dynamic optimization problem often used as a
% benchmark case for DO methods.
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
% $$ -0.3\leq(t)\leq 1 $$

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
%%
% 
% <<CVP.png>>
% 
%%
inputs.DOsol.u_interp='stepf';                         %Control definition 
                                                       %'sustained' |'stepf'|'step'|'linear'|
inputs.DOsol.n_steps=20;
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
inputs.nlpsol.nlpsolver='local_ipopt';              % In this case the problem can be solved with 
                                                      % a local optimizer


%%
% More information regarding the inputs used in this example can be
% found <doinputs.html here>.

AMIGO_Prep(inputs);
AMIGO_DO(inputs);

%% See also

%%
% * <doc_AMIGO_ivpsol.html IVP solvers>
% * <doc_AMIGO_Input.html How to input a problem in AMIGO>
% * <doc_AMIGO_DO_const.html How to solve a problem with constraints>
% * <doc_AMIGO_DO_Reopt.html How to re-optimize to refine stimulation profiles in CVP>
% * <doc_AMIGO_MultiObj_DO.html How to solve multi-objective dynamic optimization
%   problems with NSGA2>
% * <doc_AMIGO_MultiWSM_DO.html How to solve multi-objective dynamic optimization
%   problems with the weighted sum method (WSM)>

%% References

%%
% Tanartkit, P., & Biegler, L.T. (1995). Stable decomposition for dynamic
% optimization. I&EC Res., 34, 1253-1266.
%

%%
% Vassiliadis, V. S.; Balsa-Canto, E.; Banga, J. R. Second order
% sensitivities of general dynamic systems with application
% to optimal control problems. Chem. Eng. Sci. 1999, 54, 3851.
%


AMIGO_htmldoc_inputs(inputs,fullfile(pwd,'html','doinputs.html'));
