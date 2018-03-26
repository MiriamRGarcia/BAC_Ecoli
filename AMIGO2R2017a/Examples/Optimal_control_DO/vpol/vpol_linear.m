%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: Dynamic optimization van der Pol oscillator 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%====================
% Brief description:
%====================

%        This is a well know dynamic optimization problem often used as a
%        test case for DO methods.
%        The objective is to simultaneously minimize the amplitude of the 
%        oscillations and the control effort subject to the oscillator
%        dynamics and maximum and minimum allowed values for the control u
%        min J=y3(tf)
%        dy1/dt=(1-y2*y2)*y1-y2+u
%        dy2/dt=y1
%        dy3/dt=y1^2+y2^2+u^2
%        -0.3<=u(t)<=1

%=============
% References:
%=============

%  > Tanartkit, P., & Biegler, L.T. (1995). Stable decomposition for dynamic
%    optimization. I&EC Res., 34, 1253-1266.  
%  > Vassiliadis, V. S.; Balsa-Canto, E.; Banga, J. R. Second order
%    sensitivities of general dynamic systems with application
%    to optimal control problems. Chem. Eng. Sci. 1999, 54, 3851.
%

%====================
% AMIGO2 TESTS   :
%====================

% Here the problem will be solved by means of the following CVP
% configuration: 6 linear elements (n_linear=7)
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%======================
% PATHS RELATED DATA
%======================

inputs.pathd.results_folder='vpol';         % Folder to keep results (in Results) for a given problem          
inputs.pathd.short_name='vpol';             % To identify figures and reports for a given problem   
inputs.pathd.runident='7linear';            % To identify this specific run
%======================
% MDOEL RELATED DATA
%======================

inputs.model.input_model_type='charmodelC';                % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                                           %                     'blackboxmodel'|'blackboxcost                             
inputs.model.n_st=3;                                       % Number of states      
inputs.model.n_par=0;                                      % Number of model parameters 
inputs.model.n_stimulus=1;                                 % Number of inputs, stimuli or control variables   
inputs.model.st_names=char('y1','y2','y3');                % Names of the states                                              
inputs.model.stimulus_names=char('uu');                    % Names of the stimuli, inputs or controls                      
inputs.model.eqns=...                                      % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
                     char('dy1=(1-y2*y2)*y1-y2+uu',...
                       'dy2=y1',...
                       'dy3=y1*y1+y2*y2+uu*uu');              

%==========================================
% Dynamic optimization problem formulation
%==========================================
 inputs.DOsol.y0=[0 1 0];                                   %Initial conditions  
 inputs.DOsol.tf_type='fixed';                              %Process duration type: fixed or free
 inputs.DOsol.tf_guess=5;                                   %Process duration
 
 % COST FUNCTION
 
 inputs.DOsol.DOcost_type='min';                            %Type of problem: max/min
 inputs.DOsol.DOcost='y3';                                  %Cost functional 

 % CVP DETAILS 
 inputs.DOsol.u_interp='linear';                            %Control definition
                                                            %'sustained' |'stepf'|'step'|'linear'|'pulse-up'|'pulse-down' 
 inputs.DOsol.n_linear=7;                                   %Discretization level
 inputs.DOsol.u_guess=0.7*ones(1,inputs.DOsol.n_linear);    %Initial guess for the input 
 inputs.DOsol.u_min=-0.3*ones(1,inputs.DOsol.n_linear);
 inputs.DOsol.u_max=1*ones(1,inputs.DOsol.n_linear);        %Minimum and maximum value for the input
 
 
 inputs.DOsol.t_con=linspace(0,inputs.DOsol.tf_guess,inputs.DOsol.n_linear);       % Input swithching times: Initial and final time             
 inputs.DOsol.min_stepduration=0.5;                         %Minimum control element duration 
 inputs.DOsol.max_stepduration=4;                           %Maximum control element duration 
 
%==================================
% NUMERICAL METHDOS RELATED DATA
%==================================
%
% SIMULATION
inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: 'cvodes'(default, C)|'ode15s' (default, MATLAB, sbml)|'ode113'|'ode45'


inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes'(default, C)| 'sensmat'(matlab)|'fdsens2'|'fdsens5' 


inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
inputs.ivpsol.atol=1.0D-7; 
 

% OPTIMIZATION
inputs.nlpsol.nlpsolver='eSS';                        % [] NLP solver: 
%                                                       % LOCAL: 'local_fmincon'|'local_n2fb'|'local_dn2fb'|'local_dhc'|
%                                                       %        'local_ipopt'|'local_solnp'|'local_nomad'||'local_nl2sol'
%                                                       %        'local_lsqnonlin'
%                                                       % MULTISTART:'multi_fmincon'|'multi_n2fb'|'multi_dn2fb'|'multi_dhc'|
%                                                       %            'multi_ipopt'|'multi_solnp'|'multi_nomad'|'multi_nl2sol'
%                                                       %            'multi_lsqnonlin'
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

inputs.nlpsol.eSS.maxeval = 10000;
inputs.nlpsol.eSS.maxtime = 10;
inputs.nlpsol.eSS.local.solver = 'fmincon';
inputs.nlpsol.eSS.local.finish = 'fmincon';
