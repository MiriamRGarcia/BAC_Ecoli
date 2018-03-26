%% Initializes vector of decision variables and corresponding bounds
%
% AMIGO_init_OD_guess_bounds: initializes some necessary vectors for optimization
%
% *Version details*
%
%   AMIGO_IDO version:     March 2017
%   Code development:     Eva Balsa-Canto
%   Address:              Process Engineering Group, IIM-CSIC
%                         C/Eduardo Cabello 6, 36208, Vigo-Spain
%   e-mail:               ebalsa@iim.csic.es
%   Copyright:            CSIC, Spanish National Research Council
%
% *Brief description*
%
%  Script that generates initial guess and bounds using the CVP approach
%  Decision variables are ordered as follows:
%           - Final time
%           - Control values (steps, linear interpolation)
%           - Elements durations
%%


% BOUNDS FOR STIMULI + PARAMETERS --- CURRENTLY FOR ONE EXPERIMENT ----  TO
% BE MODIFIED FOR MULTIPLE EXPERIMENT

for iexp=1:inputs.exps.n_exp
if isempty(inputs.IDOsol.u_guess)==1
    inputs.IDOsol.u_guess{iexp}=inputs.IDOsol.u_min{iexp}+ 0.5*(inputs.IDOsol.u_max{iexp}-inputs.IDOsol.u_min{iexp});
end
end


% EBC -- consider the case with initial conditions to be designed

inputs.IDOsol.n_y0=size(inputs.IDOsol.id_y0,1);
indexy0=[];
if inputs.IDOsol.n_y0>0 
    
    indexy0=strmatch(inputs.IDOsol.id_y0(1,:),inputs.model.st_names,'exact');

    for iy0=2:inputs.IDOsol.n_y0
    indexy0=[indexy0 strmatch(inputs.IDOsol.id_y0(iy0,:),inputs.model.st_names,'exact')];
    end
    inputs.IDOsol.index_y0=indexy0;
    
    if isempty(inputs.IDOsol.y0_guess)
    inputs.IDOsol.y0_guess=inputs.IDOsol.y0_min+ 0.5*(inputs.IDOsol.y0_max-inputs.IDOsol.y0_min);                                 
    end

end %inputs.IDOsol.n_y0>0 



% EBC -- consider the case with parameters /sustained stimulation and time
% varying stimulation

inputs.IDOsol.n_par=size(inputs.IDOsol.id_par,1);
indexpar=[];
if inputs.IDOsol.n_par>0 
    
    indexpar=strmatch(inputs.IDOsol.id_par(1,:),inputs.model.par_names,'exact');

    for ipar=2:inputs.IDOsol.n_par
    indexpar=[indexpar strmatch(inputs.IDOsol.id_par(ipar,:),inputs.model.par_names,'exact')];
    end
    inputs.IDOsol.index_par=indexpar;
    
    if isempty(inputs.IDOsol.par_guess)
    inputs.IDOsol.par_guess=inputs.IDOsol.par_min+ 0.5*(inputs.IDOsol.par_max-inputs.IDOsol.par_min);                                 
    end

end %inputs.IDOsol.n_par>0 
    


% DEFINES INITIAL GUESS AND BOUNDS FOR OPTIMIZATION

inputs.IDOsol.vdo_guess=[];
inputs.IDOsol.vdo_min=[];
inputs.IDOsol.vdo_max=[];



%% Final time
%

switch  inputs.IDOsol.tf_type
    
    case 'fixed'
        inputs.IDOsol.tf_guess=privstruct.t_f;
        inputs.IDOsol.tf_max=privstruct.t_f;
        inputs.IDOsol.tf_min=privstruct.t_f;
        
    case 'od'
        
        switch  inputs.IDOsol.u_interp
            case {'stepf','linearf'}
                
                if isempty(inputs.IDOsol.tf_guess)
                    inputs.IDOsol.tf_guess=mean(inputs.IDOsol.tf_min{iexp}, inputs.IDOsol.tf_max{iexp});
                end
                for iexp=1:inputs.exps.n_exp
                inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.tf_guess{iexp}];
                inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.tf_min{iexp}];
                inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.tf_max{iexp}];
                end
        end
        
end;


%% Stimulation



