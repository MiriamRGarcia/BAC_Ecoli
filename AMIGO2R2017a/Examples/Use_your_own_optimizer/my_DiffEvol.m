%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE: Example on how to use your own optimization code in AMIGO
%        my_AMIGO_DE.m: calls DE as if it was a new solver to be tested  
%                     in AMIGO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%        User should write a matlab script that will be directly called
%        from amigo when typing:
%              AMIGO_PE('problem_input_file','run_ident','my_solvername')
%
%        example: AMIGO_PE('HH','test1','my_DiffEvol')              
%  
%        The file should follow this structure:
%
%           > Definition of solver options if any
%           > Declares some necessary inputs
%           > Calls the solver
%           > Keeps results in the AMIGO structure results.nlpsol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%******************************************************************************
% AMIGO2: dynamic modeling, optimization and control of biological systems    % 
% Code development:     Eva Balsa-Canto                                       %
% Address:              Process Engineering Group, IIM-CSIC                   %
%                       C/Eduardo Cabello 6, 36208, Vigo-Spain                %
% e-mail:               ebalsa@iim.csic.es                                    %
% Copyright:            CSIC, Spanish National Research Council               %
%**************************************************************************


%
% DEFINITION OF SOLVER OPTIONS
%


opts.VTR=-1.0;      % is reached or the best parameter vector "bestmem"  has found a value f(bestmem,y) <= VTR.
opts.NP =50;   % NP:  number of population members (
opts.itermax = 100; % itermax:  maximum number of iterations (generations)
opts.cvarmax=1.e-2; %cvarmax: maximum variance for a population
opts.F = 1; %0.75;  % F: DE-stepsize F ex [0, 2] 
opts.CR =0.85;      % CR: crossover probabililty constant ex [0, 1]

% strategy       1 --> DE/best/1/exp           6 --> DE/best/1/bin
%                2 --> DE/rand/1/exp           7 --> DE/rand/1/bin
%                3 --> DE/rand-to-best/1/exp   8 --> DE/rand-to-best/1/bin
%                4 --> DE/best/2/exp           9 --> DE/best/2/bin
%                5 --> DE/rand/2/exp           else  DE/rand/2/bin
opts.strategy =3;       %2     
opts.refresh =1; %intermediate output will be produced after "refresh" iterations
opts.var=1.0;    %var for initial pop generation

inputs.nlpsol.nlp_opts=opts;

%
% DECLARES SOME NECESSARY INPUTS
%

%% In this case all necessary inputs are declared in the structures inputs,
%% results, privstruct.

   inputs.nlpsol.vguess=vguess;
   inputs.nlpsol.vmin=vmin;
   inputs.nlpsol.vmax=vmax;   


%
% CALLS THE SOLVER: Note that any inputs/outputs may be used 
%

[bestmem,bestval,nfeval,cpu_time,conv_curve,pop]=DiffEvol('AMIGO_PEcost',inputs,results,privstruct);


%
% KEEPS RESULTS IN THE AMIGO STRUCTURE results.nlpsol
%

% Examples
results.nlpsol.vbest=bestmem;           % Keeps best set of decision variables
results.nlpsol.fbest=bestval;           % Keeps best objective function

results.nlpsol.conv_curve=conv_curve;   %Defines convergence curve as a matrix: 
                                        %1st column: CPU time x 2nd column: Objective function 
results.nlpsol.cpu_time=cpu_time;       % Keeps overall cpu_time

