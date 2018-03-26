# Ecoli_inactivation_BAC

1. Open matlab and go to the folder Ecoli_inactivation_BAC
2. Run BAC_Ecoli_main
    2.1-If it does not work, you probably need to configurate matlab to use c++. See https://sites.google.com/site/amigo2toolbox/download for details
    2.2-Alternatively, 
    
        - change in file BAC_Ecoli_model.m (inputs folder in AMIGO2R2017a) line 21 
           inputs.model.input_model_type='charmodelC'; by inputs.model.input_model_type='charmodelM';
        - increase optimization time line 85 (inputs.nlpsol.eSS.maxtime) substantially to achieve the optimum.
        
