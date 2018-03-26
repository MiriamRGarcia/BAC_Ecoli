%% Obejctive functional
% [yteor] = AMIGO_ODcost(od,inputs,results,privstruct)
%
%  Arguments: od (current value of decision variables)
%             inputs,results,privstruct
%             yteor (value of the states for the given 
%                    decision variables)
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
%  Function that provides the necessary inputs for the OD 
%  cost function and constraints. Note that problem dependent
%  functions will be generated for cost function and constraints.
%   
%%



function [yteor,f,g] = AMIGO_IDOcost(ido,inputs,results,privstruct);


global n_amigo_sim_success;
global n_amigo_sim_failed;
if inputs.pathd.print_details
    disp('--> AMIGO_IDOcost()')
end

    % Initialice cost
        f=0.0;
        g=[];
        privstruct.ido=ido;
       
     %%% COUNTS DATA
 
      ndata=0;
      nexpdata = zeros(1,inputs.exps.n_exp);
% number of data: total and for each experiment
for iexp=1:inputs.exps.n_exp
    % count the numerical element of exp_data. (excluding the nan-s)
    exp_data = inputs.exps.exp_data{iexp};
    
    if isempty(inputs.exps.nanfilter{iexp})
        nexpdata(iexp) = inputs.exps.n_s{iexp}*inputs.exps.n_obs{iexp};
        inputs.exps.nanfilter{iexp} = true(inputs.exps.n_s{iexp},inputs.exps.n_obs{iexp});
    else
        nexpdata(iexp) = numel(exp_data(inputs.exps.nanfilter{iexp}));
    end
    
    ndata=ndata+nexpdata(iexp);
end
g = zeros(1,ndata);
        
        
        
%% CVP approach
%
% * Calls AMIGO_transform_od to generate u and tf from the vector ido

        [privstruct,inputs,results]=AMIGO_transform_ido(inputs,results,privstruct);
        
        
%% Inner iteration: IVP solution
%
% * Calls AMIGO_ivpsol
        %if privstruct.iflag==2   
  nprocessedData = 0;        
          
