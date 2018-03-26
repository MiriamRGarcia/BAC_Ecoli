#include <amigoRHS.h>

#include <math.h>

#include <amigoJAC.h>

#include <amigoSensRHS.h>

#include <amigo_terminate.h>


	/* *** Definition of the states *** */

#define	N0 Ith(y,0)
#define	B0 Ith(y,1)
#define	NN Ith(y,2)
#define	BB Ith(y,3)
#define iexp amigo_model->exp_num

	/* *** Definition of the sates derivative *** */

#define	dN0 Ith(ydot,0)
#define	dB0 Ith(ydot,1)
#define	dNN Ith(ydot,2)
#define	dBB Ith(ydot,3)

	/* *** Definition of the parameters *** */

#define	k (*amigo_model).pars[0]
#define	x (*amigo_model).pars[1]
#define	n (*amigo_model).pars[2]
#define	a (*amigo_model).pars[3]
#define	b (*amigo_model).pars[4]
/* Right hand side of the system (f(t,x,p))*/
int amigoRHS(realtype t, N_Vector y, N_Vector ydot, void *data){
	AMIGO_model* amigo_model=(AMIGO_model*)data;
	ctrlcCheckPoint(__FILE__, __LINE__);


	/* *** Definition of the algebraic variables *** */

	double	alpha;

	/* *** Equations *** */

	dN0=0;
	dB0=0;
	alpha=pow(B0/N0,b)/pow(10,a);
	dNN=-pow(10,-k)*pow(NN,x)*pow(BB,n);
	dBB=+alpha*dNN;

	return(0);

}


/* Jacobian of the system (dfdx)*/
int amigoJAC(long int N, realtype t, N_Vector y, N_Vector fy, DlsMat J, void *user_data, N_Vector tmp1, N_Vector tmp2, N_Vector tmp3){
	AMIGO_model* amigo_model=(AMIGO_model*)user_data;
	ctrlcCheckPoint(__FILE__, __LINE__);


	return(0);
}

/* R.H.S of the sensitivity dsi/dt = (df/dx)*si + df/dp_i */
int amigoSensRHS(int Ns, realtype t, N_Vector y, N_Vector ydot, int iS, N_Vector yS, N_Vector ySdot, void *data, N_Vector tmp1, N_Vector tmp2){
	AMIGO_model* amigo_model=(AMIGO_model*)data;

	return(0);

}