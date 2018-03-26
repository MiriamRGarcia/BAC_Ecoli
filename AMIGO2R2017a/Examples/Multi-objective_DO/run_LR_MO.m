
% RUN Lee-Ramirez bioreactor optimal control - Two objectives production
% and inducer cost


clear all;

% Case 1: Step-wise control interpolation - NSGA2

cprintf('*[1,0.5,0]','\n\n ---> Solving Multi-objective Lee-Ramirez bioreactor optimal control problem with NSGA2');
LRbioreactor_multiobj      % Calls the script with the inputs: 
                           % Model, objective and constraints
                           % CPV implementation
                           % Numerical approaches for simulation & optimization 

AMIGO_Prep(inputs)         % Calls the task for pre-processing

AMIGO_DO(inputs)           % Calls the task for dynamic optimization



% Case 2: Step-wise control interpolation - Weighted sum method

cprintf('*[1,0.5,0]','\n\n ---> Solving Multi-objective Lee-Ramirez bioreactor optimal control problem with the WSM');
pause(2)
clear all;


LRbioreactor_multiobj_wsm

[results]=AMIGO_DO(inputs)             % Calls the task for dynamic optimization



% Case 3: Step-wise control interpolation - Epsilon-constrained approach

cprintf('*[1,0.5,0]','\n\n ---> Solving Multi-objective Lee-Ramirez bioreactor optimal control problem with the EPSILON_CONSTRAINED APPROACH');
pause(2)
clear all;
% Maximizing product for a given inducer cost

counter=1;              
inducer_costs=[0:0.05:0.5];               % Values of inducer cost to be used for epsilon-constraint
for i=1:length(inducer_costs)
    LRbioreactor                          % Read single objective input file
    inputs.pathd.results_folder='LRbioreactor_multiobj';
    inputs.DOsol.n_const_ineq_tf=1;       % Add the constraint for the inducer cost value
    inputs.DOsol.const_ineq_tf=['y8-' num2str(inducer_costs(i))]; % c(y,u,tf)<=0
    inputs.DOsol.ineq_const_max_viol=1.0e-5;
    
    inputs.pathd.runident=['20step_eps_' num2str(i)];  % update ident to keep all intermedaiate results
    inputs.nlpsol.reopt='on';             % Reoptimization after convergence to refine solutions
    inputs.nlpsol.n_reOpts=1;             % Number of reoptimizations
 
    [results]=AMIGO_DO(inputs);           % call AMIGO_DO and save results
    if results.do.constraints_viol<inputs.DOsol.ineq_const_max_viol % Checks for feasibility
    pareto_fbest(counter,:)=[inducer_costs(i) results.nlpsol.fbest]  % Keeps pareto funtions
    pareto_u{counter}=results.do.u;                               % Keeps pareto controls
    counter=counter+1;
    end

end

figure
plot(pareto_fbest(:,1), pareto_fbest(:,2),'o')          % Plots pareto front
title('Pareto front obtained with epsilon-constrained approach')
xlabel('Inducer cost')
ylabel('Production')
