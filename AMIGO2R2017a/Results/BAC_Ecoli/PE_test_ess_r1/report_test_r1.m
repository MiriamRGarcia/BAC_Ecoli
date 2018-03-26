   ***********************************
   *    AMIGO2, Copyright @CSIC      *
   *    AMIGO2_R2017a [March 2017]    *
   *********************************** 

Date: 26-Mar-2018
Problem folder:	 Results/BAC_Ecoli
Results folder in problem folder:	 Results/BAC_Ecoli/PE_test_ess_r1 


-------------------------------
Optimisation related active settings
-------------------------------


------> Global Optimizer: Enhanced SCATTER SEARCH for parameter estimation

		>Summary of selected eSS options: 
ess_options.
	dim_refset:	'auto'
	inter_save:	0
	iterprint:	1
	local:	(1x1 struct)
	log_var:	[]
	maxeval:	10000000000
	maxtime:	1
	ndiverse:	'auto'

		  default options are used. 


		>Bounds on the unknowns:

		v_guess(1)=3.757870;  v_min(1)=1.000000; v_max(1)=5.000000;
		v_guess(2)=1.250360;  v_min(2)=1.000000; v_max(2)=3.000000;
		v_guess(3)=1.696380;  v_min(3)=1.000000; v_max(3)=3.000000;
		v_guess(4)=1.176310;  v_min(4)=0.000000; v_max(4)=3.000000;
		v_guess(5)=0.833426;  v_min(5)=0.000000; v_max(5)=2.000000;



-----------------------------------------------
 Initial value problem related active settings
-----------------------------------------------
ivpsolver: cvodes
RelTol: 1e-05
AbsTol: 1e-07
MaxStepSize: Inf
MaxNumberOfSteps: 1e+06


---------------------------------------------------
Local sensitivity problem related active settings
---------------------------------------------------
senssolver: cvodes
ivp_RelTol: 1e-05
ivp_AbsTol: 1e-07
sensmex: cvodesg_test
MaxStepSize: Inf
MaxNumberOfSteps: 1e+06


-------------------------------
   Model related information
-------------------------------

--> Number of states: 4


--> Number of model parameters: 5

--> Vector of parameters (nominal values):

	par0=[   3.75787     1.25036     1.69638     1.17631     0.83343  ]


-------------------------------------------
  Experimental scheme related information
-------------------------------------------


-->Number of experiments: 5


-->Initial conditions for each experiment:
		Experiment 1: 
			exp_y0=[5.044e+08  9.438e+01  5.044e+08  9.438e+01  ]
		Experiment 2: 
			exp_y0=[5.966e+06  9.741e+01  5.966e+06  9.741e+01  ]
		Experiment 3: 
			exp_y0=[4.594e+08  2.084e+02  4.594e+08  2.084e+02  ]
		Experiment 4: 
			exp_y0=[3.008e+06  2.036e+02  3.008e+06  2.036e+02  ]
		Experiment 5: 
			exp_y0=[1.444e+09  3.220e+02  1.444e+09  3.220e+02  ]

-->Final process time for each experiment: 
		Experiment 1: 	 20.000000

-->Final process time for each experiment: 
		Experiment 2: 	 20.000000

-->Final process time for each experiment: 
		Experiment 3: 	 10.000000

-->Final process time for each experiment: 
		Experiment 4: 	 10.000000

-->Final process time for each experiment: 
		Experiment 5: 	 10.000000


-->Sampling times for each experiment: 
		Experiment 1: 	 		Experiment 110: 	 		Experiment 95: 	 		Experiment 115: 	 		Experiment 58: 	 		Experiment 32: 	 		Experiment 37: 	 		Experiment 105: 	 		Experiment 32: 	 		Experiment 92: 	 		Experiment 116: 	 		Experiment 6: 	 0.000e+00  1.000e+00  5.000e+00  1.000e+01  1.500e+01  2.000e+01  

-->Sampling times for each experiment: 
		Experiment 2: 	 		Experiment 110: 	 		Experiment 95: 	 		Experiment 115: 	 		Experiment 58: 	 		Experiment 32: 	 		Experiment 37: 	 		Experiment 105: 	 		Experiment 32: 	 		Experiment 92: 	 		Experiment 116: 	 		Experiment 6: 	 0.000e+00  1.000e+00  5.000e+00  1.000e+01  1.500e+01  2.000e+01  

