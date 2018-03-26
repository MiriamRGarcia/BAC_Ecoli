
% RUN Park-Ramirez bioreactor optimal control - Two objectives production
% and process duration


clear all;

% Case 1: Linearf-wise control interpolation - NSGA2

cprintf('*[1,0.5,0]','\n\n ---> Solving Multi-objective Park-Ramirez bioreactor optimal control problem with NSGA2');
PRbioreactor_multiobj      % Calls the script with the inputs: 
                           % Model, objective and constraints
                           % CPV implementation
                           % Numerical approaches for simulation & optimization 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_DO(inputs)           % Calls the task for dynamic optimization



% Case 2: Step-wise control interpolation - Weighted sum method

cprintf('*[1,0.5,0]','\n\n ---> Solving Multi-objective Park-Ramirez bioreactor optimal control problem with the WSM');
pause(2)
clear all;


PRbioreactor_multiobj
inputs.nlpsol.nlpsolver='wsm_fmincon';                  % WSM with a local solver fmincon
inputs.DOsol.n_wsm=51;                                  % Number of weights combinations in the wsm method 
w1=sort(rand(inputs.DOsol.n_wsm,1));                    % Random wsm_mat
inputs.DOsol.wsm_mat=[w1 ones(inputs.DOsol.n_wsm,1)-w1];

AMIGO_DO(inputs)             % Calls the task for dynamic optimization


% Case 3: Step-wise control interpolation - Epsilon-constrained approach

cprintf('*[1,0.5,0]','\n\n ---> Solving Multi-objective Park-Ramirez bioreactor optimal control problem with the EPSILON_CONSTRAINED APPROACH');
pause(2)
clear all;

% Maximizing product for a given process duration
durations=[10:2:32];                      % Values of final time to be considered
counter=1;              
for i=1:length(durations)
    PRbioreactor                          % Read single objective input file
    inputs.pathd.results_folder='PRbioreactor_multiobj';
    inputs.DOsol.tf_guess=durations(i);   % update process duration
    inputs.pathd.runident=['20step_eps_' num2str(i)];  % update ident to keep all intermedaiate results
    inputs.nlpsol.reopt='on';             % Reoptimization after convergence to refine solutions
    inputs.nlpsol.n_reOpts=1;             % Number of reoptimizations
 
    [results]=AMIGO_DO(inputs);           % call AMIGO_DO and save results

    if results.do.constraints_viol<inputs.DOsol.ineq_const_max_viol % Checks for feasibility
    pareto_fbest(counter,:)=[durations(i) results.nlpsol.fbest];  % Keeps pareto funtions
    pareto_u{counter}=results.do.u;                               % Keeps pareto controls
    counter=counter+1;
    end

end

figure
plot(pareto_fbest(:,1), pareto_fbest(:,2),'o')          % Plots pareto front
title('Pareto front obtained with epsilon-constrained approach')
xlabel('Process duration')
ylabel('Production')


   