switch inputs.IDOsol.u_interp
    %%
    % *  Sustained stimulation
    case 'sustained'
        for iexp=1:inputs.exps.n_exp
        if isempty(inputs.IDOsol.u_guess)==1
            for iu=1:inputs.model.n_stimulus
                inputs.IDOsol.u_guess{iexp}(iu,1)=mean([inputs.IDOsol.u_min{iexp}(iu,1); inputs.IDOsol.u_max{iexp}(iu,1)]);
            end
        end
        inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.u_guess{iexp}'];
        inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.u_min{iexp}'];
        inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.u_max{iexp}'];
        
        end
        %%
        % *  Pulse-up stimulation ___|---|___
        
    case 'pulse-up'
        for iexp=1:inputs.exps.n_exp
        pulse_duration_min=(inputs.IDOsol.tf_min{iexp}-inputs.exps.t_in{iexp})/(inputs.IDOsol.n_pulses{iexp}*2+1);
        pulse_duration_guess=(inputs.IDOsol.tf_guess{iexp}-inputs.exps.t_in{iexp})/(inputs.IDOsol.n_pulses{iexp}*2+1);
        pulse_duration_max=(inputs.IDOsol.tf_max{iexp}-inputs.exps.t_in{iexp})/(inputs.IDOsol.n_pulses{iexp}*2+1);
        inputs.IDOsol.tcon_min{iexp}=union([0.25*pulse_duration_min:pulse_duration_min:inputs.IDOsol.tf_min{iexp}-pulse_duration_min],inputs.IDOsol.tf_min{iexp});
        inputs.IDOsol.tcon_guess{iexp}{iexp}=union([0.75*pulse_duration_guess:pulse_duration_guess:inputs.IDOsol.tf_guess-pulse_duration_guess],inputs.IDOsol.tf_guess{iexp});
        inputs.IDOsol.tcon_max{iexp}=[1.0*pulse_duration_max:pulse_duration_max:1.0*inputs.IDOsol.tf_max{iexp}];
        
        inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.tcon_guess{iexp}{iexp}(1:inputs.IDOsol.n_pulses{iexp}*2)];
        inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.tcon_min{iexp}(1:inputs.IDOsol.n_pulses{iexp}*2)];
        inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.tcon_max{iexp}(1:inputs.IDOsol.n_pulses{iexp}*2)];
        end
        %%
        % *  Pulse-down stimulation |---|_____
    case 'pulse-down'
        
        for iexp=1:inputs.exps.n_exp
        pulse_duration=(inputs.IDOsol.tf_guess{iexp}-inputs.exps.t_in{iexp})/(inputs.IDOsol.n_pulses{iexp}*2);
        inputs.IDOsol.tcon_min=union([0.25*pulse_duration:pulse_duration:inputs.IDOsol.tf_min{iexp}-pulse_duration],inputs.IDOsol.tf_min{iexp});
        inputs.IDOsol.tcon_guess{iexp}{iexp}=union([0.75*pulse_duration:pulse_duration:inputs.IDOsol.tf_guess{iexp}-pulse_duration],inputs.IDOsol.tf_guess{iexp});
        inputs.IDOsol.tcon_max{iexp}=[1.0*pulse_duration:pulse_duration:1.0*inputs.IDOsol.tf_max{iexp}];
        
        inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.tcon_guess{iexp}{iexp}(1:inputs.IDOsol.n_pulses{iexp}*2-1)];
        inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.tcon_min{iexp}(1:inputs.IDOsol.n_pulses{iexp}*2-1)];
        inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.tcon_max{iexp}(1:inputs.IDOsol.n_pulses{iexp}*2-1)];
        end
        %%
        % *  Step-wise stimulation, elements of free duration
    case {'step'}
        
        for iexp=1:inputs.exps.n_exp
        if isempty(inputs.IDOsol.u_guess{iexp})==1
            for iu=1:inputs.model.n_stimulus
                inputs.IDOsol.u_guess{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})=mean([inputs.IDOsol.u_min{iexp}(iu,1:inputs.IDOsol.n_steps{iexp}); inputs.IDOsol.u_max{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})]);
            end
        end
        
        for iu=1:inputs.model.n_stimulus
            inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.u_guess{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})];
            inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.u_min{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})];
            inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.u_max{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})];
        end
        
        step_duration=(inputs.IDOsol.tf_guess{iexp}-inputs.exps.t_in{iexp})/(inputs.IDOsol.n_steps{iexp});
        if isempty(inputs.IDOsol.min_stepduration{iexp})
            max_step_duration=inputs.IDOsol.tf_max{iexp}-step_duration; %%OJO !!! aquí se admitía el máximo
            min_step_duration=inputs.IDOsol.tf_min{iexp}/(5*inputs.IDOsol.n_steps{iexp}+1); %%% OJO!!! aquí ponia 1000
        else
            max_step_duration=inputs.IDOsol.max_stepduration{iexp};
            min_step_duration=inputs.IDOsol.min_stepduration{iexp};
        end
        inputs.IDOsol.step_duration_min=min_step_duration*ones(1,inputs.IDOsol.n_steps{iexp});
        inputs.IDOsol.step_duration_max=max_step_duration*ones(1,inputs.IDOsol.n_steps{iexp});
        
        
        if isempty(inputs.IDOsol.t_con{iexp})
            
            inputs.IDOsol.step_duration_guess{iexp}=step_duration*ones(1,inputs.IDOsol.n_steps{iexp});
            inputs.IDOsol.tcon_max{iexp}=[1.5*step_duration:step_duration:inputs.IDOsol.tf_max{iexp} ];
            inputs.IDOsol.tcon_guess{iexp}{iexp}(1,1)=inputs.exps.t_in{iexp};
            for icon=2:inputs.IDOsol.n_steps{iexp}
                inputs.IDOsol.tcon_guess{iexp}{iexp}(1,icon)=inputs.IDOsol.tcon_guess{iexp}{iexp}(1,icon-1)+inputs.IDOsol.step_duration_guess{iexp}(1,icon);
            end
            inputs.IDOsol.tcon_guess{iexp}{iexp}(1,inputs.IDOsol.n_steps{iexp})=inputs.IDOsol.tf_guess{iexp};
            
            inputs.exps.t_con=inputs.IDOsol.tcon_guess{iexp};
            
        else %if isempty(inputs.IDOsol.t_con{iexp})
            
            for icon=2:inputs.IDOsol.n_steps{iexp}
                inputs.IDOsol.step_duration_guess{iexp}(icon-1)=inputs.IDOsol.t_con{iexp}(icon)-inputs.IDOsol.t_con{iexp}(icon-1);
            end
            inputs.IDOsol.tcon_guess{iexp}=inputs.IDOsol.t_con{iexp};
            
        end
        
        
        inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.step_duration_guess{iexp}];
        inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.step_duration_min(1:inputs.IDOsol.n_steps{iexp}-1)];
        inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.step_duration_max(1:inputs.IDOsol.n_steps{iexp}-1)];
        
        end
        %%
        % *  Step-wise stimulation, elements of fixed duration
    case 'stepf'
        
        
        for iexp=1:inputs.exps.n_exp
        if isempty(inputs.IDOsol.u_guess{iexp})==1
            for iu=1:inputs.model.n_stimulus
                inputs.IDOsol.u_guess{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})=mean([inputs.IDOsol.u_min{iexp}(iu,1:inputs.IDOsol.n_steps{iexp}); inputs.IDOsol.u_max{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})]);
            end
        end
        
        for iu=1:inputs.model.n_stimulus
            inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.u_guess{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})];
            inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.u_min{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})];
            inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.u_max{iexp}(iu,1:inputs.IDOsol.n_steps{iexp})];
        end
        
            
        if isempty(inputs.IDOsol.t_con{iexp})
            step_duration=(inputs.IDOsol.tf_guess{iexp}-inputs.exps.t_in{iexp})/inputs.IDOsol.n_steps{iexp};
            inputs.IDOsol.tcon_guess{iexp}{iexp}=[inputs.exps.t_in{iexp}:step_duration:inputs.IDOsol.tf_guess{iexp}];
        else
            inputs.IDOsol.tcon_guess{iexp}=inputs.IDOsol.t_con{iexp};
        end
 
        end
   
        
           %%
        % *  Linear-wise stimulation, elements of fixed duration
    case 'linearf'
        
        for iexp=1:inputs.exps.n_exp
        if isempty(inputs.IDOsol.u_guess{iexp})==1
            for iu=1:inputs.model.n_stimulus
                inputs.IDOsol.u_guess{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})=mean([inputs.IDOsol.u_min{iexp}(iu,1:inputs.IDOsol.n_linear{iexp}); inputs.IDOsol.u_max{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})]);
            end
        end
        
        for iu=1:inputs.model.n_stimulus
            inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.u_guess{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})];
            inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.u_min{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})];
            inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.u_max{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})];
        end
        
        
        if isempty(inputs.IDOsol.t_con{iexp})
            step_duration=(inputs.IDOsol.tf_guess{iexp}-inputs.exps.t_in{iexp})/(inputs.IDOsol.n_linear{iexp}-1);
            inputs.IDOsol.tcon_guess{iexp}{iexp}=[inputs.exps.t_in{iexp}:step_duration:inputs.IDOsol.tf_guess{iexp}];
        else
            inputs.IDOsol.tcon_guess{iexp}=inputs.IDOsol.t_con{iexp};
        end
             
        end
        
        %%
        % *  Linear-wise stimulation, elements of free duration
        
    case {'linear'}
        for iexp=1:inputs.exps.n_exp
        if isempty(inputs.IDOsol.u_guess{iexp})==1
            for iu=1:inputs.model.n_stimulus
                inputs.IDOsol.u_guess{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})=mean([inputs.IDOsol.u_min{iexp}(iu,1:inputs.IDOsol.n_linear{iexp}); inputs.IDOsol.u_max{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})]);
            end
        end
        
        for iu=1:inputs.model.n_stimulus
            inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.u_guess{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})];
            inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.u_min{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})];
            inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.u_max{iexp}(iu,1:inputs.IDOsol.n_linear{iexp})];
        end
        
        
        step_duration=(inputs.IDOsol.tf_guess{iexp}-inputs.exps.t_in{iexp})/(inputs.IDOsol.n_linear{iexp}-1);
        if isempty(inputs.IDOsol.min_stepduration{iexp})
            max_step_duration=inputs.IDOsol.tf_max{iexp}-step_duration; %%OJO !!! aquí se admitía el máximo
            min_step_duration=inputs.IDOsol.tf_min{iexp}/(5*inputs.IDOsol.n_linear{iexp}); %%% OJO!!! aquí ponia 1000
        else
            max_step_duration=inputs.IDOsol.max_stepduration{iexp};
            min_step_duration=inputs.IDOsol.min_stepduration{iexp};
        end
        inputs.IDOsol.step_duration_min{iexp}=min_step_duration*ones(1,inputs.IDOsol.n_linear{iexp}-1);
        inputs.IDOsol.step_duration_max{iexp}=max_step_duration*ones(1,inputs.IDOsol.n_linear{iexp}-1);
        
        
        if isempty(inputs.IDOsol.t_con{iexp})
            
            inputs.IDOsol.step_duration_guess{iexp}=step_duration*ones(1,inputs.IDOsol.n_linear{iexp}-1);
            inputs.IDOsol.tcon_max{iexp}=[1.5*step_duration:step_duration:inputs.IDOsol.tf_max{iexp} ];
            inputs.IDOsol.tcon_guess{iexp}{iexp}(1,1)=inputs.exps.t_in{iexp};
            for icon=2:inputs.IDOsol.n_linear{iexp}-1
                inputs.IDOsol.tcon_guess{iexp}{iexp}(1,icon)=inputs.IDOsol.tcon_guess{iexp}{iexp}(1,icon-1)+inputs.IDOsol.step_duration_guess{iexp}(1,icon);
            end
            inputs.IDOsol.tcon_guess{iexp}{iexp}(1,inputs.IDOsol.n_linear{iexp})=inputs.IDOsol.tf_guess{iexp};
            
           
        else %if isempty(inputs.IDOsol.t_con{iexp})
            
            for icon=2:inputs.IDOsol.n_linear{iexp}
                inputs.IDOsol.step_duration_guess{iexp}(icon-1)=inputs.IDOsol.t_con{iexp}(icon)-inputs.IDOsol.t_con{iexp}(icon-1);
            end
            inputs.IDOsol.tcon_guess{iexp}=inputs.IDOsol.t_con{iexp};
            
        end
        
        inputs.IDOsol.vdo_guess=[inputs.IDOsol.vdo_guess inputs.IDOsol.step_duration_guess{iexp}];
        inputs.IDOsol.vdo_min=[inputs.IDOsol.vdo_min inputs.IDOsol.step_duration_min{iexp}];
        inputs.IDOsol.vdo_max=[inputs.IDOsol.vdo_max inputs.IDOsol.step_duration_max{iexp}(1:inputs.IDOsol.n_linear{iexp}-1)];
        end
        
        
end

inputs.exps.t_con=inputs.IDOsol.tcon_guess;


 inputs.IDOsol.vdo_guess=[inputs.IDOsol.y0_guess inputs.IDOsol.par_guess inputs.IDOsol.vdo_guess];
 inputs.IDOsol.vdo_min=[inputs.IDOsol.y0_min inputs.IDOsol.par_min inputs.IDOsol.vdo_min];
 inputs.IDOsol.vdo_max=[inputs.IDOsol.y0_max inputs.IDOsol.par_max inputs.IDOsol.vdo_max];
 
 