-->Sampling times for each experiment: 
		Experiment 3: 	 		Experiment 110: 	 		Experiment 95: 	 		Experiment 115: 	 		Experiment 58: 	 		Experiment 32: 	 		Experiment 37: 	 		Experiment 105: 	 		Experiment 32: 	 		Experiment 92: 	 		Experiment 116: 	 		Experiment 4: 	 0.000e+00  1.000e+00  5.000e+00  1.000e+01  

-->Sampling times for each experiment: 
		Experiment 4: 	 		Experiment 110: 	 		Experiment 95: 	 		Experiment 115: 	 		Experiment 58: 	 		Experiment 32: 	 		Experiment 37: 	 		Experiment 105: 	 		Experiment 32: 	 		Experiment 92: 	 		Experiment 116: 	 		Experiment 6: 	 0.000e+00  5.000e-01  1.000e+00  2.000e+00  5.000e+00  1.000e+01  

-->Sampling times for each experiment: 
		Experiment 5: 	 		Experiment 110: 	 		Experiment 95: 	 		Experiment 115: 	 		Experiment 58: 	 		Experiment 32: 	 		Experiment 37: 	 		Experiment 105: 	 		Experiment 32: 	 		Experiment 92: 	 		Experiment 116: 	 		Experiment 5: 	 0.000e+00  1.000e+00  2.000e+00  5.000e+00  1.000e+01  

--> There is no manipulable (control, stimulus, input) variable, inputs.model.n_stimulus=0


-->Number of observables:
	Experiment 1: 2
	Experiment 2: 2
	Experiment 3: 2
	Experiment 4: 2
	Experiment 5: 2

-->Observables:
		Experiment 1:
			logN=(log10(NN));ind=find(log10(NN)<2);logN(ind)=2*ones(size(ind));
			BAC=BB                                                             
		Experiment 2:
			logN=(log10(NN));ind=find(log10(NN)<2);logN(ind)=2*ones(size(ind));
			BAC=BB                                                             
		Experiment 3:
			logN=(log10(NN));ind=find(log10(NN)<2);logN(ind)=2*ones(size(ind));
			BAC=BB                                                             
		Experiment 4:
			logN=(log10(NN));ind=find(log10(NN)<2);logN(ind)=2*ones(size(ind));
			BAC=BB                                                             
		Experiment 5:
			logN=(log10(NN));ind=find(log10(NN)<2);logN(ind)=2*ones(size(ind));
			BAC=BB                                                             

-->Number of sampling times for each experiment:
		Experiment 1: 	 6
		Experiment 2: 	 6
		Experiment 3: 	 4
		Experiment 4: 	 6
		Experiment 5: 	 5

-->Sampling times for each experiment:
		Experiment 1, 
			t_s=[   0.000     1.000     5.000    10.000    15.000    20.000  ]
		Experiment 2, 
			t_s=[   0.000     1.000     5.000    10.000    15.000    20.000  ]
		Experiment 3, 
			t_s=[   0.000     1.000     5.000    10.000  ]
		Experiment 4, 
			t_s=[   0.000     0.500     1.000     2.000     5.000    10.000  ]
		Experiment 5, 
			t_s=[   0.000     1.000     2.000     5.000    10.000  ]


--------------------------------------------------------------------------

-->Experimental data for each experiment:
		
Experiment 1: 
		inputs.exp_data{1}=[
		8.70277  94.38
		7.9514  9.05
		6.17759  12.32
		5.20577  11.73
		3.99855  10.54
		4.30761  11.43
		];

		
Experiment 2: 
		inputs.exp_data{2}=[
		6.77571  97.41
		4.76644  41.29
		3.63711  43.98
		2.69081  46.4
		2.20069  49.25
		2  48.03
		];

		
Experiment 3: 
		inputs.exp_data{3}=[
		8.66221  208.39
		6.57665  41.63
		2.25  34.34
		2.11928  41.25
		];

		
Experiment 4: 
		inputs.exp_data{4}=[
		6.47827  203.635
		3.19817  137.69
		2.40038  133.32
		2  128.43
		2  129.26
		2  128.315
		];

		
