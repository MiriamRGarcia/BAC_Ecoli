% $Header: svn://.../trunk/AMIGO2R2016/Examples/Hodgkin-Huxley_model/HH.m 2410 2015-12-07 13:58:57Z evabalsa $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: The Hodgkin–Huxley model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%====================
% Brief description:
%====================

% The Hodgkin–Huxley model describes how action potentials in neurons are 
% initiated and propagated. 
% It consist of a set of nonlinear ordinary differential equations that 
% approximate the electrical characteristics of excitable cells such as 
% neurons and cardiac myocytes.

% Initially proposed to explain the ionic mechanisms underlying the 
% initiation and propagation of action potentials in the squid giant axon.

% Model:

% dyv/dt=-(gNa*ym^3*yh*(yv-VNa)+ gK*yn^4*(yv-VK)+gL*(yv-VL)- TotalI ) / Cm;  
% dyn/dt= An*(1-yn)-Bn*yn;  
% dym/dt= Am*(1-ym)-Bm*ym;  
% dyh/dt= Ah*(1-yh)-Bh*yh;  

% with: An=0.01*((10-yv)/(exp((10-yv)*0.1)-1));
%       Bn=0.125*exp(-yv/80);
%       Am=0.1*((25-yv)/(exp((25-yv)*0.1)-1));
%       Bm=4*exp(-yv/18);
%       Ah=0.07*exp(-yv/20);
%       Bh=1/(1+exp((30-yv)*0.1));
  
% Nominal value for the parameters:
%       gNa=120; gK=36; gL=0.3; VNa=115; VK=-12; VL=10.6; Cm=1;

%=============
% References:
%=============

% Hodgkin, A., and Huxley, A. (1952): A quantitative description of membrane 
% current and its application to conduction and excitation in nerve. 
% J. Physiol. 117:500–544.


%====================
% AMIGO TESTS   :
%====================

% This example will be used to show the different possibilities available 
% in AMIGO toolbox. 


%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='Hodgkin-Huxley_model'; % Folder to keep results (in Results) for a given problem                       
inputs.pathd.short_name='HH';                       % To identify figures and reports for a given problem 
                                                     % ADVISE: the user may introduce any names related to the problem at hand 
inputs.pathd.runident='pp';                         % [] Identifier required in order not to overwrite previous results
                                                     %    This may be modified from command line. 'run1'(default)
                                                     

%============================
% MODEL RELATED DATA
%============================
inputs.model.input_model_type='charmodelC';          % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|                        
                                                     %                     'blackboxmodel'|'blackboxcost                   
inputs.model.n_st=4;                                 % Number of states                                  
inputs.model.n_par=7;                                % Number of model parameters                                  
inputs.model.n_stimulus=1;                           % Number of inputs, stimuli or control variables   
inputs.model.names_type='custom';                    % [] Names given to states/pars/inputs: 
                                                     %                'standard' (x1,x2,...p1,p2...,u1, u2,...) 
                                                     %                'custom'(default)
inputs.model.st_names=char('yv','yn','ym','yh');     % Names of the states                                         
inputs.model.par_names=char('gNa','gK','gL','VNa',...
                        'VK','VL','Cm');             % Names of the parameters                   
inputs.model.stimulus_names=char('TotalI');          % Names of the stimuli, inputs or controls                                  
inputs.model.eqns=...                                % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
            char('An=0.01*((10-yv)/(exp((10-yv)*0.1)-1))',...
                 'Bn=0.125*exp(-yv/80)',...
                 'Am=0.1*((25-yv)/(exp((25-yv)*0.1)-1))',...
                 'Bm=4*exp(-yv/18)',...
                 'Ah=0.07*exp(-yv/20)',...
                 'Bh=1/(1+exp((30-yv)*0.1))',...
                 'dyv=-(gNa*ym^3*yh*(yv-VNa)+ gK*yn^4*(yv-VK)+gL*(yv-VL)- TotalI ) / Cm',...  
                 'dyn= An*(1-yn)-Bn*yn',...  
                 'dym= Am*(1-ym)-Bm*ym',...      
                 'dyh= Ah*(1-yh)-Bh*yh');
             
inputs.model.par=[120 36 0.3 -115 12 -10.613 1];      % Nominal value for the parameters, this allows to fix known parameters
                                                      % These values may be updated during optimization  

%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================

 inputs.exps.n_exp=2;                                 % Number of experiments                                                                  
 inputs.exps.exp_y0{1}=[0 0.3177 0.053 0.5959];       % Initial conditions for each experiment       
 inputs.exps.t_f{1}=40;                               % Experiments duration

 inputs.exps.u_interp{1}='pulse-down';                % [] Stimuli definition: u_interp: 'sustained' |'step'|'linear'(default)|
                                                      %                               'pulse-up'|'pulse-down'
 inputs.exps.n_pulses{1}=1;                           % Number of pulses
 inputs.exps.u_min{1}=0;inputs.exps.u_max{1}=5;       % Bounds for the stimuli
 inputs.exps.t_con{1}=[0 20 40];                      % Initial time-Times of changes for the stimuli- Final stimulation time
                                                              


 inputs.exps.exp_y0{2}=[0 0.3177 0.053 0.5959];       % Initial conditions for each experiment       
 inputs.exps.t_f{2}=36;                               % Experiments duration
 
 inputs.exps.u_interp{2}='pulse-down';                % [] Stimuli definition: u_interp: 'sustained' |'step'|'linear'(default)|
                                                      %                               'pulse-up'|'pulse-down'
 inputs.exps.n_pulses{2}=1;                           % Number of pulses
 inputs.exps.u_min{2}=0;inputs.exps.u_max{2}=5;       % Bounds for the stimuli
 inputs.exps.t_con{2}=[0 20 36];                      % Initial time-Times of changes for the stimuli- Final stimulation time
                                                              
%==================================
% NUMERICAL METHODS RELATED DATA
%==================================
%
% SIMULATION
inputs.ivpsol.ivpsolver='cvodes';                     % [] IVP solver: C:'cvodes'; MATLAB:'ode15s'(default)|'ode45'|'ode113'            
                                                      
                                                      
inputs.ivpsol.senssolver='cvodes';                    % [] Sensitivities solver: 'cvodes' (C)
                                                      %                          'sensmat' (matlab) |
                                                      %                          'fdsens2','fdsens5' (finite differences)
                                                      
inputs.ivpsol.rtol=1.0D-7;                            % [] IVP solver integration tolerances
inputs.ivpsol.atol=1.0D-7; 


%==================================
% DISPLAY OF RESULTS
%==================================

inputs.plotd.plotlevel='full';                       % [] Display of figures: 'full'|'medium'(default)|'min' |'noplot' 
inputs.plotd.epssave=0;                              % [] Figures may be saved in .eps (1) or only in .fig format (0) (default)
inputs.plotd.number_max_states=8;                    % [] Maximum number of states per figure
inputs.plotd.number_max_obs=8;                       % [] Maximum number of observables per figure
inputs.plotd.n_t_plot=100;                           % [] Number of times to be used for observables and states plots
inputs.plotd.contour_rtol=1e-7;                      % [] Integration tolerances for the contour plots. 
inputs.plotd.contour_atol=1e-7;                      %    ADVISE: These tolerances should be a little bit strict
inputs.plotd.nx_contour=60;                          % [] Number of points for plotting the contours x and y direction
inputs.plotd.ny_contour=60;                          %    ADVISE: >=50
inputs.plotd.number_max_hist=8;                      % [] Maximum number of unknowns histograms per figure (multistart)
