clear all;

alpha_pinene_PseudoData

AMIGO_Prep(inputs)


%% hetero lin data:
% the noise contains two parts:
% a) proportional to the signal  n ~ b*y        b: relative std deviation
% b) there is a minimum noise  n_min  = a       a: absolute std deviation
cprintf('*[1,0.5,0]','\n\n --->Generating data with linear heteroscedastic noise');
pause(1)
clear
alpha_pinene_PseudoData
inputs.exps.noise_type = 'hetero_lin';
inputs.exps.std_deva{1} = 0.3*[10 6 0.6 0.4 2];   % absolute standard deviation, different to each observables.
inputs.exps.std_devb{1} = ones(1,5)*0.1;          % relative std. 10 %

AMIGO_SData(inputs)


%% hetero_proportional data
% the noise is just proportional to the data, the relative standard
% deviation is defined.
cprintf('*[1,0.5,0]','\n\n --->Generating data with data proportional noise');
pause(1)
clear
alpha_pinene_PseudoData;
inputs.exps.noise_type = 'hetero_proportional';
inputs.exps.std_dev{1} = ones(1,5)*0.1;  % 10% noise

AMIGO_SData(inputs)


%% hetero data
% user specify the standard deviation for every timestep.
cprintf('*[1,0.5,0]','\n\n --->Generating data with known non-constant standard deviation');
pause(1)
clear
alpha_pinene_PseudoData;
inputs.exps.noise_type = 'hetero';
inputs.exps.error_data{1} = 0.1* [
		98.7655  0.405133  0.0  0.143161  0.379067 
		93.6304  10.1338  3.28087  0.796575  0.836232
		79.8872  14.7635  5.90562  -0.447055  6.26825
		65.9462  37.7563  5.93682  0.31603  8.22038
		72.8602  36.1093  5.77506  0.717804  6.05675
		39.5912  55.4115  5.64632  1.15495  10.1966
		19.2677  39.8579  5.35577  2.53723  18.5619
		10.70984  53.0364  4.70818  2.77677  23.4239
		9.27474  62.2922  4.64648  3.478  22.7581
		];

AMIGO_SData(inputs)

%% homo_var data
% the noise is constant for each experiment. The user gives the relative
% standard deviation, that is scaled by the maximum simulation value.
cprintf('*[1,0.5,0]','\n\n --->Generating data with homoscedastic constant noise');
pause(1)
clear
alpha_pinene_PseudoData;
inputs.exps.noise_type = 'homo_var';
inputs.exps.std_dev{1} = ones(1,5)*0.1;  % 10% noise

AMIGO_SData(inputs)

