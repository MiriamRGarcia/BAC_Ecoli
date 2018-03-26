% $Header: svn://.../trunk/AMIGO2R2016/Examples/Arabidopsis_circadian/circadian_smodel.m 2122 2015-09-21 07:15:32Z attila $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: The circadian clock in Arabidopsis thaliana
%
%        Type :
%                > help circadian_tutorial
%        for a more detailed description of the model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%        INPUT FILE TO SIMULATE MODEL
%
%        This is the minimum input file for model simulation. 
%        Default values are assigned to non defined inputs.
%
%        Minimum required inputs:
%           > Paths related data
%           > Model:               model_type; n_st; n_par; n_stimulus; 
%                                  st_names; par_names; stimulus_names;  
%                                  eqns; par
%           > Experimental scheme: n_exp; exp_y0{iexp}; t_f{iexp}; 
%                                  u_interp{iexp}; t_con{iexp}; u{iexp}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%=======================
% PATHS RELATED DATA
%=======================

inputs.pathd.results_folder='circadian-tutorial';         % Folder to keep results (in Results) for a given problem          
inputs.pathd.short_name='circadian';                      % To identify figures and reports for a given problem   

%========================
% MODEL RELATED DATA
%========================

inputs.model.input_model_type='charmodelC';                % Model introduction: 'charmodel'|'matlabmodel'|'sbmlmodel'|'fortranmodel'|                        
                                                           %                     'blackboxmodel'|'blackboxcost                             
inputs.model.n_st=7;                                       % Number of states      
inputs.model.n_par=27;                                     % Number of model parameters 
inputs.model.n_stimulus=1;                                 % Number of inputs, stimuli or control variables   
inputs.model.st_names=char('CL_m','CL_c','CL_n','CT_m','CT_c','CT_n','CP_n');     % Names of the states                                              
inputs.model.par_names=char('n1','n2','g1','g2','m1','m2','m3','m4','m5','m6',...
                            'm7','k1','k2','k3','k4','k5','k6','k7','p1','p2',...
                            'p3','r1','r2','r3','r4','q1','q2');                  % Names of the parameters                     
inputs.model.stimulus_names=char('light');                                        % Names of the stimuli, inputs or controls                      
inputs.model.eqns=...                                      % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dCL_m=q1*CP_n*light+n1*CT_n/(g1+CT_n)-m1*CL_m/(k1+CL_m)',...
                    'dCL_c=p1*CL_m-r1*CL_c+r2*CL_n-m2*CL_c/(k2+CL_c)',...
                    'dCL_n=r1*CL_c-r2*CL_n-m3*CL_n/(k3+CL_n)',...
                    'dCT_m=n2*g2^2/(g2^2+CL_n^2)-m4*CT_m/(k4+CT_m)',...
                    'dCT_c=p2*CT_m-r3*CT_c+r4*CT_n-m5*CT_c/(k5+CT_c)',...
                    'dCT_n=r3*CT_c-r4*CT_n-m6*CT_n/(k6+CT_n)',...
                    'dCP_n=(1-light)*p3-m7*CP_n/(k7+CP_n)-q2*light*CP_n');              
                
                
n1=7.5038;  n2=0.6801 ;
g1=1.4992;  g2=3.0412; 
m1=10.0982; m2=1.9685; m3=3.7511; m4= 2.3422; m5=7.2482; m6=1.8981; m7=1.2;
k1=3.8045;  k2=5.3087; k3=4.1946; k4=2.5356; k5=1.4420; k6=4.8600; k7=1.2;
p1=2.1994;  p2=9.4440; p3=0.5; 
r1=0.2817;  r2=0.7676; r3=0.4364; r4=7.3021;
q1=4.5703;  q2=1.0;
                
                
inputs.model.par=[ n1 n2 g1 g2 m1 m2 m3 m4 m5 m6 m7 k1 k2 k3...
                   k4 k5 k6 k7 p1 p2 p3 r1 r2 r3 r4 q1 q2]; % Nominal value for the parameters, this allows to fix known parameters
                                                            % These values may be updated during optimization  


%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================

 inputs.exps.n_exp=2;                                  %Number of experiments                                                                            
 for iexp=1:inputs.exps.n_exp   
 inputs.exps.exp_y0{iexp}=zeros(1,inputs.model.n_st);  %Initial conditions for each experiment          
 inputs.exps.t_f{iexp}=120;                            %Experiments duration
 end           
 
 inputs.exps.u_interp{1}='sustained';                  %Stimuli definition for experiment 1:
                                                       %OPTIONS:u_interp: 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.exps.t_con{1}=[0 120];                         % Input swithching times: Initial and final time    
 inputs.exps.u{1}=[1];                                 % Values of the inputs 
 
 inputs.exps.u_interp{2}='pulse-down';                 %Stimuli definition for experiment 2
 inputs.exps.n_pulses{2}=5;                            %Number of pulses |-|_|-|_|-|_|-|_|-|_    
 inputs.exps.u_min{2}=0;inputs.exps.u_max{2}=1;        %Minimum and maximum value for the input
 inputs.exps.t_con{2}=[0 :12: 120];                    %Times of switching: Initial time, Intermediate times, Final time
                        