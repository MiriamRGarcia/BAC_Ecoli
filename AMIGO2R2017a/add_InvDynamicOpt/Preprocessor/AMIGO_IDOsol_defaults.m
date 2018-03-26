% AMIGO_DOsol_defaults: Assign defaults that MAY NOT be modified by user 
%
%******************************************************************************
% AMIGO2: dynamic modeling, optimization and control of biological systems    % 
% Code development:     Eva Balsa-Canto                                       %
% Address:              Process Engineering Group, IIM-CSIC                   %
%                       C/Eduardo Cabello 6, 36208, Vigo-Spain                %
% e-mail:               ebalsa@iim.csic.es                                    %
% Copyright:            CSIC, Spanish National Research Council               %
%******************************************************************************
%
%*****************************************************************************%
%                                                                             %
%  AMIGO_DOsol_defaults: Assign defaults that are required for Prep and DO    % 
%*****************************************************************************%



inputs_def.IDOsol.N_IDOcost=1;
inputs_def.IDOsol.u_interp='stepf';
inputs_def.IDOsol.tf_type='fixed';            % Type of experiment duration: 'fixed' | 'od' (to be designed)

inputs_def.IDOsol.y0=[];


inputs_def.exps.n_exp=20;   
for iexp=inputs_def.exps.n_exp:-1:1
inputs_def.IDOsol.u_min{iexp}=[];
inputs_def.IDOsol.u_max{iexp}=[];
inputs_def.IDOsol.u_guess{iexp}=[];
inputs_def.IDOsol.tf_guess{iexp}=[];
inputs_def.IDOsol.t_con{iexp}=[];
inputs_def.IDOsol.n_steps{iexp}=[];
inputs_def.IDOsol.n_linear{iexp}=[];
inputs_def.IDOsol.n_pulses{iexp}=[];
inputs_def.IDOsol.min_stepduration{iexp}=[];        % For step or linear interpolation 
inputs_def.IDOsol.max_stepduration{iexp}=[];        % For step or linear interpolation 
end
inputs_def.IDOsol.death_penalty='off';
inputs_def.IDOsol.n_const_eq_tf=0;
inputs_def.IDOsol.const_eq_tf=[];
inputs_def.IDOsol.n_const_ineq_tf=0;
inputs_def.IDOsol.const_ineq_tf=[];
inputs_def.IDOsol.n_control_const=0;
inputs_def.IDOsol.IDOcost_type='min';
inputs_def.IDOsol.IDOcost='AMIGO_IDOcost';
inputs_def.IDOsol.IDOcostJac_type=[];         % type of the Jacobian: [user_pecostjac, mkl, lsq,llk] see details in AMIGO_PEJac
inputs_def.IDOsol.IDOcostJac_fun = [];           % user defined Jacobian as function handler
inputs_def.IDOsol.IDOcostJac_file = [];          % user defined Jacobian as a file
inputs_def.IDOsol.IDOcost_type='lsq';
inputs_def.IDOsol.lsq_type='QI';
inputs_def.IDOsol.llk_type='homo_var';
inputs_def.IDOsol.eq_const_max_viol=1.0e-5;
inputs_def.IDOsol.ineq_const_max_viol=1.0e-5;
inputs_def.IDOsol.n_wsm=10;
inputs_def.IDOsol.wsm_mat=[];
inputs_def.IDOsol.n_pconst_ineq=0;         % Number of point constraints 
inputs_def.IDOsol.tpointc=[];              % Times for point contraints
inputs_def.IDOsol.n_control_const=0;
inputs_def.IDOsol.control_const=[];         % c(u)<=0
inputs_def.IDOsol.control_const_max_viol=1.0e-5;
inputs_def.IDOsol.tf_min=0;
inputs_def.IDOsol.tf_max=[]; 
inputs_def.IDOsol.user_cost=0;                 % The user may need to modify the generated cost function

inputs_def.IDOsol.id_par=[];                   % parameters or sustained stimuli to be optimised                 

inputs_def.IDOsol.par_guess=[];
inputs_def.IDOsol.par_max=[];
inputs_def.IDOsol.par_min=[];
inputs_def.IDOsol.n_par=0;

inputs_def.IDOsol.id_y0=[];                   % initial conditions to be designed
inputs_def.IDOsol.y0_max=[];                  % Maximum allowed values for the initial conditions
inputs_def.IDOsol.y0_min= [ ];                % Minimum allowed values for the initial conditions
inputs_def.IDOsol.y0_guess= [ ]; 
inputs_def.IDOsol.n_y0=0;




inputs_def.model.reg_u=1;   % This is to modify the model to include regularization in the control for IDO
inputs_def.model.rep_par=1; % This it to modify the cost function to include regularization term (Tikhonov)
inputs_def.model.beta=0;    % Regularization for parameters --- by default there is no regularisation; beta can take any real value
inputs_def.model.alpha=0;    % Regularization for parameters --- by default there is no regularisation; beta can take any real value

inputs_def.IDOsol.u_ref=[];                   % References for regularization
inputs_def.IDOsol.par_ref=[];
