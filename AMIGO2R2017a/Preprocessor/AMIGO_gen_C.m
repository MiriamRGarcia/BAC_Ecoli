% $Header: svn://.../trunk/AMIGO2R2016/Preprocessor/AMIGO_gen_C.m 2049 2015-08-24 12:55:24Z attila $

% AMIGO_gen_C: Generates necessary C files for the model 'char'
%
%******************************************************************************
% AMIGO2: dynamic modeling, optimization and control of biological systems    % 
% AMIGO_gen_C                                                                 %
% Code development:     David Henriques                                       %
% Address:              Process Engineering Group, IIM-CSIC                   %
%                       C/Eduardo Cabello 6, 36208, Vigo-Spain                %
% e-mail:               ebalsa@iim.csic.es                                    %
% Copyright:            CSIC, Spanish National Research Council               %
%******************************************************************************
%
%*****************************************************************************%
%                                                                             %
%  AMIGO_gen_C: Generates necessary C files for the model type    %
%                     'char'                                                  %
%                                                                             %
%                                                                             %
%                                                                             %
%                                                                             %
%*****************************************************************************%

        
fid=fopen(inputs.model.odes_file,'w+');

if(isfield(inputs.model,'eqns_c') && ~isempty(inputs.model.eqns_c))
    inputs.model.eqns=inputs.model.eqns_c;
end

disp('------> Generating C code ...');

fprintf(fid,'#include <amigoRHS.h>\n\n');
fprintf(fid, '#include <math.h>\n\n');
fprintf(fid,'#include <amigoJAC.h>\n\n');
fprintf(fid,'#include <amigoSensRHS.h>\n\n');

if strcmpi(inputs.model.exe_type,'standard')
    fprintf(fid,'#include <amigo_terminate.h>\n\n');
end
if(~isempty(inputs.model.cvodes_include))
    for i=1:length(inputs.model.cvodes_include)
        fprintf(fid,'%s',regexprep(inputs.model.cvodes_include{i},'\\','\\'));
    end
end


% state definition
fprintf(fid,'\n\t/* *** Definition of the states *** */\n\n');
if(numel(inputs.model.st_names)>0)
    for i=0:inputs.model.n_st-1
        fprintf(fid,'#define\t%s Ith(y,%d)\n',inputs.model.st_names(i+1,:),i);
    end
end


fprintf(fid,'#define iexp amigo_model->exp_num\n');

% state derivative definition
fprintf(fid,'\n\t/* *** Definition of the sates derivative *** */\n\n');
if(numel(inputs.model.st_names)>0)
    for i=0:inputs.model.n_st-1
        %str=[str sprintf('\tdouble\td%s;\n',inputs.model.st_names(i+1,:))];
        fprintf(fid,'#define\td%s Ith(ydot,%d)\n',inputs.model.st_names(i+1,:),i);
    end
end

%paramters definition
fprintf(fid,'\n\t/* *** Definition of the parameters *** */\n\n');
if(numel(inputs.model.par_names)>0)
    for i=0:inputs.model.n_par-1
        fprintf(fid,'#define\t%s (*amigo_model).pars[%d]\n',inputs.model.par_names(i+1,:),i);
    end;
end

% stimuli declaration
for i=1:inputs.model.n_stimulus
    fprintf(fid,...
        '#define %s\t((*amigo_model).controls_v[%u][(*amigo_model).index_t_stim]+(t-(*amigo_model).tlast)*(*amigo_model).slope[%u][(*amigo_model).index_t_stim])\n',...
        inputs.model.stimulus_names(i,:),i-1,i-1);
end



% generate the systems: (amigoRHS)
AMIGO_gen_C_rhs(inputs,fid);
%fprintf(fid,str);

% generate the jacobian: (amigoJAC)
AMIGO_gen_C_jacobian(inputs,fid);
%fprintf(fid,str);

% sensitivity state  definition
if isfield(inputs.model, 'AMIGOsensrhs') && isfield(inputs.model, 'sens') % && (size(inputs.model.sens.rhs,1)>0)
    fprintf(fid,'\n\t/* *** Definition of the sensitivity states *** */\n\n');
    if(numel(inputs.model.st_names)>0)
        for i=0:inputs.model.n_st-1
            %fprintf(fid,'\tdouble\ts%d=Ith(yS,%d);\n',i+1,i);
            fprintf(fid,'#define\ts%d Ith(yS,%d)\n',i+1,i);
        end
    end
end

% generate the exact right hand side (amigoSensRHS)
%warning('AMIGO:sensRHS','gen_C_sensrhs2')
% tic
AMIGO_gen_C_sensrhs(inputs,fid);
% fprintf('\t Time spent in exporting the sensitivity equations to C code:\n');
% toc

if(strcmp(inputs.model.exe_type,'costMex') || strcmp(inputs.model.exe_type,'fullMex')  || strcmp(inputs.model.exe_type,'fullC'))
     
    AMIGO_gen_costMex_obs(inputs,fid)
    AMIGO_gen_costMex_sens_obs(inputs,fid);
    
    fprintf(fid,sprintf('\n\n\nvoid amigo_Y_at_tcon(void* data,realtype t, N_Vector y){\n'));
    fprintf(fid,'\tAMIGO_model* amigo_model=(AMIGO_model*)data;\n\n');

    fprintf(fid,'\n}\n');

    
end

fclose(fid);