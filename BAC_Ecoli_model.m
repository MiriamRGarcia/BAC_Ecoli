%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: Inactivation of Ecoli with BAC
% Author: Míriam R. García
% This model is called with file BAC_Ecoli_main.m 
% Read BAC_Ecoli_main.m for details 
% Please contact me for questions miriamr@iim.csic.es
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='BAC_Ecoli';
inputs.pathd.short_name='test';
inputs.pathd.runident='r1';

%============================
% MODEL RELATED DATA
%============================
%%% For no c++ compilators changed to charmodelM, but time for the
%%% optimizations should de increased substantially.
inputs.model.input_model_type='charmodelC';          % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'blackboxmodel'|'blackboxcost
inputs.model.n_st=4;                                 % Number of states
inputs.model.n_par=5;                                % Number of model parameters
inputs.model.n_stimulus=0;                           % Number of inputs, stimuli or control variables
inputs.model.names_type='custom';                    % [] Names given to states/pars/inputs: 'standard' (x1,x2,...p1,p2...,u1, u2,...)
%                                       'custom'(default)
inputs.model.st_names=char('N0','B0','NN','BB');                    % Names of the states
inputs.model.par_names=char('k','x','n','a','b');             % Names of the parameters

inputs.model.stimulus_names=char('');               % Names of the stimuli, inputs or controls
inputs.model.eqns=...                                % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
    char('dN0=0',...
    'dB0=0',...
    'alpha=(B0/N0)^b/10^a',...
    'dNN=-10^(-k)*NN^x*BB^n',...
    'dBB=+alpha*dNN');


inputs.model.par=[	3.75787 	1.25036 	1.69638 	1.17631	0.833426];



%==================================
% DATA
%==================================
inputs.exps.data_type='real';
inputs.model.exe_type='standard';
cont=0;


inputs.exps.n_exp=length(pick_experiments);
[t,Nlog_mean,Nlog_std,C,stdC,stdN,Nlog]=experimental_data(pick_experiments);