for iexp=1:inputs.exps.n_exp
            % Memory allocation for matrices
            %privstruct.yteor=zeros(inputs.exps.n_s{iexp},inputs.model.n_st);
            %ms=zeros(inputs.exps.n_s{iexp},inputs.exps.n_obs{iexp});
            
            error_matrix=[];
            

            [yteor,privstruct]=AMIGO_ivpsol(inputs,privstruct,privstruct.y_0{iexp},privstruct.par{iexp},iexp);
            
   
        
 %%% COMPUTES OBSERVABLES
  
            privstruct.yteor=yteor;
            
            obsfunc=inputs.pathd.obs_function;
            
            ms=feval(...
                obsfunc,...
                privstruct.yteor,...
                inputs,...
                privstruct.par{iexp},...
                iexp...
                );
            
       
            if(privstruct.ivpsol.ivp_fail)
                f=Inf;
                g(1:ndata) = Inf;
                return;             
            end %if(privstruct.ivpsol.ivp_fail)
           
 
  %%% COMPUTES COST       
  % accumulate the number of data in each experiment.
  %Helps indexing the cost vector / residual vector

  switch inputs.IDOsol.IDOcost_type   
                
                %LEAST SQUARES FUNCTION
                
                case 'lsq'
                    
                    % residuals in matrix form without weighting:
                    resM = ms-inputs.exps.exp_data{iexp};
                    
                    switch inputs.IDOsol.lsq_type
                        
                        case 'Q_mat'
                            % weighting matrix:
                            Q = inputs.PEsol.lsq_Qmat{iexp};
    
                            scaledResM = resM.*Q;
                            % reshape to a columnvector:
                            g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = scaledResM(:);
                            f=g*g';
                            if isreal(f)==0 || isnan(f)==1
                                f=1e20; end
                            
                        case 'Q_mat_obs' % for the cases where the observables have different matrices
                            % weighting matrix:
                            Q = inputs.IDOsol.lsq_Qmat{iexp};
                            scaledResM = reshape(resM,1,ndata)*Q;
                            % reshape to a columnvector:
                            g = scaledResM;
                            f=g*g';
                            if isreal(f)==0 || isnan(f)==1
                                f=1e20; end
                            
                        case 'Q_I'
                            g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = resM(:);
                            f=g*g';
                           
                            if isreal(f)==0 || isnan(f)==1
                                f=1e20; end
                            
                        case 'Q_exp'
                            % weighting matrix is the measurements.
                            Q = 1./inputs.exps.exp_data{iexp};
                            tmp1 = or(isinf(Q),isinf(Q));
                            % if the inverse is inf or too huge (data near zero), than the
                            Q(tmp1) = 1;
                            scaledResM = resM.*Q;
                            % reshape to a columnvector:
                            g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = scaledResM(:);
                            f=g*g';
                            if isreal(f)==0 || isnan(f)==1
                                f=1e20; end
                            
                        case 'Q_expmax'
                            expDataMax = max(inputs.exps.exp_data{iexp});
                            % every timepoint of each observable have the same
                            % weighting factor:
                            Q = repmat(1./expDataMax, inputs.exps.n_s{iexp},1);
                            % handles close infinity weights / clsoe zero experiments:
                            tmp1 = or(isnan(Q),isinf(Q));
                            Q(tmp1) = 1;
                            scaledResM = resM.*Q;
                            g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = scaledResM(:);
                            f=g*g';
                            if isreal(f)==0 || isnan(f)==1
                                f=1e20; end
                            
                        case 'Q_expmean'
                            % weighting matrix is the mean of the trajectories
                            expDataMean = mean(inputs.exps.exp_data{iexp});
                            Q = repmat(1./expDataMean, inputs.exps.n_s{iexp},1);
                            % handles close infinity weights:
                            tmp1 = or(isnan(Q),isinf(Q));
                            Q(tmp1) = 1;
                            
                            scaledResM = resM.*Q;
                            % reshape to a columnvector:
                            g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = scaledResM(:);
                            f=g*g';
                            if isreal(f)==0 || isnan(f)==1
                                f=1e20; end
                        otherwise
                            error('There is no such kind of lsq_type: %s', inputs.IDOsol.lsq_type);
                                                        
                   end %switch inputs.lsq_type
  
                    case 'llk'
                    % EBC to make it work for homo_var--- REMOVE
                    %inputs.PEsol.llk_type='homo_var';
                    
                    switch inputs.IDOsol.llk_type
                        
                        %       AG commented this case 19/09/13                  case 'homo'
                        %                             % residuals weighted by the error data
                        %
                        %                             if isempty(inputs.exps.error_data{iexp})
                        %
                        %                                 inputs.exps.error_data{iexp}=...
                        %                                     repmat(max(inputs.exps.exp_data{iexp}).*inputs.exps.std_dev{iexp},[inputs.exps.n_s{iexp},1]);
                        %                             end
                        %                             scaledResM = resM./inputs.exps.error_data{iexp};
                        %
                        %                             g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = scaledResM(:);
                        %
                        %                             f=0.5*(g*g');
                        %                             if isreal(f)==0 || isnan(f)==1
                        %                                 f=1e20;
                        %                             end
                        
                        case {'homo','homo_var'}
                            
                            error_data =  repmat(max(inputs.exps.exp_data{iexp}).*inputs.exps.std_dev{iexp},[inputs.exps.n_s{iexp},1]);
                            
                            error_data(error_data <= 1e-12) = inputs.ivpsol.atol;    %To avoid /0
                            
                            
                            for i_obs=1:inputs.exps.n_obs{iexp}
                                error_matrix=...
                                    [error_matrix; (ms(:,i_obs)-inputs.exps.exp_data{iexp}(:,i_obs))./(error_data(:,i_obs))];
                            end
                            g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = error_matrix';
                            %                             g=[g error_matrix'];
                            
                            %f = 0.5*sum(g.^2); if the 0.5 is needed here,
                            %be sure that the Least Squares local algorithm
                            %also takes the half. Otherwise the value
                            %computed by the eSS and the value computed by
                            %the NLS solver are different.
                            f = sum(g.^2);
                            
                            if isreal(f)==0 || isnan(f)==1
                                f=1e20;
                            end
                            
                            
                        case 'hetero'
                            % changed by AG
                            % heteroscedastic noise with known  standard
                            % deviation (sigma and not sigma^2!)
                            % provided in inputs.exps.error_data{iexp}.
                            % weighted least squares case.
                            
                            
                            error_data = abs(inputs.exps.error_data{iexp});
                            error_data(abs(error_data) <= inputs.ivpsol.atol) = inputs.ivpsol.atol;    %To avoid /0
                            
                            try
                                error_matrix = (ms - inputs.exps.exp_data{iexp})./error_data;
                            catch
                                fprintf('The observation function is probably corrupted.\n');
                                keyboard
                            end
                            
                            error_matrix = error_matrix(inputs.exps.nanfilter{iexp});
                            
                            g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = error_matrix(:)';
                            
                            f=sum(g.^2);
                            
                            if isreal(f)==0 || isnan(f)==1
                                f=1e20;
                            end
                            
                        case 'hetero_proportional'
                            %Standard deviation is assumed to be
                            %proportional to ms, noise = std_dev*y
                            
                            ms(ms<=1e-12)=inputs.ivpsol.atol;   % To avoid log(0) and /0
                            
                            for i_obs=1:inputs.exps.n_obs{iexp}
                                
                                g1=g1+sum(log(abs(ms(:,i_obs))));
                                
                                % dREAM g1=g1+sum(log(0.01*ones(size(ms(:,i_obs)))+0.04*ms(:,i_obs).^2));
                                
                                error_matrix=...
                                    [error_matrix; (ms(:,i_obs)-inputs.exps.exp_data{iexp}(:,i_obs))...
                                    ./(inputs.exps.std_dev{iexp}(i_obs).*ms(:,i_obs))];
                                
                            end %i_obs=1:inputs.exps.n_obs{iexp}
                            
                            %g is only approximated in this case, better
                            %not to use n2fb or dn2fb or NL2SOL
                            % DO NOT USE NL2SOL, THIS IS NOT A NONLINEAR
                            % LEAST SQUARES PROBLEM!!!
                            g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = error_matrix';
                            %g=[g error_matrix'];
                            
                            f=(2/ndata)*g1+sum(g.^2);
                            
                            if isreal(f)==0 || isnan(f)==1
                                f=1e20;
                            end
                            
                            
                            
                        case 'hetero_lin'
                            
                            for i_obs=1:inputs.exps.n_obs{iexp}
                                
                                for i_s=1:inputs.exps.n_s{iexp}
                                    if(abs(ms(i_s,i_obs))<=1e-12) % To avoid log(0) and /0
                                        ms(i_s,i_obs)=inputs.ivpsol.atol;
                                    end
                                end
                                
                                g1=g1+sum(log((inputs.PEsol.llk.stddeva{iexp}(i_obs)^2)*ones(size(ms(:,i_obs)))+(inputs.PEsol.llk.stddevb{iexp}(i_obs)^2)*ms(:,i_obs).^2));
                                % dREAM g1=g1+sum(log(0.01*ones(size(ms(:,i_obs)))+0.04*ms(:,i_obs).^2));
                                error_matrix=[error_matrix; (ms(:,i_obs)-inputs.exps.exp_data{iexp}(:,i_obs))./(inputs.PEsol.llk.stddeva{iexp}(i_obs)+inputs.PEsol.llk.stddevb{iexp}(i_obs).*ms(:,i_obs))];
                            end %i_obs=1:inputs.exps.n_obs{iexp}
                            
                            g(nprocessedData+1 : nprocessedData + nexpdata(iexp)) = error_matrix';
                            %g=[g error_matrix'];  % g is only approximated in this case, better not to use n2fb or dn2fb
                            
                            f=(2/ndata)*g1+sum(g.^2);
                            if ~isreal(f) || isnan(f)
                                f=1e20;
                            end
                            
                            
                        otherwise
                            error('There is no such kind of llk_type: %s', inputs.PEsol.llk_type);
                            
                    end %switch inputs.IDOsol.llk_type
                    
                otherwise
                    error('There is no such kind of cost-function type: %s', inputs.PEsol.PEcost_type);
            end %   switch inputs.IDOsol.IDOcost_type
            
          
  
  
  
            % REGULARIZATION CONTROL --- SOLVING: INTEGRAL (U-U_REF)^2
            
            if inputs.model.alpha>0
                 reg_u=0;

                 if isempty(inputs.IDOsol.u_ref{iexp})
                   inputs.IDOsol.u_ref{iexp}=inputs.IDOsol.u_guess{iexp};
                 end
                 
                   
                    switch inputs.exps.u_interp{iexp}     
                 
                    case 'sustained'
                     
                     for iu=1:inputs.model.n_stimulus
                     reg_u=reg_u+(inputs.exps.u{iexp}(iu)-inputs.IDOsol.u_ref{iexp}(iu))^2*privstruct.tf{iexp};
                     end
                    case {'step','stepf'}
                                   
                     for iu=1:inputs.model.n_stimulus
                     reg_u=reg_u+sum((inputs.exps.u{iexp}(iu,:)-inputs.IDOsol.u_ref{iexp}(iu,:)).^2.*diff(privstruct.t_con{iexp}));
                     end  
                                 
                    case {'linear','linearf'}
                     for iu=1:inputs.model.n_stimulus
                      for ilinear=1:inputs.model.n_linear-1
                      d(iu,ilinear)=inputs.exps.u{iexp}(iu,ilinear+1)-inputs.exps.u{iexp}(iu,ilinear);
                      end
                     reg_u=reg_u+sum(d(iu).^2.*diff(privstruct.t_con{iexp}));
                     end
                    end %switch inputs.exps.u_interp{iexp}     
                        
                   
                    f=f+inputs.model.alpha*reg_u;
            end % if inputs.model.alpha>0
            
            % REGULARIZATION PARAMETERS
            
            if inputs.model.beta>0
              if isempty(inputs.IDOsol.par_ref)
                   inputs.IDOsol.par_ref=inputs.IDOsol.par_guess;
              end
                          
                   reg_par=sum((privstruct.par{iexp}(inputs.IDOsol.index_par)-inputs.IDOsol.par_ref).^2);
                   
                   f=f+inputs.model.beta*reg_par;
                   
            end
            
            nprocessedData =nprocessedData + nexpdata(iexp);

 end %iexp=1:inputs.n_exp
            
            
           
        
        
return