Experiment 5: 
		inputs.exp_data{5}=[
		9.15953  321.99
		4.91602  69.49
		5.40504  58.96
		4.44912  49.61
		2  26.21
		];


-->Noise type:homo_var

		Error data 1: 
		inputs.exps.error_data{1}=[
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		];


		Error data 2: 
		inputs.exps.error_data{2}=[
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		];


		Error data 3: 
		inputs.exps.error_data{3}=[
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		];


		Error data 4: 
		inputs.exps.error_data{4}=[
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		];


		Error data 5: 
		inputs.exps.error_data{5}=[
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		0.208621  5.10833
		];



-------------------------------------------------------------------------------------------
>>>>    Mean / Maximum value of the residuals in percentage (100*(data-model)/data):

		Experiment 1 : 
		 Observable 1 --> mean error: 6.096678 %	 max error: 21.162785 %
		 Observable 2 --> mean error: 12.770047 %	 max error: 58.066966 %

		Experiment 2 : 
		 Observable 1 --> mean error: 10.391944 %	 max error: 25.760708 %
		 Observable 2 --> mean error: 12.802975 %	 max error: 28.432797 %

		Experiment 3 : 
		 Observable 1 --> mean error: 15.091921 %	 max error: 39.461563 %
		 Observable 2 --> mean error: 15.952621 %	 max error: 36.788519 %

		Experiment 4 : 
		 Observable 1 --> mean error: 8.474871 %	 max error: 26.087479 %
		 Observable 2 --> mean error: 2.564385 %	 max error: 7.430433 %

		Experiment 5 : 
		 Observable 1 --> mean error: 11.496103 %	 max error: 27.203153 %
		 Observable 2 --> mean error: 27.793496 %	 max error: 73.904526 %

--------------------------------------------------------------------------

--------------------------------------------------------------------
>>>>  Maximum absolute value of the residuals (data-model):

		Experiment 1 : 
		 Observable 1 -->  max residual: 0.846203 max data: 8.702773
		 Observable 2 -->  max residual: 5.255060 max data: 94.380000

		Experiment 2 : 
		 Observable 1 -->  max residual: 0.936944 max data: 6.775711
		 Observable 2 -->  max residual: 11.739902 max data: 97.410000

		Experiment 3 : 
		 Observable 1 -->  max residual: 1.004766 max data: 8.662212
		 Observable 2 -->  max residual: 12.633177 max data: 208.390000

		Experiment 4 : 
		 Observable 1 -->  max residual: 0.791922 max data: 6.478274
		 Observable 2 -->  max residual: 10.230964 max data: 203.635000

		Experiment 5 : 
		 Observable 1 -->  max residual: 1.210302 max data: 9.159535
		 Observable 2 -->  max residual: 23.811136 max data: 321.990000

--------------------------------------------------------------------------	   

>>>> Best objective function: 253.973586 
	   

>>>> Computational cost: 13.220000 s
> 99.76% of successful simulationn
> 100.00% of successful sensitivity calculations


>>> Best values found and the corresponding asymptotic confidence intervals



>>> Estimated global parameters: 

	k : 3.4470e+00  +-  1.7511e-01 (    5.08%); 
	x : 1.2349e+00  +-  1.9192e-01 (    15.5%); 
	n : 1.5559e+00  +-  2.8956e-01 (    18.6%); 
	a : 1.0292e+00  +-  6.0502e-02 (    5.88%); 
	b : 8.5524e-01  +-  9.4132e-03 (     1.1%); 


>>> Correlation matrix for the global unknowns:

	 1.000000e+00	 2.199164e-01	 -6.759205e-01	 -1.790934e-01	 1.743740e-01
	 2.199164e-01	 1.000000e+00	 -8.305000e-01	 -1.853700e-02	 3.500573e-02
	 -6.759205e-01	 -8.305000e-01	 1.000000e+00	 -7.436419e-02	 6.389575e-02
	 -1.790934e-01	 -1.853700e-02	 -7.436419e-02	 1.000000e+00	 -9.940996e-01
	 1.743740e-01	 3.500573e-02	 6.389575e-02	 -9.940996e-01	 1.000000e+00
