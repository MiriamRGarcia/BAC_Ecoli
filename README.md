# Ecoli_inactivation_BAC



Here we provide the scripts with the model used to optimize the disinfectant dose in [1]. 
The model explains and predicts the interplay between disinfectant and pathogen at 
different initial microbial densities (inocula) and dose concentrations. 
The study focuses on the disinfection of Escherichia coli with benzalkonium chloride, 
the most common quaternary ammonium compound.
Note that there is an erratum in the paper, not in the code, and Equation 6 should read:
dNN=-10^(-k)*NN^x*BB^n


In order to run these scripts, users will need:

- a Matlab R2015 (or later) installation, under Windows or Linux operating systems
- the AMIGO2 toolbox available at: https://sites.google.com/site/amigo2toolbox/download


Users need to make sure that the above AMIGO2 toolbox is fully functional before attempting to run the scripts. 
Please refer to the AMIGO2 documentation.


INSTRUCTIONS
1. Open matlab and go to the folder where the file BAC_Ecoli_main is
2. Run BAC_Ecoli_main and add the AMIGO path when asked

    2.1-If it does not work, you probably need to configurate AMIGO2 in matlab to use c++. See https://sites.google.com/site/amigo2toolbox for details
    
    2.2-Alternatively, 
        - change in file BAC_Ecoli_model.m (inputs folder in AMIGO2R2017a) line 21 
           inputs.model.input_model_type='charmodelC'; by inputs.model.input_model_type='charmodelM';
    2.3-To assure the optimum is achieved, increase optimization time in line 85 (inputs.nlpsol.eSS.maxtime).
        

        
[1] Míriam R. García and Marta L. Cabo. (2018) "Optimization of E. coli inactivation by benzalkonium chloride 
reveals the importance of quantifying the inoculum effect on chemical disinfection" 
Frontiers in Microbiology 9: 1259. doi:10.3389/fmicb.2018.01259.
