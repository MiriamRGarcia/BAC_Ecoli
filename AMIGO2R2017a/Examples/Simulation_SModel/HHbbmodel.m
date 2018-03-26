
function [yteor,iflag] = HHbbmodel(t0,tf,ts,y_0,par,u,pend,tu,iexp)
%	INPUT Arguments should be t0,tf,ts,y_0,par,u,pend,tu
%           t0: initial time for integration
%           tf: final time for integration
%           ts: vector of sampling times
%           y0: vector of initial conditions
%           par: vector of parameter values
%           u: vector of control values
%           pend: vector of slope values used for control linear interpolation
%           tu: vector of control switching times
%           These will be automatically introduced by AMIGO for each experiment
%  OUTPUT Arguments: yteor and iflag
%           yteor: matrix of [number of sampling times x number of states] with 
%                  the values of all states at sampling times
%           iflag: negative if an integration error occurred
%
%
%           This example solves the HH model by means of ode15s. 
%           REMARK: user may call any software from here provided it is compatible
%           with MATLAB (for example a PDE solver, DDE solvers, etc. }
options = odeset('RelTol',1e-7,'AbsTol',1e-7);

vtout=union(ts,tu);
if vtout(1)==t0
   yteor(1,:)=y_0;
   i_int=2;
else
   i_int=1;
end
   i_con=1;

% INTEGRATION LOOP 
   t_old=tu(1);
   for i_out=1:size(vtout,2)-1  
       tin=vtout(i_out);
       tout=vtout(i_out+1);               
       [t,yout] = ode15s('HHmodel',[tin tout],y_0,options,par',u(:,i_con),pend(:,i_con),t_old);
       y_0=yout(size(t,1),:);
                 
          % If t out= t measurement, keep information 
               if tout==ts(i_int) 
               yteor(i_int,:)=yout(size(t,1),:);
               i_int=i_int+1;
               end 
          % If t out= t control, update control value
                               
               if (size(u,2)>1)               
               if (tout>=tu(i_con+1)) & ((i_con+1)<size(u,2)+1)
               i_con=i_con+1;
               end 
               end
               t_old=tu(i_con); 
   end % END INTEGRATION LOOP
   iflag=1;

return