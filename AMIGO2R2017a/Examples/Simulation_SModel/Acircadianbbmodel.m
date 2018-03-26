% $Header: svn://.../trunk/AMIGO2R2016/Examples/Arabidopsis_circadian/circadianbbmodel.m 2482 2016-02-11 14:36:32Z evabalsa $
function [yteor,iflag]=Acircadianbbmodel(t0,tf,ts,y_0,par,u,pend,tu,iexp)
           
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
                  [t,yout] = ode15s(@Acircadian_odes,[tin tout],y_0,options,flag,par',u(:,i_con),pend(:,i_con),t_old);
        
                  % Keep values to next integration step
                  y_0=yout(size(t,1),:);
                 
                % If t out= t measurement, keep information 
                  if tout==ts(i_int) 
                  yteor(i_int,:)=yout(size(t,1),:);
                  i_int=i_int+1;
                  end 
                % If t out= t control, update control value
                %    [tout  inputs.exps.t_con{iexp}(i_con)]
                              
                 if (size(u,2)>1)               
                 if (tout>=tu(i_con+1)) & ((i_con+1)<size(u,2)+1)
                 i_con=i_con+1;
                 end 
                 end
                 t_old=tu(i_con); 
            end % END INTEGRATION LOOP
            iflag=1;

return