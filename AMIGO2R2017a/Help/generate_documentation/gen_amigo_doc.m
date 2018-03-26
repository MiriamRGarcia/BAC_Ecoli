
function y = gen_amigo_doc(fname,dummy)

if(nargin<2)
    showCode=false;
else
    showCode=true;
end

y=1;

try
    
    cd ..; cd ..;
    AMIGO_Startup;
    rmpath(genpath(fullfile(pwd,'Examples')));
    cd([cd filesep 'Help' filesep 'generate_documentation']);
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_SModel', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_SObs', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_SData', opts);
    close all;
    %publish ('doc_AMIGO_FIM', opts);
    %close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_PE', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_LRank', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_GRank', opts);
    close all;
    publish ('doc_AMIGO_RIdent', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_ContourP', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_Input', opts);
    close all;
    publish ('doc_AMIGO_stimuli', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_Prep', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_nlpsol', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_exe_type', opts);
    close all;
%     opts.stylesheet='AMIGO_stylehtml.xsl';
%     publish ('doc_AMIGO_ivpsol', opts);  % This has become static
%     close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_fullC', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_fullMex', opts);
    close all;
    publish ('doc_AMIGO_costMex', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_FAQ', opts);
    close all
    publish ('doc_AMIGO_releaseNotes', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_troubleshooting', opts);
    close all;
    publish ('doc_AMIGO_openmp', opts);
    close all;
    publish ('doc_AMIGO_DO', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_DO_Reopt', opts);
    close all;
    publish ('doc_AMIGO_DO_const', opts);
    close all;
    publish ('doc_AMIGO_MultiObj_DO', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_MultiWSM_DO', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_fortran_inst', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_pecost', opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_pseudoData', opts);
    close all
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish ('doc_AMIGO_Reg', opts);
    close all;
    opts.showCode=true;
    opts.evalCode=false;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish('doc_AMIGO_c_inst',opts);
    close all;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish('doc_AMIGO_fortran_inst',opts);
    close all;
    opts.showCode=true;
    opts.evalCode=false;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish('model_4_ode15s',opts);
    close all;
    opts.showCode=true;
    opts.evalCode=false;
    opts.stylesheet='AMIGO_stylehtml.xsl';
    publish('doc_AMIGO',opts);
    close all;
    
    %% copy the published html and png results to the Help/htmls folder:
    movefile([pwd filesep 'html' filesep '*.*'] ,['..' filesep 'htmls' filesep])
    
    %% run the help-search: the content of these HTMLs are searchable in MATLAB Help.:
    AMIGO_path
    builddocsearchdb([amigodir.path,filesep,'Help',filesep,'htmls'])
    
catch e
    
    disp(e.message);
    
    switch computer
        
        case 'PCWIN'
            
        otherwise
            !yes | cp -r -f html/* /var/www/html/
            !chown apache:apache /var/www/html/*
            fprintf('Test failed!! \n');
            exit(3);
    end
    
end


switch computer
    
    case 'PCWIN'
        
    otherwise
        
        !yes | cp -r -f html/* /var/www/html/
        !chown apache:apache /var/www/html/*
        fprintf('Test Succeeded!! For more details check the report at: http://172.19.32.13/%s.html\n',fname);
        
end

y=0;

%exit;