for ii=1:inputs.exps.n_exp;
    cont=cont+1;
    
    inputs.exps.t_s{cont}=t{cont};
    inputs.exps.exp_y0{cont}=[10.^Nlog_mean{cont}(1) C{cont}(1) 10.^Nlog_mean{cont}(1) C{cont}(1)];
    inputs.exps.t_f{cont}=inputs.exps.t_s{cont}(end);
    inputs.exps.n_s{cont}=size(t{cont},2);
    
    inputs.exps.n_obs{cont}=2;
    inputs.exps.obs_names{cont}=char('logN','BAC');
    inputs.exps.obs{cont}=char('logN=(log10(NN));ind=find(log10(NN)<2);logN(ind)=2*ones(size(ind));','BAC=BB');
    inputs.exps.exp_data{cont}= [Nlog_mean{cont}' C{cont}];
    inputs.exps.error_data{cont} = [stdN*ones(size(C{cont})) stdC*ones(size(C{cont}))];
    
    
end



%==================================
% PE
%==================================

% only parameters estimated in Telen et al
inputs.PEsol.id_global_theta=char('k','x','n','a','b');                         % 'all'|User selected

inputs.PEsol.global_theta_max=   [ 5  3 3 3 2 ];    % Maximum allowed values for the paramtersv
inputs.PEsol.global_theta_min=  [ 1 1 1 0 0 ];       % Minimum allowed values for the parameters
inputs.PEsol.global_theta_guess=inputs.model.par;

inputs.nlpsol.eSS.maxeval = 1e10;
inputs.nlpsol.eSS.maxtime = 10;
inputs.nlpsol.nlpsolver = 'ess';
inputs.nlpsol.eSS.local.solver='fminsearch';
inputs.PEsol.PEcost_type='llk';
inputs.PEsol.llk_type = 'hetero';




%==================================
% DISPLAY OF RESULTS
%==================================
%
inputs.plotd.plotlevel='min';                        % [] Display of figures: 'full'|'medium'(default)|'min' |'noplot'
inputs.plotd.figsave=1;                               % Save plots in .fig format 1 (yes), 0(no)



% ========================================================================================================================================================================
% function loading data from the selected experiments
% ========================================================================================================================================================================



function [t,Nlog_mean,Nlog_std,C,stdC,stdN,Nlog]=experimental_data(pick_experiments);


%==========================================================================
% Experiments for fit and cross-validation
%==========================================================================
%----------------------------------
% Exp 1: ~9logs, ~100ppm
%----------------------------------

data{1}=(10*[   58*1e6      62*1e6      3*1e7       6*1e7       NaN     NaN;
    695*1e4     537*1e4     125*1e5     137*1e5     NaN     NaN;
    58*1e3      37*1e4      36*1e4      1*1e5       1e5     NaN;
    124*1e2     126*1e2     18*1e3      19*1e3      2*1e4   0*1e4;
    11*1e2      9*1e2       1*1e3       0*1e3       NaN     NaN;
    17*1e2      20*1e2      5*1e3       1*1e3       NaN     NaN]);

data{1}=(10*[   58*1e6      62*1e6      3*1e7       6*1e7       NaN     NaN;
    695*1e4     537*1e4     125*1e5     137*1e5     NaN     NaN;
    58*1e3      37*1e4      36*1e4      1*1e5       1e5     NaN;
    124*1e2     126*1e2     18*1e3      19*1e3      2*1e4   NaN;
    11*1e2      9*1e2       1*1e3       NaN         NaN     NaN;
    17*1e2      20*1e2      5*1e3       1*1e3       NaN     NaN]);

data_BAC{1} =([ 94.38
    9.05
    12.32
    11.73
    10.54
    11.43]);

t_s{1}      =[  0
    1
    5
    10
    15
    20]';

%----------------------------------
% Exp 2: ~7logs, ~100ppm
%----------------------------------

data{2}=(10*[  44*1e4  	48*1e4      12*1e5      5*1e5       NaN     NaN;
    339*1e1     1200*1e1    26*1e2      110*1e2     NaN     NaN;
    677*1e0     769*1e0     38*1e1      42*1e1      4*1e2   2*1e2;
    88*1e0      103*1e0     14*1e1      11*1e1      0*1e2   0*1e2;
    16*1e0      9*1e0       0*1e1       1*1e1       0*1e2   1*1e2;
    1*1e0       1*1e0       NaN         NaN         NaN     NaN]);



data_BAC{2}=([ 97.41
    41.29
    43.98
    46.40
    49.25
    48.03]);

t_s{2}     =[  0
    1
    5
    10
    15
    20]';


%----------------------------------
% Exp 3: ~9logs, ~200ppm
%----------------------------------



% serie AI
data{3}=([     25*1e6*10   81*1e6*10   11*1e7*10   2*1e7*10;
    358*1e3*10  470*1e3*10  43*1e4*10   28*1e4*10;
    1*1e2*10    0           0           0;
    3*1e1*10    0*1e1*10    0    0]);

data_BAC{3}=([  208.39
    41.63
    34.34
    41.25]);

t_s{3}=[0 1 5 10];

%----------------------------------
% Exp 4: ~7logs, ~200ppm
%----------------------------------
data{4}=([559*1e3*10  339*1e3*10  54*1e4*10   80*1e4*1    NaN         NaN         NaN         NaN;
    5*330*1e0   5*302*1e0   5*30*1e1    5*53*1e1    5*173*1e0	10*156*1e0	10*16*1e1	10*18*1e1;
    5*50*1e0    5*38*1e0    5*7*1e1     5*8*1e1     10*20*1e0   10*24*1e0   10*5*1e1    10*1*1e1;
    0           0           NaN         NaN         NaN         NaN         NaN         NaN;
    5*6*1e0  	5*1*1e0     NaN         NaN         NaN         NaN         NaN         NaN ;
    0           0           NaN         NaN         NaN         NaN         NaN         NaN  ]);

data_BAC{4}=([ 203.635
    137.69
    133.32
    128.43
    129.26
    128.315]);

t_s{4}     =[  0
    30/60
    1
    2
    5
    10]';


%----------------------------------
% Exp 5: ~9logs, ~300ppm
%----------------------------------
data{5}=([96*1e6*10   98*1e6*10   21*1e7*10  22*1e7*10    NaN         NaN;
    10*710*1e1	10*616*1e1	10*128*1e2	NaN         NaN         NaN;
    10*1466*1e1 10*1473*1e1 10*418*1e2	10*462*1e2  NaN         NaN;
    10*1742*1e0 10*1521*1e0 10*305*1e1  10*333*1e1  10*40*1e2   10*46*1e2;
    0           0           0        	0           NaN         NaN ]);

data_BAC{5}=([ 321.99
    69.49
    58.96
    49.61
    26.21]);

t_s{5}     =[  0
    1
    2
    5
    10]';

%----------------------------------
% Exp 6: ~7logs, ~300ppm
%----------------------------------
data{6}=([795*1e3*10  782*1e3*10  162*1e4*10  167*1e4*10  NaN         NaN ;
    0           0           NaN         NaN     	NaN         NaN ;
    0           0           NaN         NaN         NaN         NaN ;
    0           0           NaN         NaN         NaN         NaN ;
    0           0           NaN         NaN         NaN         NaN ;
    0           0           NaN         NaN         NaN         NaN ]);

data_BAC{6}=([ 304.8
    206.82
    204.31
    192.28
    185.76
    195.29]);


t_s{6}     =[  0
    30/60
    1
    2
    5
    10]';
%==========================================================================
% Experiments for validation
%==========================================================================

%----------------------------------
% Exp 6: ~8logs, ~250ppm
%----------------------------------
data{7} = [10*131*1e5  10*185*1e5   NaN         NaN; 
    10*30*1e0   10*37*1e0   NaN         NaN;
    2.5*2*1e1   2.5*2*1e1   2.5*0       2.5*0;
    0           0           0           0;
    0           0           0           0;]; %%% still to copy.

data_BAC{7}     =[  238.54
    87.83
    95.91
    85.73
    89.91];

t_s{7}     =[      0
    1
    2
    5
    10]';



%----------------------------------
% Exp 6: ~8logs, ~75ppm
%----------------------------------

data{8} = [10*274*1e5   10*242*1e5  10*26*1e6   10*27*1e6;
    10*134*1e4   10*135*1e4  10*24*1e5   10*28*1e5; 
    10*67*1e3    10*5*1e4    10*17*1e4   NaN      ;
    10*8*1e3     10*7*1e3    NaN         NaN      ;
    10*29*1e2    10*30*1e2   10*4*1e3    10*2*1e3];

data_BAC{8}    =[  72.32
    23.27
    26.22
    26.81
    24.93];

t_s{8}         =[  0
    1
    2
    5
    10]';


%==========================================================================
% Select experiments and data postprocess
%==========================================================================
cont=0;
for ii=pick_experiments
    cont=cont+1;
    t{cont}     =[t_s{ii}];
    N_mean{cont} = nanmean(data{ii}(:,:)'+1);
    Nlog{cont} = log10(data{ii}(:,:)'); 
    Nlog{cont}(Nlog{cont}<2)=2;
    Nlog_mean{cont}  = nanmean(Nlog{cont});
    Nlog_std{cont} = nanstd(Nlog{cont});
    C{cont}     =data_BAC{ii};
end
%

%----------------------------------
% Assuming cte Standard deviations 
% (homocedastic noise)
%----------------------------------
% Standard deviations calculated from available BAC replicates
C_stds=[0.1 1.82 2.08 3.60 6.1 2.93 4.85 0.96 0.57 3.07 8.965 12.515 1.84 15.44 17.835 2.535 6.14 0.6];

stdC=mean(C_stds);
stdN=mean(cell2mat(Nlog_std));

end