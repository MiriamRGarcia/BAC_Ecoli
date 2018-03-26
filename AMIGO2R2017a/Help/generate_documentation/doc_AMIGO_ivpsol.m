%%
% <<logo_AMIGO2_small.png>>
%
% <html>
% <p style="color:#007946;font-size:18pt;text-align:right; margin-top: 1px; margin-bottom: 1px;"> <b>Initial value problem solvers</b></p>
% <hr align="left" width="820">
% </html>

%% AMIGO2 Numerical solvers for initial value problems and sensitivity calculations 
%
%
% AMIGO2 offers a suite of IVP solvers so as to handle different problems:
% non-stiff, stiff, sparse. Explicit and implicit Runge-Kutta, Adams and BDF methods 
% have been incorporated together with methods to compute sensitivities.
% 
% AMIGO2 can generate MATLAB models to be solved by MATLAB solvers (ode15s,
% ode45, ode113). 
%
% ENHANCED MODE OF OPERATION can generate FORTRAN or C models which are
% then interfaced  to state-of-the-art FORTRAN or C ODE solvers. This increases efficiency of 
% simulation and thus optimization.
% 
% The following table summarizes available methods:
%
% <html>
% <style type="text/css">
% .tftable {font-size:12px;width:100%%;border-width: 1px;border-color: #255DA5;border-collapse: collapse;}
% .tftable th {background-color:#8F91C7;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #255DA5;text-align:left;color:white;}
% .tftable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #255DA5;background-color:#E6FAE6;}
% .tftable tr:hover {background-color:#E6FAE6;}
% </style>
% <table class="tftable" border="1">
%   <tr>  <th>  </th>                               <th>Algorithm</th>  <th>Implementation</th>  <th>AMIGO model</th>   <th>Availability</th>    <th>Description</th>  </tr>
%   <tr>  <th rowspan="3">Non-Stiff models</th>     <td>RKF45</td>      <td>Fortran*</td>         <td>'charmodelF', 'fortranmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>Runge-Kutta-Fehlberg(4,5) method. Fehlberg, NASA tr r-315</td> </tr>
%   <tr>                                            <td>ode45</td>      <td>Matlab</td>          <td>'charmodelM','matlabmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>Runge-Kutta-Fehlberg(4,5) method. MATLAB implementation</td> </tr>
%   <tr>                                            <td>ode113</td>      <td>Matlab</td>          <td>'charmodelM','matlabmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>Adams-Bashforth-Moulton(1,12) method. Shampine & Reichelt, SIAM J.  Sci. Comp. 18-1, (1997). MATLAB implementation</td> </tr>
%   <tr>  <th rowspan="4">Stiff models</th>        <td>Radau5</td>      <td>Fortran*</td>         <td>'charmodelF', 'fortranmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>Implicit Runge-Kutta method.Hairer & Wanner, Springer Series Comp. Math 14, (1996)</td> </tr>
%   <tr>                                           <td>LSODA</td>      <td>Fortran*</td>         <td>'charmodelF', 'fortranmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>ADAMS with automatic switch to BDF, Hindmarsh, Sci. Comp. 55-64, (1983); Petzold, SIAM J. Sci. Stat. Comp. 4:136-148 (1983)</td> </tr>
%   <tr>                                            <td>ode15s</td>      <td>Matlab</td>         <td>'charmodelM','matlabmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>Klopfenstein-Shampine BDF. Shampine & Reichelt, SIAM J. Sci. Comp. 18-1, (1997), MATLAB implementation</td> </tr>
%   <tr>                                            <td>CVODES</td>      <td>C*</td>         <td>'charmodelC'</td>   <td>32bit Windows, 64bit Linux</td>    <td>     A. C. Hindmarsh et al. SUNDIALS: Suite of Nonlinear and Differential/Algebraic Equation Solvers, ACM Transactions on Mathematical Software, 31(3), pp. 363-396, 2005 </td></tr>
%   <tr>  <th >Sparse, Stiff models</th>        <td>LSODES</td>      <td>Fortran*</td>         <td>'charmodelF', 'fortranmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>ADAMS with automatic switch to BDF, Hindmarsh, Sci. Comp. 55-64, (1983); Eisenstadt et. at. Yale Sparse Matrix package I&II Int. J. Num. Meth. Eng., 18 (1982)</td> </tr>
% </table>
% </html>
% 
% *Link for system requirement for MEX-C and MEX-Fortran <missing missing>

%%% IVP solver settings
% The algorithms can be chosen by modifying the field
inputs.ivpsol.ivpsolver = 'cvodes';

%%
% For all IVP solver the *relative* and *absolute* tolerances can be
% adjusted by
inputs.ivpsol.atol = 1e-7;
inputs.ivpsol.rtol = 1e-5;



%% Sensitivity calculation
% AMIGO capable to compute the sensitivities of model states and outputs
% with respect to the parameters and initial conditions.
%
% Sensitivity calculations are used in
%
% * local and global ranking of the parameters
% * gradient based optimizations
% * the computation of confidence interals of the estimated parameters.
%
% The sensitivities are computed in either a finite difference based scheme
% or by direct computation solving the forward sensitivity equations
% corresponding to the ODEs.
%
% The following table summarizes the implemented methods for sensitivity
% calculations:
%
% <html>
% <style type="text/css">
% .tftable {font-size:12px;width:100%%;border-width: 1px;border-color: #255DA5;border-collapse: collapse;}
% .tftable th {background-color:#8F91C7;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #255DA5;text-align:left;color:white;}
% .tftable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #255DA5;background-color:#E6FAE6;}
% .tftable tr:hover {background-color:#E6FAE6;}
% </style>
% <table class="tftable" border="1">
%   <tr>  <th>  </th>                               <th>Algorithm</th>  <th>Implementation</th>  <th>AMIGO model</th>   <th>Availability</th>    <th>Description</th>  </tr>
%   <tr>  <th rowspan="3">Finite difference method</th>     <td>fdsens2</td>      <td>Matlab</td>         <td>'charmodelM','matlabmodel','sbmlmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>FD method using the IVP solver specified.</td> </tr>
%   <tr>                                            <td>fdsens5</td>      <td>Matlab</td>          <td>'charmodelM','matlabmodel','sbmlmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>FD method using the IVP solver specified and 5-points scheme.</td> </tr>
%   <tr>                                            <td>sensmat</td>      <td>Matlab</td>          <td>'charmodelM','matlabmodel','sbmlmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td> ode15s based FD method, modification of code by Garcia Mollá & Gómez Padilla (2002)</td> </tr>
%   <tr>  <th rowspan="4">Direct computation</th>        <td>CVODES</td>      <td>C*</td>         <td>'charmodelC'</td>   <td>32bit Windows, 64bit Linux</td>    <td> A. C. Hindmarsh et al. SUNDIALS: Suite of Nonlinear and Differential/Algebraic Equation Solvers, ACM Transactions on Mathematical Software, 31(3), pp. 363-396, 2005</td> </tr>
%   <tr>                                           <td>ODESSA</td>      <td>Fortran*</td>         <td>'charmodelF', 'fortranmodel'</td>   <td>32bit Windows, 64bit Linux</td>    <td>BDF, Leis & Kramer, Comp & Chem. Eng. 9:93-96 (1985)</td> </tr>
% </table>
% </html>
% 
% *Link for system requirement for MEX-C and MEX-Fortran <missing missing>
%
% The sensitivity solver can be chosen by modifying
inputs.ivpsol.senssolver = 'cvodes';

%% Enhancements
% The Jacobain of the dynamic equations are symbolically computed by
% setting
inputs.model.AMIGOjac = 1;

%%
% The symbolic computation of the forward sensitivity equations can be
% turned-on by
inputs.model.AMIGOsensrhs = 1;

%%
% Note that:
%
% * this options work only with _charmodelC_ AMIGO model type and with  _CVODES_ IVP solver.
% * the computations requires the MATLAB Symbolic Toolbox 
%



