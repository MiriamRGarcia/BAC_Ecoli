%% Mesh refinement technique
%  AMIGO_ReOpt: performs a mesh refining an re-optimizes
%
% *Version details*
% 
%   AMIGO_OD version:     March 2013
%   Code development:     Eva Balsa-Canto
%   Address:              Process Engineering Group, IIM-CSIC
%                         C/Eduardo Cabello 6, 36208, Vigo-Spain
%   e-mail:               ebalsa@iim.csic.es 
%   Copyright:            CSIC, Spanish National Research Council
%
% *Brief description*
%
%  This script will be used for stepf control interpolations
%  the underlying idea is to iteratively increase control discretization
%  level. Typically run with local optimizers.
%%

%% Reads previous optimal solution and refines control discretization

                results.ido.reopt.t_f=results.ido.t_f;
                results.ido.reopt.u=results.ido.u;
                results.ido.reopt.t_con=results.ido.t_con;
                results.ido.reopt.fbest=results.nlpsol.fbest;
                results.ido.reopt.cpu_time=results.nlpsol.cpu_time;
                if inputs.IDOsol.n_par>0, results.ido.reopt.upar=results.ido.upar;end
                switch inputs.IDOsol.u_interp
                
                case 'stepf'
                    
                  if inputs.IDOsol.n_par>0,
                      inputs.IDOsol.par_guess=results.ido.reopt.upar;
                  end
                   
                  
                  for iopt=1:inputs.nlpsol.n_reOpts
                  for iexp=1:inputs.exps.n_exp    
                  inputs.IDOsol.tf_guess=results.ido.t_f;
                  inputs.IDOsol.n_steps{iexp}=2*inputs.IDOsol.n_steps{iexp};
                  inputs.exps.n_steps=inputs.IDOsol.n_steps;
                  for iu=1:inputs.model.n_stimulus
                  count_step=1;    
                  for istep=1:inputs.IDOsol.n_steps{iexp}/2    
                  inputs.IDOsol.u_guess{iexp}(iu,count_step)=results.ido.u{iexp}(iu,istep);
                  inputs.IDOsol.u_guess{iexp}(iu,count_step+1)=results.ido.u{iexp}(iu,istep);
                  inputs.IDOsol.u_min{iexp}(iu,count_step)=inputs.IDOsol.u_min{iexp}(iu,istep);
                  inputs.IDOsol.u_min{iexp}(iu,count_step+1)=inputs.IDOsol.u_min{iexp}(iu,istep);
                  inputs.IDOsol.u_max{iexp}(iu,count_step)=inputs.IDOsol.u_max{iexp}(iu,istep);
                  inputs.IDOsol.u_max{iexp}(iu,count_step+1)=inputs.IDOsol.u_max{iexp}(iu,istep);
                  count_step=count_step+2;
                  end %for istep=1:inputs.IDOsol.n_steps{iexp}/2 
                  end %for iu=1:inputs.model.n_stimulus
                  inputs.IDOsol.t_con{iexp}=[0:inputs.IDOsol.tf_guess{iexp}/inputs.IDOsol.n_steps{iexp}:inputs.IDOsol.tf_guess{iexp}];
                  end %for iexp=1:inputs.exps.n_exp  
                  
                  
                  
 %%              
 % * Calls AMIGO_initi_OD_guess_bounds
 
%% Generation of the cost function and constraints

                AMIGO_init_IDO_guess_bounds
%%
% * Calls AMIGO_gen_DOcost 

             
                [inputs,results]=AMIGO_gen_IDOcost(inputs,inputs.nlpsol.reopt,iopt);

%% Starts successive reoptimizations

%%
% * Calls AMIGO_call_ODOPTsolver             
                fprintf(1,'\n\n>>>>> RE-OPTIMIZATION %u\n\n', iopt);
                inputs.ivpsol.rtol=0.1*inputs.ivpsol.rtol;
                inputs.ivpsol.atol=0.1*inputs.ivpsol.atol;
                [results]=AMIGO_call_IDOOPTsolver(inputs.nlpsol.reopt_solver,inputs.IDOsol.vdo_guess,inputs.IDOsol.vdo_min,inputs.IDOsol.vdo_max,inputs,results,privstruct);        
              
