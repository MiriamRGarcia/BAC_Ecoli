%******************************************************************************
% AMIGO2: dynamic modeling, optimization and control of biological systems    % 
% Examples implemented by  Eva Balsa-Canto, Attila Gábor, David Henriques     %
% Address:              Process Engineering Group, IIM-CSIC                   %
%                       C/Eduardo Cabello 6, 36208, Vigo-Spain                %
% e-mail:               ebalsa@iim.csic.es                                    %
% Copyright:            CSIC, Spanish National Research Council               %
% Last update: May 2016                                                       %
%******************************************************************************


% Examples are distributed in folders which correspond to the different
% tasks AMIGO2 may perform.
%
% In every folder you will find run_* files. By typing or running those
% files the corresponding necessary files will be generated, called and the task will
% be authomatically performed for the given example.
%
% ***IMPORTANT**** 
% Most of the examples have been implemented to run using the C based enhanced mode. 
% If you do not have a C compiler PLEASE modify:
%
% inputs.model.input_model_type='charmodelC'; ---> inputs.model.input_model_type='charmodelM'; 
% inputs.ivpsol.ivpsolver='cvodes'; --->   inputs.ivpsol.ivpsolver='ode15s';                   
% inputs.ivpsol.senssolver='cvodes'; --->  inputs.ivpsol.senssolver='sensmat';
%
% in this way all examples will be run in MATLAB code.
%
% In any case we advise to install a C compiler to experience the better
% performance offered by C coding.
%
%
% FURTHER EXAMPLES may be found in AMIGO2 webpage.
%
%

% 
% WARNING FOR MAC USERS
% 
% NL2SOL AND DN2FB are third party least squares optimization solvers programmed in FORTRAN. 
% AMIGO2 provides the mexfiles to use them. However MAC users may take into  that there are some 
% incompatibility issues with the reduced gfortran library provided within MATLAB.
% 
% We suggest to use full gfortran library to exploit the capabilities of nl2sol and n2fb for 
% PE and REG_PE
%
% Proceed as follows:
%
% 1. Download gfortran binaries (https://gcc.gnu.org/wiki/GFortranBinaries#MacOS)
% 2. Copy the file .matlab7rc.sh from “matlabroot" / bin to the users folder (~).
%    This script sets up the environment for MATLAB before it starts. 
%
%    copyfile(fullfile(matlabroot,'bin','.matlab7rc.sh'),fullfile('~','.matlab7rc.sh'),'f')
%
% 3. Open the file .matlab7rc.sh with a text editor and add a line for the case of mac|maci|maci64 (around line 200)
%    LDPATH_PREFIX=‘path_to_gfortran/lib’
%
%    edit(fullfile('~','.matlab7rc.sh’))
%
%


