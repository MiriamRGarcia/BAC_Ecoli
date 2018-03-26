%%
% <html>
% <p style="color:#007946;font-size:18pt;text-align:right; margin-top: 1px; margin-bottom: 1px;"> <b>Enhanced mode with FORTRAN</b></p>
% <hr align="left" width="820">
% </html>


%%
% <html>
% <div style="background-color: #E6FAE6; margin-left: 1px; margin-right: 5px; padding-bottom: 1px; padding-left: 8px; padding-right: 8px; padding-top: 2px; line-height: 1.25">
% <p>Enhanced mode with FORTRAN generates the model in FORTRAN ('charmodelF')
% -if not provided by the user 'fortranmodel'. The model is then linked to a
% FORTRAN IVP solver selected by the user (radau5 and odessa, by default).</p> 
% <p>FORTRAN usage is compatible with 
% MATLAB 32-bits for Windows or MATLAB 64-bits or 32-bits for LINUX.</p>
% </div>
% </html>
%% Install charmodelF features in Windows & MATLAB 32-bits

%%
% In order to compile FORTRAN models we use g95 which is shipped with
% AMIGO. You do not need to perform any additional
% installation steps to run Fortran models in 32-bit Matlab installation
% under windows.

%% Install charmodelF features in Linux

%%
% In order to compile FORTRAN models we use g95. Thus you will need to
% install g95. You can get it from http://www.g95.org/downloads.shtml. If you need to build from source, visit http://www.g95.org/source.shtml

%%
% From the Matlab console or the Linux shell try to compile the hello.f
% file located under the tests folder:


switch computer
    
    case {'GLNXA64','GLNX86'}
        
        AMIGO_Startup;
        AMIGO_path;
        cd(fullfile(amigodir.path,'tests'))
        
        !g95 hello.f -o hello
        !./hello
end

%%
% If everything is working as expected you should see:

%%
% Hello World




