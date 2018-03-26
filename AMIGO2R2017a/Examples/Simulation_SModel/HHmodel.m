% $Header: svn://.../trunk/AMIGO2R2016/Examples/Hodgkin-Huxley_model/HHmodel.m 770 2013-08-06 09:41:45Z attila $
 function ydot= HHmodel(t,y,flag,par,v,pend,told) 
%IMPORTANT: > Arguments should be t,y,flag,par,v,pend,told
%           > Inputs or stimuli should be defined as:
%              u(iu)=v(iu)+(t-told)*pend(iu); iu=1:inputs.model.n_stimulus
%           > Assignments such as yv=y(1); gNa=par(1); TotalI=u(1) and  
%             ydot=[dyv;dyn;dym;dyh]; are required}
 u(1)=v(1)+(t-told)*pend(1);

 yv=y(1);
 yn=y(2);
 ym=y(3);
 yh=y(4);
 
 gNa=par(1);
 gK=par(2);
 gL=par(3);
 VNa=par(4);
 VK=par(5);
 VL=par(6);
 Cm=par(7);


 TotalI=u(1);

 An=0.01*((10-yv)/(exp((10-yv)*0.1)-1));
 Bn=0.125*exp(-yv/80);
 Am=0.1*((25-yv)/(exp((25-yv)*0.1)-1));
 Bm=4*exp(-yv/18);
 Ah=0.07*exp(-yv/20);
 Bh=1/(1+exp((30-yv)*0.1));

 dyv=-(gNa*ym^3*yh*(yv-VNa)+ gK*yn^4*(yv-VK)+gL*(yv-VL)- TotalI ) / Cm;  
 dyn= An*(1-yn)-Bn*yn;  
 dym= Am*(1-ym)-Bm*ym;      
 dyh= Ah*(1-yh)-Bh*yh';
 
 

 ydot=[dyv;dyn;dym;dyh];

 return