%%
% <<logo_AMIGO2_small.png>>
%
% <html>
% <p style="color:#007946;font-size:18pt;text-align:right; margin-top: 1px; margin-bottom: 1px;"> <b>Getting started</b></p>
% <hr align="left" width="820">
% </html>

%%
%
%% Toolbox structure
%
% AMIGO2 is organized in three main modules: the pre-processor, the numerical kernel and the post-processor. Given a problem definition (inputs structure), AMIGO_Prep preprocesses user input
% data, generates necessary directories and code (MATLAB, C or FORTRAN and mexfiles). The different numerical modules are then called by the user to perform the desired task(s).
%

%% Code organization
%
%%
% This general structure correlates to the following folder and code organization:
%
%% 
% <<AMIGO2_code_folder_dist.png>>

%%
% *Help folder* keeps all toolbox related documentation.
%%
% *Examples folder* keeps a number of implemented examples that user may consider as templates to
% implement new problems.
%%
% *Inputs folder* keeps new inputs created by users.
%%
% *Kernel folder* keeps all numerical functions, NLP solvers, IVP solvers and auxiliary code (FORTRAN
% compilation required
files).
%%
% *Postprocessor folder* keeps all matlab functions to generate reports, structures and figures.
%%
% *Preprocessor folder* keeps all matlab functions to generate matlab or fortran code, to mex files when
% required and to generate necessary paths. This folder keeps also the defaults for all inputs, user
% may modify public defaults in: AMIGO_public_defaults.m
%%
% *Release_info folder* contains the AMIGO_release_info.m with all details about previous and current
% releases.
%%
% *Results folder* keeps all results. User may create other results folders.

%% Installation of basic and enhanced modes

    %% 
    % Make sure that AMIGO2 folder is copied on a path without spaces for full functionality. 
    % Open a MATLAB session, move to the path AMIGO2 path and run AMIGO_Startup for the
    % basic mode:
    
AMIGO_Startup;    

    %%
    % For enhanced modes with Fortran or C models the following is
    % required:
    % See :
    
    %%
    % * <doc_AMIGO_fortran_inst.html Install Fortran utilities in AMIGO>
    % * <doc_AMIGO_c_inst.html Install C utilities in AMIGO>
    %


%% How to input problems in AMIGO

    %%
    % AMIGO is programmed making use of the so called Matlab structures. Structures are multidimensional
    % Matlab arrays with elements called fields. These fields may be of any data type (arrays, matrices,
    % strings of characters, etc.) and may be easily classified in subsets, therefore being quite comfortable for
    % managing all input and output information. See: <doc_AMIGO_Input.html How to input problems in AMIGO>. 
     
    

%% AMIGO Tasks
    
    %%
    % * <doc_AMIGO_Prep.html AMIGO_Prep:>  processes and checks the inputs and creates the
    % neccessary binary code.
    % * <doc_AMIGO_ShowNetwork.html AMIGO_ShowNetwork:>  links to Cytoscape
    % to show the model network
    % * <doc_AMIGO_SModel.html AMIGO_SModel:> simulates the model and plots
    % the states at the specified time points.
    % * <doc_AMIGO_SObs.html AMIGO_SObs:> simulates the model and plots
    % the observables at the specified time points.
    % * <doc_AMIGO_SData.html AMIGO_SData:> simulates the model and plots
    % the predictions together with the measured data. Also creates
    % pseudo-data.
    % * <doc_AMIGO_PE.html AMIGO_PE:> performs the estimation of
    % the unknown model parameters
    % * <doc_AMIGO_REG_PE.html AMIGO_REG_PE:> solves the parameter estimation problem with 
    % regularization techniques 
    % * <doc_AMIGO_PE_PostAnalysis.html AMIGO_PE_PostAnalysis:> performs
    % several fit analysis after parameter estimation
    % * <doc_AMIGO_LRank.html AMIGO_LRank:> computes the local ranking of
    % the model parameters
    % * <doc_AMIGO_GRank.html AMIGO_GRank:> computes the local ranking of
    % the model parameters
    % * <doc_AMIGO_RIdent.html AMIGO_RIdent:> computes the robust identifiability of
    % the model parameters
    % * <doc_AMIGO_ContourP.html AMIGO_ContourP:> creates contour plots of
    % the cost function
    % * <doc_AMIGO_OED.html AMIGO_OED:> solves optimal
    % experimental design problems
    % * <doc_AMIGO_DO.html AMIGO_DO:> solves single- and multi-objective dynamic optimization
    % problems
 
    