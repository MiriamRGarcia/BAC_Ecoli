%% Pseudo-data generation with AMIGO_SData

%% AMIGO_SData with pseudo-data options
% * Simulates observables under a given experimental scheme
% * Generates pseudo-experimental data using a noise model
% * Plots states evolution and experimental data vs time
%
% Note that the pseudo-data generation option is also available directly in
% AMIGO_PE, in this case AMIGO_PE
%
% * Simulates observables under a given experimental scheme using the nominal parameters
% * Generates pseudo-experimental data using a noise model
% * Estimates the unknown parameters of the model: the parameter guess
% values are used instead of the nominal parameters for the initial
% step of the estimation.
% * Reports the results of the estimation by tables and plots.
%

%% See also

    %%
    % * <doc_AMIGO_ivpsol.html IVP solvers>
    % * <doc_AMIGO_Input.html how to input a problem in AMIGO>

%% Example
%
% <html>
% <a name="example"> </a>
% </html>
% 
% Simple reaction A->B->C
%
% A is transformed into B, and B into C 
% following 1st order reactions. 

clear;    
%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='ABCreaction';
inputs.pathd.short_name='ABCreac';         
inputs.pathd.run_overwrite='on';

%============================
% MODEL DEFINITION
%============================           
inputs.model.input_model_type='charmodelC';                            
inputs.model.n_st=3;                                 
inputs.model.n_par=2;                                                    
inputs.model.n_stimulus=0;                          
inputs.model.names_type='custom';                                                     
inputs.model.st_names=char('cA','cB','cC');                                          
inputs.model.par_names=char('k1','k2');                      
        
inputs.model.eqns=...                                
            char('dcA = -k1*cA',...  
                 'dcB =  k1*cA - k2*cB',...
                 'dcC =  k2*cB');
k1 = 0.25;
k2 = 1.0;

% Note that SData use the inputs.model.par for simulation and to generate data. 
inputs.model.par=[k1 k2];  

%============================
% EXPERIMENTS RELATED INFO
%============================  
inputs.exps.n_exp       = 1;

inputs.exps.n_obs{1}=3;
inputs.exps.obs_names{1}= char('obsA','obsB','obsC');                  
inputs.exps.obs{1}      = char('obsA=cA','obsB=cB','obsC=cC');      
inputs.exps.exp_y0{1}   = [10 0 0];                                       
inputs.exps.t_f{1}=10;                               
inputs.exps.t_in{1} = 0;
inputs.exps.n_s{1}=11;                                
inputs.exps.t_s{1}=0:10;
 

 
inputs.ivpsol.ivpsolver='cvodes';
inputs.ivpsol.rtol=1.0D-7; 
inputs.ivpsol.atol=1.0D-7; 
    
    %%
    % More information regarding the inputs used in this example can be
    % found <sdataex2.html here>. 
    AMIGO_htmldoc_inputs(inputs,fullfile(pwd,'html','sdataex2.html'));  
%% Prepare the model    
AMIGO_Prep(inputs);    


%% Homoscedastic error for each observable
%
% <html>
% <a name="heteroscedastic"> </a>
% </html>
% 
% additive Gaussian measurement error model with constant standard deviation
% $\hat y_j(t_i) = y_j(t_i) + \epsilon_{ij}$, 
% where:
%
% * $y_j(t_i)$ is the simulated value at time $t_i$ of observable $y_j$
% * $\epsilon_{ij}$ is a random variable: $\epsilon_{:,j} \sim N(0,\sigma^{(r)}_j\max(y_j(:))I_{N_t})$
% * $\sigma^{(r)}$ is the _relative_ standard deviation given by the user through
% inputs.exps.std_dev  for each observable separately.
%
% Useful if we approximately know the relative error (in %*100) in the measurements.
% Note that  the maximum value of each observable long the time dimension is used to scale the _relative_ standard deviation.
inputs.exps.data_type = 'pseudo';
inputs.exps.noise_type = 'homo_var';
inputs.exps.std_dev{1} = [0.1 0.03 0.07];
results = AMIGO_SData(inputs);
%%
% Note that 
%
% * Large error may obtained for small signals, since the relative standard
% deviation is scaled by the maximum value of the observable,
% * To avoide negative values 'pseudo_pos' may used, which reflects the
% negative signals to the y = 0 line.
% * The error bars are uniform in each observable.
% * The error bars are different between
% the different observables, thus the effect of different measurement units
% can be handled. 
% * The error bar may not reach the simulated value, since it represents
% 1 standard deviation, which contains the true value by 0.68 probability
%

