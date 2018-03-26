%% AMIGO_DO -- Multi-objective Dynamic Optimization

%%
% AMIGO_DO: offers the possibility of solving multi-objective dynamic optimization problems.
% The idea is to obtain the Pareto front, i.e. the set of comprimises among
% different cost functions.
%
%%
%
% <<generic_pareto.png>>
%
%%
% It may handle:

%%
% * Constraints on decision variables
% * Constraints on state variables

%%
% It may call several optimizers:

%%
% * NSGAII designed to compute the Pareto front (see References for details)
% * The Weighted Sum Method, can be combined with any of the NLP solvers in
%   AMIGO2
% * LOCAL optimization methods: indirect and direct methods
% * MULTISTART of local methods
% * GLOBAL optimization methods: DE, SRES
% * HYBRID optimization methods: eSS, sequential hybrids
% * NSGAII plus the weighted sum method;
%   Epsilon-constraint approach can be implemented using constraints 

%%
% Options:

%%
% * 'run_identifier' to keep different folders for different runs, this avoids overwriting
% * 'nlp_solver' to rapidly change the optimization method

%% See also

%%
% * <doc_AMIGO_ivpsol.html IVP solvers>
% * <doc_AMIGO_Input.html How to input a problem in AMIGO>
% * <doc_AMIGO_DO.html How to solve unconstrained dynamic optimization problems>
% * <doc_AMIGO_DO_const.html How to solve a problem with constraints>
% * <doc_AMIGO_DO_Reopt.html How to re-optimize to refine stimulation profiles in CVP>
% * <doc_AMIGO_MultiWSM_DO.html How to solve multi-objective dynamic optimization
%   problems with the weighted sum method (WSM)>

%% Example

%%
% 
% The objectives are to minimize the amplitude of the oscillations and the control effort 
% subject to the oscillator dynamics and maximum and minimum allowed values for the control $$ u $$:

%%        
% $$ min_u ~~  J= [y_3(t_f)  y_u(t_f)$$

%%
% $$ \frac{dy_1}{dt}=(1-y_2*y_2)*y_1-y_2+u $$

%%
% $$ \frac{dy_2}{dt}=y_1 $$

%%
% $$ \frac{dy_3}{dt}=y_1^2+y_2^2 $$

%%
% $$ \frac{dy_u}{dt}=u^2 $$
%%
% $$ -0.3\leq(t)\leq 1 $$

clear;

%===========================
%RESULTS  PATHS RELATED DATA
%===========================

inputs.pathd.results_folder='vpol_multiO';  % Folder to keep results (in Results\) 
inputs.pathd.short_name='vpolm';            % To identify figures and reports    
   

%======================
% MODEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelC';          % Model type                        
inputs.model.n_st=4;                                 % Number of states      
inputs.model.n_par=0;                                % Number of model parameters 
inputs.model.n_stimulus=1;                           % Number of stimuli    
inputs.model.st_names=char('y1','y2','y3','yu');     % Names of the states                                                          
inputs.model.stimulus_names=char('uu');              % Names of the stimuli                     
inputs.model.eqns=...                                % Model
               char('dy1=(1-y2*y2)*y1-y2+uu',...
                    'dy2=y1',...
                    'dy3=y1*y1+y2*y2',...
                    'dyu=uu*uu');



%==========================================
% Dynamic optimization problem formulation
%==========================================
inputs.DOsol.y0=[0 1 0 0 ];                            %Initial conditions
inputs.DOsol.tf_type='fixed';                          %Process duration type: fixed or free
inputs.DOsol.tf_guess=5;                               %Process duration

%COST FUNCTIONS
 
inputs.DOsol.N_DOcost=2;                              %Number of objectives  
inputs.DOsol.DOcost_type='min';                       % max/min
inputs.DOsol.DOcost{1}='y3';                          % Objective 1
inputs.DOsol.DOcost{2}='yu';                          % Objective 2

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

% SIMULATION                                          % Default for charmodel C: CVODES 

% OPTIMIZATION
inputs.nlpsol.nlpsolver='nsga2';                      % Solves the problem using a multi-objective
                                                      % optimizer- nsga2
inputs.nlpsol.nsga2.popsize = 10*inputs.DOsol.n_steps;% nsga2 population size
inputs.nlpsol.nsga2.maxGen  = 10*inputs.DOsol.n_steps;% nsga2 max number of generations
inputs.nlpsol.nsga2.plotInterval =50;                 % nsga2 interval between two calls of "plotnsga". 
%inputs.nlpsol.nsga2.initfun={@initpop, 'populations.txt'} %nsga2 use previous results to refine
inputs.nlpsol.nsga2.mutation={'gaussian',0.1, 0.5};   % nsga2 type of mutation


%==================================
% DISPLAY OF RESULTS
%==================================
inputs.plotd.number_max_pareto=5;                     % Maximum number of figures - Pareto optimal profiles
                                                      
                                                      
                                                      
                                                      %%
% More information regarding the inputs used in this example can be
% found <doinputsm.html here>.

AMIGO_Prep(inputs);
AMIGO_DO(inputs);


%% References

%%
% Deb, K.; Pratap, A.; Agarwal, S.; Meyarivan, T.
% A fast and elitist multiobjective genetic algorithm: NSGA-II
% IEEE Trans Evol Compt. 2002, 6(2):181-197
%



AMIGO_htmldoc_inputs(inputs,fullfile(pwd,'html','doinputsm.html'));
