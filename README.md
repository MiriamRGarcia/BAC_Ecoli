# Ecoli_inactivation_BAC



Here we provide the scripts necessary to reproduce the case studies considered in [1].
In order to run these scripts, users will need:

- a Matlab R2015 (or later) installation, under Windows or Linux operating systems
- the AMIGO2 toolbox with the IOC add-on, available at:
  https://sites.google.com/site/amigo2toolbox/download


Users need to make sure that the above AMIGO2 toolbox is fully functional before attempting to run the scripts. Please refer to the AMIGO2 documentation.


INSTRUCTIONS
1. Open matlab and go to the folder Ecoli_inactivation_BAC
2. Run BAC_Ecoli_main

    2.1-If it does not work, you probably need to configurate AMIGO2 in matlab to use c++. See https://sites.google.com/site/amigo2toolbox for details
    
    2.2-Alternatively, 
        - change in file BAC_Ecoli_model.m (inputs folder in AMIGO2R2017a) line 21 
           inputs.model.input_model_type='charmodelC'; by inputs.model.input_model_type='charmodelM';
        - increase optimization time line 85 (inputs.nlpsol.eSS.maxtime) substantially to achieve the optimum.
        

        
[1] Míriam R. García* and Marta L. Cabo. (2018) Optimization of E. coli inactivation by benzalkonium chloride reveals the importance of quantifying the inoculum effect on chemical disinfection Frontiers in Microbiology 9: 1259. doi:10.3389/fmicb.2018.01259.