%% Heteroscedastic error for each measured point
%
% <html>
% <a name="heteroscedastic_pointwise"> </a>
% </html>
% 
% additive Gaussian measurement error model with unique standard deviation for each
% point:
% $\hat y_j(t_i) = y_j(t_i) + \epsilon_{ij}$, 
% where:
%
% * $y_j(t_i)$ is the simulated value at time $t_i$ of observable $y_j$
% * $\epsilon_{ij}$ is a random variable: $\epsilon_{ij} \sim N(0,\sigma_{ij})$
% * $\sigma_{ij}$ is the _absolut_ standard deviation given by the user through
% inputs.exps.error_data  for each measurement point.
%
% Useful if we know the measurement accuracy in each timepoint.
inputs.exps.data_type = 'pseudo';
inputs.exps.noise_type = 'hetero';
inputs.exps.error_data{1} = ...
    [1.0      0.01      0.01
    0.9000    0.0500    0.0500
    0.8056    0.2000    0.1000
    0.7111    0.3500    0.1500
    0.6167    0.5000    0.2000
    0.5222    0.5000    0.2500
    0.4278    0.5000    0.3000
    0.3333    0.3875    0.3500
    0.2389    0.2750    0.4000
    0.1444    0.1625    0.4500
    0.0500    0.0500    0.5000];
    
results = AMIGO_SData(inputs);
%%
% Note that 
% 
% * The error bars represents the user defined values.
% * Different accuracies can be defined for each timepoint in each observable 
% * The error bar may not reache the simulated value, since it represents
% 1 standard deviation, that contains the true value by 0.68 probability
%



%% Additive error scaling with the signal
%
% <html>
% <a name="additive_scaling"> </a>
% </html>
% 
% additive Gaussian measurement error model, the standard deviation of
% which scales with the signal (constant signal to noise ratio).
% $\hat y_j(t_i) = y_j(t_i) + y_j(t_i)\epsilon_{j}$, 
% where:
%
% * $y_j(t_i)$ is the simulated value at time $t_i$ of observable $y_j$
% * $\epsilon_{j}$ is a random variable: $\epsilon_{j} \sim N(0,\sigma_{j})$
% * $\sigma_{j}$ vector is  given by the user through
% inputs.exps.std_dev  for each observable.
%
% Useful if we know that (1) the measurement error is proportional to the
% signal and (2) the proportionality factor.

inputs.exps.data_type = 'pseudo';
inputs.exps.noise_type = 'hetero_proportional';
inputs.exps.std_dev{1} = [0.1 0.03 0.07];

results = AMIGO_SData(inputs);

%%
% Note that 
% 
% * The error bars scales with the signal value.
% * The error bars are different between
% the different observables, thus the effect of different measurement units
% and different accuracy for different observables can be handled. 
% * The error bar may not reache the simulated value, since it represents
% 1 standard deviation, that contains the true value by 0.68 probability
%

%% Additive error scaling with the signal with detection limit
%
% <html>
% <a name="additive_scaling_plus_const"> </a>
% </html>
% 
% additive Gaussian measurement error model, the standard deviation of
% which scales with the signal (constant signal to noise ratio). The model is extended to
% low signals, where the error levels off.
%
% $\hat y_j(t_i) = y_j(t_i) + y_j(t_i)\epsilon_{j}+ \eta_j$ , 
%
% where:
%
% * $y_j(t_i)$ is the simulated value at time $t_i$ of observable $y_j$
% * $\epsilon_{j}$ is a random variable: $\epsilon_{j} \sim N(0,\sigma^{(b)}_{j})$
% * $\eta$ is the background noise variable $\eta_{j} \sim N(0,\sigma^{(a)}_{j})$ 
% * $\sigma^{(a)}$ and $\sigma^{(b)}$ vectors are  given by the user through
% inputs.exps.stddeva and inputs.exps.stddevb  for each observable.
%
%
% The variance of the pseudo data is: $Var(\hat y_{ij}) = (y_j(t_i)\sigma_{j}^{(b)})^2 + (\sigma_j^{(a)})^2$
%
% Useful if we know that (1) the measurement error is proportional to the
% signal for large signals and constant for small signals. Equivalently,
% the signal to noise ratio is constant for large signals, but decreases as
% the signal reach a low limit. 

inputs.exps.data_type = 'pseudo';
inputs.exps.noise_type = 'hetero_lin';
inputs.exps.stddeva{1} = [0.2 0.2 0.5];
inputs.exps.stddevb{1} = [0.05 0.03 0.07];
% extend the time horizon to see small values for obsA
inputs.exps.t_f{1}=20;                               
inputs.exps.t_in{1} = 0;
inputs.exps.n_s{1}=21;                                
inputs.exps.t_s{1}=0:20;



results = AMIGO_SData(inputs);

