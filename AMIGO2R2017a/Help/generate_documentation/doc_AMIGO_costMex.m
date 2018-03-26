%% costMex

%% See also
    
    %%
    % * <doc_AMIGO_Input.html how to input a problem in AMIGO>

%% Example

clear;
%======================
% MODEL RELATED DATA
%======================
inputs.model.input_model_type='charmodelC';
inputs.model.exe_type='costMex';

inputs.model.n_st=7;
inputs.model.n_par=27;
inputs.model.st_names=char('CL_m','CL_c','CL_n','CT_m','CT_c','CT_n','CP_n');

inputs.model.par_names=char('n1','n2','g1','g2','m1','m2','m3','m4','m5','m6',...
    'm7','k1','k2','k3','k4','k5','k6','k7','p1','p2',...
    'p3','r1','r2','r3','r4','q1','q2');

inputs.model.eqns=...
    char(...
    'light=1',...
    'dCL_m=q1*CP_n*light+n1*CT_n/(g1+CT_n)-m1*CL_m/(k1+CL_m)',...
    'dCL_c=p1*CL_m-r1*CL_c+r2*CL_n-m2*CL_c/(k2+CL_c)',...
    'dCL_n=r1*CL_c-r2*CL_n-m3*CL_n/(k3+CL_n)',...
    'dCT_m=n2*g2^2/(g2^2+CL_n^2)-m4*CT_m/(k4+CT_m)',...
    'dCT_c=p2*CT_m-r3*CT_c+r4*CT_n-m5*CT_c/(k5+CT_c)',...
    'dCT_n=r3*CT_c-r4*CT_n-m6*CT_n/(k6+CT_n)',...
    'dCP_n=(1-light)*p3-m7*CP_n/(k7+CP_n)-q2*light*CP_n');

inputs.model.par=[7.5038 0.6801 1.4992 3.0412 10.0982...
    1.9685 3.7511 2.3422 7.2482 1.8981 1.2 3.8045...
    5.3087 4.1946 2.5356 1.4420 4.8600 1.2 2.1994...
    9.4440 0.5 0.2817 0.7676 0.4364 7.3021 4.5703 1.0];


%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================
inputs.exps.n_exp=1;
inputs.exps.n_s{1}=1000;
inputs.exps.exp_y0{1}=zeros(1,inputs.model.n_st);
inputs.exps.t_f{1}=120;
inputs.exps.obs{1}='none';

inputs.pathd.run_overwrite='on';

    %%
    % More information regarding the inputs used in this example can be
    % found <costmexex1.html here>. 

[inputs privstruct]=AMIGO_Prep(inputs);


    %%
    % Save inputs and privstruct in a file and you can export the cost
    % functions and simulation. The MEX function in located in:
   
    
disp(inputs.model.mexfile);    
    
    %%
    % Simulate the model several time.

tic 
for i=1:10
feval(inputs.model.mexfunction,'sim_CVODES');
end
toc

figure;
plot(inputs.exps.t_s{1},outputs.simulation{1});

    %%
    % See the Equivalent m-file <model_4_ode15s.html model>

options = odeset('RelTol',1e-7,'AbsTol',1e-7);
handle_ode=@(t,y)model_4_ode15s(t,y,inputs.model.par);

    %%
    % Simulate the model several time.

tic
for i=1:10
[T,Y] = ode15s(handle_ode,inputs.exps.t_s{1},inputs.exps.exp_y0{1},options);
end
toc

figure;
plot(inputs.exps.t_s{1},Y);

    %%
    %

AMIGO_htmldoc_inputs(inputs,fullfile(pwd,'html','costmexex1.html'));




