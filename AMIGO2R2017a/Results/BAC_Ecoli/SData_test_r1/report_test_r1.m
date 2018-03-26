   ***********************************
   *    AMIGO2, Copyright @CSIC      *
   *    AMIGO2_R2017a [March 2017]    *
   *********************************** 

Date: 26-Mar-2018
Problem folder:	 Results/BAC_Ecoli
Results folder in problem folder:	 Results/BAC_Ecoli/SData_test_r1 


-----------------------------------------------
 Initial value problem related active settings
-----------------------------------------------
ivpsolver: cvodes
RelTol: 1e-05
AbsTol: 1e-07
MaxStepSize: Inf
MaxNumberOfSteps: 1e+06


-------------------------------
   Model related information
-------------------------------

--> Number of states: 4


--> Number of model parameters: 5

--> Vector of parameters (nominal values):

	par0=[   3.44697     1.23488     1.55590     1.02918     0.85524  ]


-------------------------------------------
  Experimental scheme related information
-------------------------------------------


-->Number of experiments: 1


-->Initial conditions for each experiment:
		Experiment 1: 
			exp_y0=[1.444e+09  3.220e+02  1.444e+09  3.220e+02  ]

-->Final process time for each experiment: 
		Experiment 1: 	 10.000000


-->Sampling times for each experiment: 
		Experiment 1: 	 		Experiment 110: 	 		Experiment 95: 	 		Experiment 115: 	 		Experiment 58: 	 		Experiment 32: 	 		Experiment 37: 	 		Experiment 105: 	 		Experiment 32: 	 		Experiment 92: 	 		Experiment 116: 	 		Experiment 5: 	 0.000e+00  1.000e+00  2.000e+00  5.000e+00  1.000e+01  

--> There is no manipulable (control, stimulus, input) variable, inputs.model.n_stimulus=0


-->Number of observables:
	Experiment 1: 2

-->Observables:
		Experiment 1:
			logN=(log10(NN));ind=find(log10(NN)<2);logN(ind)=2*ones(size(ind));
			BAC=BB                                                             

-->Number of sampling times for each experiment:
		Experiment 1: 	 5

-->Sampling times for each experiment:
		Experiment 1, 
			t_s=[   0.000     1.000     2.000     5.000    10.000  ]


--------------------------------------------------------------------------

-->Experimental data for each experiment:
		
Experiment 1: 
		inputs.exp_data{1}=[
		9.15953  321.99
		4.91602  69.49
		5.40504  58.96
		4.44912  49.61
		2  26.21
		];


-->Noise type:homo_var

		Error data 1: 
		inputs.exps.error_data{1}=[
		0.167688  5.10833
		0.167688  5.10833
		0.167688  5.10833
		0.167688  5.10833
		0.167688  5.10833
		];