%%
% Note that 
% 
% * The error bars scales with the signal value, but become constant for
% small signal
% * The error bars are different between
% the different observables, thus the effect of different measurement units
% and different accuracy for different observables can be handled. 
% * The error bar may not reache the simulated value, since it represents
% 1 standard deviation, that contains the true value by 0.68 probability
%


%% Multiplicative error 
%
% <html>
% <a name="multiplicative"> </a>
% </html>
% 
% multiplicative log-normal measurement error model, the standard deviation of
% which scales with the signal (constant signal to noise ratio). 
%
% $\hat y_j(t_i) =  y_j(t_i)e^{\epsilon_{j}}$ , 
%
% where:
%
% * $y_j(t_i)$ is the simulated value at time $t_i$ of observable $y_j$
% * $\epsilon_{j}$ is a random variable: $\epsilon_{j} \sim N(0,\sigma^{(b)}_{j})$
% * $\sigma^{(b)}$ vectors are  given by the user through
% inputs.exps.stddeva and inputs.exps.stddevb  for each observable.
%
% The variance of the pseudo data is: 
% $Var(\hat y_{ij}) = y_j^2(t_i)e^{(\sigma_{j}^{(b)})^2}(e^{(\sigma_{j}^{(b)})^2}-1)$
%
% Useful if we know that (1) the multiplicative measurement error is dominated in the measurement, which is proportional to the
% signal for large signals.

inputs.exps.data_type = 'pseudo';
inputs.exps.noise_type = 'log_normal';
inputs.exps.stddevb{1} = [0.05 0.03 0.07];
% extend the time horizon to see small values for obsA
inputs.exps.t_f{1}=20;                               
inputs.exps.t_in{1} = 0;
inputs.exps.n_s{1}=21;                                
inputs.exps.t_s{1}=0:20;
% change the initial condition to see large changes
inputs.exps.exp_y0{1}   = [1e3 0 0];
inputs.model.par=[k1*0.8 k2]; 

results = AMIGO_SData(inputs);


%%
% Note that 
% 
% * The results are similar to that of the results of hetero_lin option
% * The error bars scales with the signal value
% * The error bars are different between
% the different observables, thus the effect of different measurement units
% and different accuracy for different observables can be handled. 
% * The error bar may not reache the simulated value, since it represents
% 1 standard deviation, that contains the true value by 0.68 probability
%

%% Multiplicative error with detection limit
%
% <html>
% <a name="multiplicative_plus_constant"> </a>
% </html>
% 
% multiplicative log-normal measurement error model, the standard deviation of
% which scales with the signal (constant signal to noise ratio). The model is extended to
% low signals, where the error levels off.
%
% $\hat y_j(t_i) =  y_j(t_i)e^{\epsilon_{j}}+ \eta_j$ , 
%
% where:
%
% * $y_j(t_i)$ is the simulated value at time $t_i$ of observable $y_j$
% * $\epsilon_{j}$ is a random variable: $\epsilon_{j} \sim N(0,\sigma^{(b)}_{j})$
% * $\eta$ is the background noise variable $\eta_{j} \sim N(0,\sigma^{(a)}_{j})$ 
% * $\sigma^{(a)}$ and $\sigma^{(b)}$ vectors are  given by the user through
% inputs.exps.stddeva and inputs.exps.stddevb  for each observable.
%
% The variance of the pseudo data is: $Var(\hat y_{ij}) = {y_j^2(t_i)e^{(\sigma_{j}^{(b)})^2}(e^{(\sigma_{j}^{(b)})^2}-1) + (\sigma_j^{(a)})^2}$
%
% Useful if we know that (1) the multiplicative measurement error is dominated in the measurement, which is proportional to the
% signal for large signals and constant for small signals. Equivalently,
% the signal to noise ratio is constant for large signals, but decreases as
% the signal reach a low limit. 

inputs.exps.data_type = 'pseudo';
inputs.exps.noise_type = 'log_normal_background';
inputs.exps.stddeva{1} = [10 5 5];
inputs.exps.stddevb{1} = [0.05 0.03 0.07];
% extend the time horizon to see small values for obsA
inputs.exps.t_f{1}=20;                               
inputs.exps.t_in{1} = 0;
inputs.exps.n_s{1}=21;                                
inputs.exps.t_s{1}=0:20;
% change the initial condition to see large changes
inputs.exps.exp_y0{1}   = [1e3 0 0];
inputs.model.par=[k1*0.8 k2]; 

results = AMIGO_SData(inputs);


%%
% Note that 
% 
% * The results are similar to that of the results of hetero_lin option
% * The error bars scales with the signal value, but become constant for
% small signal
% * The error bars are different between
% the different observables, thus the effect of different measurement units
% and different accuracy for different observables can be handled. 
% * The error bar may not reache the simulated value, since it represents
% 1 standard deviation, that contains the true value by 0.68 probability
%


