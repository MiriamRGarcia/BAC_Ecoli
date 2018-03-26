function ms=AMIGO_gen_obs_test(y,inputs,par,iexp)
	N0=y(:,1);
	B0=y(:,2);
	NN=y(:,3);
	BB=y(:,4);
	k=par(1);
	x=par(2);
	n=par(3);
	a=par(4);
	b=par(5);
 

switch iexp

case 1
logN=(log10(NN));ind=find(log10(NN)<2);logN(ind)=2*ones(size(ind));;
BAC=BB                                                             ;
ms(:,1)=logN;ms(:,2)=BAC ;
end

return