%% Keeps outputs in the results.ido structure and gives control back to AMIGO_OD for postprocessing              
                privstruct.ido=results.nlpsol.vbest;
                [privstruct,inputs,results]=AMIGO_transform_ido(inputs,results,privstruct);
              
                results.ido.t_f=privstruct.t_f;
                results.ido.u=privstruct.u;
                results.ido.t_con=privstruct.t_con; 
                if inputs.IDOsol.n_par>0, results.ido.upar=privstruct.upar;end
                results.ido.reopt.t_f{iopt+1}=results.ido.t_f;
                results.ido.reopt.u{iopt+1}=results.ido.u;
                results.ido.reopt.t_con{iopt+1}=results.ido.t_con;
                results.ido.reopt.fbest{iopt+1}=results.nlpsol.fbest;
                results.ido.reopt.cpu_time{iopt+1}=results.nlpsol.cpu_time;
                
               end %for iopt=1:inputs.nlpsol.n_reOpts
                
                  
               case 'linearf'
                                     
                  if inputs.IDOsol.n_par>0,
                      inputs.IDOsol.par_guess=results.ido.reopt.upar;
                  end
                   
                  
                  for iopt=1:inputs.nlpsol.n_reOpts
                  for iexp=1:inputs.exps.n_exp  
                  inputs.IDOsol.tf_guess=results.ido.t_f;
                  inputs.IDOsol.n_linear{iexp}=2*inputs.IDOsol.n_linear{iexp};
                  inputs.exps.n_linear=inputs.IDOsol.n_linear;
                  for iu=1:inputs.model.n_stimulus
                  count_step=1;    
                  for istep=1:inputs.IDOsol.n_linear{iexp}/2    
                  inputs.IDOsol.u_guess{iexp}(iu,count_step)=results.ido.u{iexp}(iu,istep);
                  inputs.IDOsol.u_guess{iexp}(iu,count_step+1)=results.ido.u{iexp}(iu,istep);
                  inputs.IDOsol.u_min{iexp}(iu,count_step)=inputs.IDOsol.u_min{iexp}(iu,istep);
                  inputs.IDOsol.u_min{iexp}(iu,count_step+1)=inputs.IDOsol.u_min{iexp}(iu,istep);
                  inputs.IDOsol.u_max{iexp}(iu,count_step)=inputs.IDOsol.u_max{iexp}(iu,istep);
                  inputs.IDOsol.u_max{iexp}(iu,count_step+1)=inputs.IDOsol.u_max{iexp}(iu,istep);
                  count_step=count_step+2;
                  end % for istep=1:inputs.IDOsol.n_linear{iexp}/2 
                  end %for iu=1:inputs.model.n_stimulus
                  inputs.IDOsol.t_con{iexp}=linspace(0,inputs.exps.t_f{iexp},inputs.IDOsol.n_linear{iexp});
                  end %for iexp=1:inputs.exps.n_exp
                  
 %%              
 % * Calls AMIGO_initi_OD_guess_bounds
 
%% Generation of the cost function and constraints

                AMIGO_init_IDO_guess_bounds
%%
% * Calls AMIGO_gen_DOcost 

             
              [results]=AMIGO_gen_IDOcost(inputs,inputs.nlpsol.reopt,iopt);

%% Starts successive reoptimizations

%%
% * Calls AMIGO_call_ODOPTsolver             
              fprintf(1,'\n\n>>>>> RE-OPTIMIZATION %u\n\n', iopt);
              inputs.ivpsol.rtol=0.1*inputs.ivpsol.rtol;
              inputs.ivpsol.atol=0.1*inputs.ivpsol.atol;
              [results]=AMIGO_call_IDOOPTsolver(inputs.nlpsol.reopt_solver,inputs.IDOsol.vdo_guess,inputs.IDOsol.vdo_min,inputs.IDOsol.vdo_max,inputs,results,privstruct);        
              
%% Keeps outputs in the results.ido structure and gives control back to AMIGO_DO for postprocessing              
              privstruct.ido=results.nlpsol.vbest;
              [privstruct,inputs,results]=AMIGO_transform_ido(inputs,results,privstruct);
              
              results.ido.t_f=privstruct.t_f;
              results.ido.u=privstruct.u;
              results.ido.t_con=privstruct.t_con; 
               if inputs.IDOsol.n_par>0, results.ido.upar=privstruct.upar;end
          
                results.ido.reopt.t_f{iopt+1}=results.ido.t_f;
                results.ido.reopt.u{iopt+1}=results.ido.u;
                results.ido.reopt.t_con{iopt+1}=results.ido.t_con;
                results.ido.reopt.fbest{iopt+1}=results.nlpsol.fbest;
                results.ido.reopt.cpu_time{iopt+1}=results.nlpsol.cpu_time;
              
               end %for iopt=1:inputs.nlpsol.n_reOpts
                  
                  
                  
               
                
                end %switch inputs.IDOsol.u_interp