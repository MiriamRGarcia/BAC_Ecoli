% Bray 1993 chemotaxis model  for parameter estimation.
% Biomodels Database BioMDB404; some changes were implemented in order to 
%   handle the input

%======================
% PATHS RELATED DATA
%======================
inputs.pathd.results_folder = 'Bray1993';           % Folder to keep results  
inputs.pathd.short_name     = 'bray_chemo';       % To identify figures and reports for a given problem   
inputs.pathd.runident='';

%====================================
% ANALYTICAL COMPUTATION RELATED DATA
%====================================
inputs.model.AMIGOsensrhs = 1;      % compute the right hand side of the sensitivity eqs analytically
inputs.exps.NLObs = 1;           % compute the Jacobian of the nonlinear observation function. 

%========================
% SIMULATION RELATED DATA
%========================
inputs.ivpsol.ivpsolver='cvodes';                     % IVP solver
inputs.ivpsol.senssolver='cvodes';                    % Sensitivities solver
inputs.ivpsol.rtol=1.0e-6;                            % IVP solver integration tolerances
inputs.ivpsol.atol=1.0e-13;

%======================
% MODEL RELATED DATA
%======================
inputs.model.input_model_type = 'charmodelC';           
inputs.model.n_st       = 26;                          % Number of states      
inputs.model.n_par      = 60;                          % Number of model parameters 
inputs.model.n_stimulus = 1;                           % Number of inputs, stimuli or control variables

inputs.model.stimulus_names=char('asp');    % asparmate pulse parameter

inputs.model.st_names   = char('x2','x3','x4','x5','x6','x7','x8','x9','x10',...
    'x11','x12','x13','x14','x15','x16','x17','x18','x19','x20',...
    'x21','x22','x23','x24','x25','x26','x27');
inputs.model.par_names  = char(...
    'reaction_phosphorylation_r1_kcat',... =0.0010; # Reaction: id = phosphorylation_r1, name = A->Ap
    'reaction_phosphorylation_r2_kcat',... =75000.0; # Reaction: id = phosphorylation_r2, name = TWA+A->TWA+Ap
    'reaction_phosphorylation_r3_kcat',... =200000.0; # Reaction: id = phosphorylation_r3, name = Tni_WA+A->Tni_WA+Ap
    'reaction_phosphorylation_r4_k1',...=1.0E8;  # Reaction: id = phosphorylation_r4, name = Tasp_WA+Yp->Tasp_WA+Y
    'reaction_phosphorylation_r5_k1',... =200000.0; # Reaction: id = phosphorylation_r5, name = Ap+Y->A+Yp
    'reaction_phosphorylation_r6_kcat',... =0.0; # Reaction: id = phosphorylation_r6, name = Y ->Yp
    'reaction_phosphorylation_r7_k1',... =0.037; # Reaction: id = phosphorylation_r7, name = Yp->Y
    'reaction_phosphorylation_r8_k1',... =500000.0; # Reaction: id = phosphorylation_r8, name = Yp+Z->Y+Z
    'reaction_phosphorylation_r9_k1',... =1000000.0; # Reaction: id = phosphorylation_r9, name = Ap+B->A+Bp
    'reaction_phosphorylation_r10_k1',... =1.0; # Reaction: id = phosphorylation_r10, name = Bp->B
    'reaction_regulatory_r1_k1',... =1000000.0;
    'reaction_regulatory_r1_k2',... =1.0; # Reaction: id = regulatory_r1, name = T+asp<->Tasp
    'reaction_regulatory_r2_k1',... =1000.0;
    'reaction_regulatory_r2_k2',... =1.0; # Reaction: id = regulatory_r2, name = T+ni<->Tni
    'reaction_regulatory_r3_k1',... =100000.0;
    'reaction_regulatory_r3_k2',... =1.0; # Reaction: id = regulatory_r3, name = T+W<->TW
    'reaction_regulatory_r4_k1',... =10000.0;
    'reaction_regulatory_r4_k2',... =1.0; # Reaction: id = regulatory_r4, name = T+A<->TA
    'reaction_regulatory_r5_k1',... =100000.0;
    'reaction_regulatory_r5_k2',... =1.0; # Reaction: id = regulatory_r5, name = W+A<->WA
    'reaction_regulatory_r6_k1',... =400000.0;
    'reaction_regulatory_r6_k2',... =1.0; # Reaction: id = regulatory_r6, name = TW+A<->TWA
    'reaction_regulatory_r7_k1',... =400000.0; # Reaction: id = regulatory_r7, name = TA+W<->TWA
    'reaction_regulatory_r7_k2',... =1.0; # Reaction: id = regulatory_r7, name = TA+W<->TWA
    'reaction_regulatory_r8_k1',... =400000.0; # Reaction: id = regulatory_r8, name = T+WA<->TWA
    'reaction_regulatory_r8_k2',... =1.0; # Reaction: id = regulatory_r8, name = T+WA<->TWA
    'reaction_regulatory_r9_k1',... =100000.0; # Reaction: id = regulatory_r9, name = Tasp+W<->Tasp_W
    'reaction_regulatory_r9_k2',... =1.0; # Reaction: id = regulatory_r9, name = Tasp+W<->Tasp_W
    'reaction_regulatory_r10_k1',... =10000.0; # Reaction: id = regulatory_r10, name = Tasp+A<->Tasp_A
    'reaction_regulatory_r10_k2',... =1.0;# Reaction: id = regulatory_r10, name = Tasp+A<->Tasp_A
    'reaction_regulatory_r11_k1',... =400000.0; # Reaction: id = regulatory_r11, name = Tasp_W+A<->Tasp_WA
    'reaction_regulatory_r11_k2',...=1.0;# Reaction: id = regulatory_r11, name = Tasp_W+A<->Tasp_WA
    'reaction_regulatory_r12_k1',... =400000.0; # Reaction: id = regulatory_r12, name = Tasp_A+W<->Tasp_WA
    'reaction_regulatory_r12_k2',...=1.0;
    'reaction_regulatory_r13_k1',... =400000.0; # Reaction: id = regulatory_r13, name = Tasp+WA<->Tasp_WA
    'reaction_regulatory_r13_k2',...=1.0;
    'reaction_regulatory_r14_k1',... =0.1; # Reaction: id = regulatory_r14, name = Tni+W<->Tni_W
    'reaction_regulatory_r14_k2',...=1.0;
    'reaction_regulatory_r15_k1',... =0.01; # Reaction: id = regulatory_r15, name = Tni+A<->Tni_A
    'reaction_regulatory_r15_k2',...=1.0;
    'reaction_regulatory_r16_k1',... =0.4; # Reaction: id = regulatory_r16, name = Tni_W+A<->Tni_WA
    'reaction_regulatory_r16_k2',...=1.0;
    'reaction_regulatory_r17_k1',... =0.4; # Reaction: id = regulatory_r17, name = Tni_A+W<->Tni_WA
    'reaction_regulatory_r17_k2',...=1.0;
    'reaction_regulatory_r18_k1',... =0.4; # Reaction: id = regulatory_r18, name = Tni+WA<->Tni_WA
    'reaction_regulatory_r18_k2',...=1.0;
    'reaction_reaction_1_k1',... =1000000.0; # Reaction: id = reaction_1, name = TA + asp <-> Tasp_A
    'reaction_reaction_1_k2',...=1.0;
    'reaction_reaction_2_k1',... =1000000.0; # Reaction: id = reaction_2, name = TW+asp <-> Tasp_W
    'reaction_reaction_2_k2',...=1.0;
    'reaction_reaction_3_k1',... =1000000.0; # Reaction: id = reaction_3, name = TWA+asp <-> Tasp_WA
    'reaction_reaction_3_k2',...);%,...=1.0;) ;
    'compartment_cell',...
    'global_par_alpha' ,...          %;
    'global_par_kappa' ,...       %;
    'global_par_ka',...            %
    'global_par_parameter_3',...         %=;   % # Parameter:   id =  parameter_3, name = KmATP   'compartment_cell=1.41E-15;',...
    'const_species_species_1',... 'ATP'
    'const_species_ni',...  Nikkel
    'global_par_parameter_2');

inputs.model.par = [
    0.0010			%'reaction_phosphorylation_r1_kcat',... = # Reaction: id = phosphorylation_r1, name = A->Ap
    75000.0			%'reaction_phosphorylation_r2_kcat',... = # Reaction: id = phosphorylation_r2, name = TWA+A->TWA+Ap
    200000.0			%'reaction_phosphorylation_r3_kcat',... = # Reaction: id = phosphorylation_r3, name = Tni_WA+A->Tni_WA+Ap
    1.0E8			%'reaction_phosphorylation_r4_k1',...=  # Reaction: id = phosphorylation_r4, name = Tasp_WA+Yp->Tasp_WA+Y
    200000.0			%'reaction_phosphorylation_r5_k1',... = # Reaction: id = phosphorylation_r5, name = Ap+Y->A+Yp
    0.0 %0.0			%'reaction_phosphorylation_r6_kcat',... = # Reaction: id = phosphorylation_r6, name = Y ->Yp
    0.037			%'reaction_phosphorylation_r7_k1',... = # Reaction: id = phosphorylation_r7, name = Yp->Y
    500000.0			%'reaction_phosphorylation_r8_k1',... = # Reaction: id = phosphorylation_r8, name = Yp+Z->Y+Z
    1000000.0			%'reaction_phosphorylation_r9_k1',... = # Reaction: id = phosphorylation_r9, name = Ap+B->A+Bp
    1.0			%'reaction_phosphorylation_r10_k1',... = # Reaction: id = phosphorylation_r10, name = Bp->B
    1000000.0			%'reaction_regulatory_r1_k1',... =
    1.0			%'reaction_regulatory_r1_k2',... = # Reaction: id = regulatory_r1, name = T+asp<->Tasp
    1000.0			%'reaction_regulatory_r2_k1',... =
    1.0			%'reaction_regulatory_r2_k2',... = # Reaction: id = regulatory_r2, name = T+ni<->Tni
    100000.0			%'reaction_regulatory_r3_k1',... =
    1.0			%'reaction_regulatory_r3_k2',... = # Reaction: id = regulatory_r3, name = T+W<->TW
    10000.0			%'reaction_regulatory_r4_k1',... =
    1.0			%'reaction_regulatory_r4_k2',... = # Reaction: id = regulatory_r4, name = T+A<->TA
    100000.0			%'reaction_regulatory_r5_k1',... =
    1.0			%'reaction_regulatory_r5_k2',... = # Reaction: id = regulatory_r5, name = W+A<->WA
    400000.0			%'reaction_regulatory_r6_k1',... =
    1.0			%'reaction_regulatory_r6_k2',... = # Reaction: id = regulatory_r6, name = TW+A<->TWA
    400000.0			%'reaction_regulatory_r7_k1',... = # Reaction: id = regulatory_r7, name = TA+W<->TWA
    1.0			%'reaction_regulatory_r7_k2',... = # Reaction: id = regulatory_r7, name = TA+W<->TWA
    400000.0			%'reaction_regulatory_r8_k1',... = # Reaction: id = regulatory_r8, name = T+WA<->TWA
    1.0			%'reaction_regulatory_r8_k2',... = # Reaction: id = regulatory_r8, name = T+WA<->TWA
    100000.0			%'reaction_regulatory_r9_k1',... = # Reaction: id = regulatory_r9, name = Tasp+W<->Tasp_W
    1.0			%'reaction_regulatory_r9_k2',... = # Reaction: id = regulatory_r9, name = Tasp+W<->Tasp_W
    10000.0			%'reaction_regulatory_r10_k1',... = # Reaction: id = regulatory_r10, name = Tasp+A<->Tasp_A
    1.0			%'reaction_regulatory_r10_k2',... =# Reaction: id = regulatory_r10, name = Tasp+A<->Tasp_A
    400000.0			%'reaction_regulatory_r11_k1',... = # Reaction: id = regulatory_r11, name = Tasp_W+A<->Tasp_WA
    1.0			%'reaction_regulatory_r11_k2',...=# Reaction: id = regulatory_r11, name = Tasp_W+A<->Tasp_WA
    400000.0			%'reaction_regulatory_r12_k1',... = # Reaction: id = regulatory_r12, name = Tasp_A+W<->Tasp_WA
    1.0			%'reaction_regulatory_r12_k2',...=
    400000.0			%'reaction_regulatory_r13_k1',... = # Reaction: id = regulatory_r13, name = Tasp+WA<->Tasp_WA
    1.0			%'reaction_regulatory_r13_k2',...=
    0.1			%'reaction_regulatory_r14_k1',... = # Reaction: id = regulatory_r14, name = Tni+W<->Tni_W
    1.0			%'reaction_regulatory_r14_k2',...=
    0.01			%'reaction_regulatory_r15_k1',... = # Reaction: id = regulatory_r15, name = Tni+A<->Tni_A
    1.0			%'reaction_regulatory_r15_k2',...=
    0.4			%'reaction_regulatory_r16_k1',... = # Reaction: id = regulatory_r16, name = Tni_W+A<->Tni_WA
    1.0			%'reaction_regulatory_r16_k2',...=
    0.4			%'reaction_regulatory_r17_k1',... = # Reaction: id = regulatory_r17, name = Tni_A+W<->Tni_WA
    1.0			%'reaction_regulatory_r17_k2',...=
    0.4			%'reaction_regulatory_r18_k1',... = # Reaction: id = regulatory_r18, name = Tni+WA<->Tni_WA
    1.0			%'reaction_regulatory_r18_k2',...=
    1000000.0			%'reaction_reaction_1_k1',... = # Reaction: id = reaction_1, name = TA + asp <-> Tasp_A
    1.0			%'reaction_reaction_1_k2',...=
    1000000.0			%'reaction_reaction_2_k1',... = # Reaction: id = reaction_2, name = TW+asp <-> Tasp_W
    1.0			%'reaction_reaction_2_k2',...=
    1000000.0			%'reaction_reaction_3_k1',... = # Reaction: id = reaction_3, name = TWA+asp <-> Tasp_WA
    1.0 			%'reaction_reaction_3_k2');%,...=;
    1.41E-15    %;',...'compartment_cell=
    0.14     %;'global_par_alpha=' ,...
    2.25E-7       %;'global_par_kappa=
    0.1           %'global_par_ka=',...
    3.0E-4      %=; 'global_par_parameter_3=  % # Parameter:   id =  parameter_3, name = KmATP   'compartment_cell=1.41E-15;',...
    0.1         %;',... 'ATP''const_species_species_1=
    0.0                  %;',... 'const_species_ni Nikkel
    0.9970]';           % 'global_par_parameter_2= const_species_species_1/(const_species_species_1+global_par_parameter_3]'


inputs.model.eqns = char(...        % Equations describing system dynamics. Time derivatives are regarded 'd'stname'
    'reaction_phosphorylation_r1=compartment_cell*(reaction_phosphorylation_r1_kcat*global_par_parameter_2*x16);',...	# Reaction: id = phosphorylation_r1, name = A->Ap
    'reaction_phosphorylation_r2=compartment_cell*(x13*x16*reaction_phosphorylation_r2_kcat*global_par_parameter_2);',...	# Reaction: id = phosphorylation_r2, name = TWA+A->TWA+Ap
    'reaction_phosphorylation_r3=compartment_cell*(x15*x16*reaction_phosphorylation_r3_kcat*global_par_parameter_2);',...	# Reaction: id = phosphorylation_r3, name = Tni_WA+A->Tni_WA+Ap
    'reaction_phosphorylation_r4=compartment_cell*reaction_phosphorylation_r4_k1*x14*x22;',...	# Reaction: id = phosphorylation_r4, name = Tasp_WA+Yp->Tasp_WA+Y
    'reaction_phosphorylation_r5=compartment_cell*reaction_phosphorylation_r5_k1*x17*x21;',...	# Reaction: id = phosphorylation_r5, name = Ap+Y->A+Yp
    'reaction_phosphorylation_r6=compartment_cell*(reaction_phosphorylation_r6_kcat*global_par_parameter_2*x21);',...	# Reaction: id = phosphorylation_r6, name = Y ->Yp
    'reaction_phosphorylation_r7=compartment_cell*reaction_phosphorylation_r7_k1*x22;',...	# Reaction: id = phosphorylation_r7, name = Yp->Y
    'reaction_phosphorylation_r8=compartment_cell*reaction_phosphorylation_r8_k1*x22*x20;',...	# Reaction: id = phosphorylation_r8, name = Yp+Z->Y+Z
    'reaction_phosphorylation_r9=compartment_cell*reaction_phosphorylation_r9_k1*x17*x18;',...	# Reaction: id = phosphorylation_r9, name = Ap+B->A+Bp
    'reaction_phosphorylation_r10=compartment_cell*reaction_phosphorylation_r10_k1*x19;',...	# Reaction: id = phosphorylation_r10, name = Bp->B
    'reaction_regulatory_r1=compartment_cell*(reaction_regulatory_r1_k1*x2*asp-reaction_regulatory_r1_k2*x3);',...	# Reaction: id = regulatory_r1, name = T+asp<->Tasp
    'reaction_regulatory_r2=compartment_cell*(reaction_regulatory_r2_k1*x2*const_species_ni-reaction_regulatory_r2_k2*x4);',...	# Reaction: id = regulatory_r2, name = T+ni<->Tni
    'reaction_regulatory_r3=compartment_cell*(reaction_regulatory_r3_k1*x2*x5-reaction_regulatory_r3_k2*x6);',...	# Reaction: id = regulatory_r3, name = T+W<->TW
    'reaction_regulatory_r4=compartment_cell*(reaction_regulatory_r4_k1*x2*x16-reaction_regulatory_r4_k2*x9);',...	# Reaction: id = regulatory_r4, name = T+A<->TA
    'reaction_regulatory_r5=compartment_cell*(reaction_regulatory_r5_k1*x5*x16-reaction_regulatory_r5_k2*x12);',...	# Reaction: id = regulatory_r5, name = W+A<->WA
    'reaction_regulatory_r6=compartment_cell*(reaction_regulatory_r6_k1*x6*x16-reaction_regulatory_r6_k2*x13);',...	# Reaction: id = regulatory_r6, name = TW+A<->TWA
    'reaction_regulatory_r7=compartment_cell*(reaction_regulatory_r7_k1*x9*x5-reaction_regulatory_r7_k2*x13);',...	# Reaction: id = regulatory_r7, name = TA+W<->TWA
    'reaction_regulatory_r8=compartment_cell*(reaction_regulatory_r8_k1*x2*x12-reaction_regulatory_r8_k2*x13);',...	# Reaction: id = regulatory_r8, name = T+WA<->TWA
    'reaction_regulatory_r9=compartment_cell*(reaction_regulatory_r9_k1*x3*x5-reaction_regulatory_r9_k2*x7);',...	# Reaction: id = regulatory_r9, name = Tasp+W<->Tasp_W
    'reaction_regulatory_r10=compartment_cell*(reaction_regulatory_r10_k1*x3*x16-reaction_regulatory_r10_k2*x10);',...	# Reaction: id = regulatory_r10, name = Tasp+A<->Tasp_A
    'reaction_regulatory_r11=compartment_cell*(reaction_regulatory_r11_k1*x7*x16-reaction_regulatory_r11_k2*x14);',...	# Reaction: id = regulatory_r11, name = Tasp_W+A<->Tasp_WA
    'reaction_regulatory_r12=compartment_cell*(reaction_regulatory_r12_k1*x10*x5-reaction_regulatory_r12_k2*x14);',...	# Reaction: id = regulatory_r12, name = Tasp_A+W<->Tasp_WA
    'reaction_regulatory_r13=compartment_cell*(reaction_regulatory_r13_k1*x3*x12-reaction_regulatory_r13_k2*x14);',...	# Reaction: id = regulatory_r13, name = Tasp+WA<->Tasp_WA
    'reaction_regulatory_r14=compartment_cell*(reaction_regulatory_r14_k1*x4*x5-reaction_regulatory_r14_k2*x8);',...	# Reaction: id = regulatory_r14, name = Tni+W<->Tni_W
    'reaction_regulatory_r15=compartment_cell*(reaction_regulatory_r15_k1*x4*x16-reaction_regulatory_r15_k2*x11);',...	# Reaction: id = regulatory_r15, name = Tni+A<->Tni_A
    'reaction_regulatory_r16=compartment_cell*(reaction_regulatory_r16_k1*x8*x16-reaction_regulatory_r16_k2*x15);',...	# Reaction: id = regulatory_r16, name = Tni_W+A<->Tni_WA
    'reaction_regulatory_r17=compartment_cell*(reaction_regulatory_r17_k1*x11*x5-reaction_regulatory_r17_k2*x15);',...	# Reaction: id = regulatory_r17, name = Tni_A+W<->Tni_WA
    'reaction_regulatory_r18=compartment_cell*(reaction_regulatory_r18_k1*x4*x12-reaction_regulatory_r18_k2*x15);',...	# Reaction: id = regulatory_r18, name = Tni+WA<->Tni_WA
    'reaction_motor_r1=compartment_cell*(global_par_ka*(x23*x22-global_par_kappa/4*x24)/compartment_cell);',...	# Reaction: id = motor_r1, name = M+Yp<->MYp
    'reaction_motor_r2=compartment_cell*(global_par_ka*(x24*x22-2*global_par_alpha*global_par_kappa/3*x25)/compartment_cell);',...	# Reaction: id = motor_r2, name = MYp+Yp<->MYpYp
    'reaction_motor_r3=compartment_cell*(global_par_ka*(x25*x22-3*global_par_alpha*global_par_alpha*global_par_kappa/2*x26)/compartment_cell);',...	# Reaction: id = motor_r3, name = MYpYp+Yp<->MYpYpYp
    'reaction_motor_r4=compartment_cell*(global_par_ka*(x26*x22-4*global_par_alpha*global_par_alpha*global_par_alpha*global_par_kappa*x27)/compartment_cell);',...	# Reaction: id = motor_r4, name = MYpYpYp+Yp<->MYpYpYpYp
    'reaction_reaction_1=compartment_cell*(reaction_reaction_1_k1*x9*asp-reaction_reaction_1_k2*x10);',...	# Reaction: id = reaction_1, name = TA + asp <-> Tasp_A
    'reaction_reaction_2=compartment_cell*(reaction_reaction_2_k1*x6*asp-reaction_reaction_2_k2*x7);',...	# Reaction: id = reaction_2, name = TW+asp <-> Tasp_W
    'reaction_reaction_3=compartment_cell*(reaction_reaction_3_k1*x13*asp-reaction_reaction_3_k2*x14);',...	# Reaction: id = reaction_3, name = TWA+asp <-> Tasp_WA
    'dx2 = (1/(compartment_cell))*((-1.0 * reaction_regulatory_r1) + (-1.0 * reaction_regulatory_r2) + (-1.0 * reaction_regulatory_r3) + (-1.0 * reaction_regulatory_r4) + (-1.0 * reaction_regulatory_r8));',...# Species:   id = T, name = T, affected by kineticLaw
    'dx3 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r1) + (-1.0 * reaction_regulatory_r9) + (-1.0 * reaction_regulatory_r10) + (-1.0 * reaction_regulatory_r13));',...# Species:   id = Tasp, name = Tasp, affected by kineticLaw
    'dx4 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r2) + (-1.0 * reaction_regulatory_r14) + (-1.0 * reaction_regulatory_r15) + (-1.0 * reaction_regulatory_r18));',...# Species:   id = Tni, name = Tni, affected by kineticLaw
    'dx5 = (1/(compartment_cell))*((-1.0 * reaction_regulatory_r3) + (-1.0 * reaction_regulatory_r5) + (-1.0 * reaction_regulatory_r7) + (-1.0 * reaction_regulatory_r9) + (-1.0 * reaction_regulatory_r12) + (-1.0 * reaction_regulatory_r14) + (-1.0 * reaction_regulatory_r17));',...# Species:   id = W, name = W, affected by kineticLaw
    'dx6 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r3) + (-1.0 * reaction_regulatory_r6) + (-1.0 * reaction_reaction_2));',...# Species:   id = TW, name = TW, affected by kineticLaw
    'dx7 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r9) + (-1.0 * reaction_regulatory_r11) + ( 1.0 * reaction_reaction_2));',...# Species:   id = Tasp_W, name = Tasp_W, affected by kineticLaw
    'dx8 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r14) + (-1.0 * reaction_regulatory_r16));',...# Species:   id = Tni_W, name = Tni_W, affected by kineticLaw
    'dx9 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r4) + (-1.0 * reaction_regulatory_r7) + (-1.0 * reaction_reaction_1));',...# Species:   id = TA, name = TA, affected by kineticLaw
    'dx10 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r10) + (-1.0 * reaction_regulatory_r12) + ( 1.0 * reaction_reaction_1));',...# Species:   id = Tasp_A, name = Tasp_A, affected by kineticLaw
    'dx11 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r15) + (-1.0 * reaction_regulatory_r17));',...# Species:   id = Tni_A, name = Tni_A, affected by kineticLaw
    'dx12 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r5) + (-1.0 * reaction_regulatory_r8) + (-1.0 * reaction_regulatory_r13) + (-1.0 * reaction_regulatory_r18));',...# Species:   id = WA, name = WA, affected by kineticLaw
    'dx13 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r6) + ( 1.0 * reaction_regulatory_r7) + ( 1.0 * reaction_regulatory_r8) + (-1.0 * reaction_reaction_3));',...# Species:   id = TWA, name = TWA, affected by kineticLaw
    'dx14 = (1/(compartment_cell))*((-1.0 * reaction_phosphorylation_r4) + ( 1.0 * reaction_phosphorylation_r4) + ( 1.0 * reaction_regulatory_r11) + ( 1.0 * reaction_regulatory_r12) + ( 1.0 * reaction_regulatory_r13) + ( 1.0 * reaction_reaction_3));',...# Species:   id = Tasp_WA, name = Tasp_WA, affected by kineticLaw
    'dx15 = (1/(compartment_cell))*(( 1.0 * reaction_regulatory_r16) + ( 1.0 * reaction_regulatory_r17) + ( 1.0 * reaction_regulatory_r18));',...# Species:   id = Tni_WA, name = Tni_WA, affected by kineticLaw
    'dx16 = (1/(compartment_cell))*((-1.0 * reaction_phosphorylation_r1) + (-1.0 * reaction_phosphorylation_r2) + (-1.0 * reaction_phosphorylation_r3) + ( 1.0 * reaction_phosphorylation_r5) + ( 1.0 * reaction_phosphorylation_r9) + (-1.0 * reaction_regulatory_r4) + (-1.0 * reaction_regulatory_r5) + (-1.0 * reaction_regulatory_r6) + (-1.0 * reaction_regulatory_r10) + (-1.0 * reaction_regulatory_r11) + (-1.0 * reaction_regulatory_r15) + (-1.0 * reaction_regulatory_r16));',...# Species:   id = A, name = A, affected by kineticLaw
    'dx17 = (1/(compartment_cell))*(( 1.0 * reaction_phosphorylation_r1) + ( 1.0 * reaction_phosphorylation_r2) + ( 1.0 * reaction_phosphorylation_r3) + (-1.0 * reaction_phosphorylation_r5) + (-1.0 * reaction_phosphorylation_r9));',...# Species:   id = Ap, name = Ap, affected by kineticLaw
    'dx18 = (1/(compartment_cell))*((-1.0 * reaction_phosphorylation_r9) + ( 1.0 * reaction_phosphorylation_r10));',...# Species:   id = B, name = B, affected by kineticLaw
    'dx19 = (1/(compartment_cell))*(( 1.0 * reaction_phosphorylation_r9) + (-1.0 * reaction_phosphorylation_r10));',...# Species:   id = Bp, name = Bp, affected by kineticLaw
    'dx20 = (1/(compartment_cell))*((-1.0 * reaction_phosphorylation_r8) + ( 1.0 * reaction_phosphorylation_r8));',...# Species:   id = Z, name = Z, affected by kineticLaw
    'dx21 = (1/(compartment_cell))*(( 1.0 * reaction_phosphorylation_r4) + (-1.0 * reaction_phosphorylation_r5) + (-1.0 * reaction_phosphorylation_r6) + ( 1.0 * reaction_phosphorylation_r7) + ( 1.0 * reaction_phosphorylation_r8));',...# Species:   id = Y, name = Y, affected by kineticLaw
    'dx22 = (1/(compartment_cell))*((-1.0 * reaction_phosphorylation_r4) + ( 1.0 * reaction_phosphorylation_r5) + ( 1.0 * reaction_phosphorylation_r6) + (-1.0 * reaction_phosphorylation_r7) + (-1.0 * reaction_phosphorylation_r8) + (-1.0 * reaction_motor_r1) + (-1.0 * reaction_motor_r2) + (-1.0 * reaction_motor_r3) + (-1.0 * reaction_motor_r4));',...# Species:   id = Yp, name = Yp, affected by kineticLaw
    'dx23 = (1/(compartment_cell))*((-1.0 * reaction_motor_r1));',...# Species:   id = M, name = M, affected by kineticLaw
    'dx24 = (1/(compartment_cell))*(( 1.0 * reaction_motor_r1) + (-1.0 * reaction_motor_r2));',...# Species:   id = MYp, name = MYp, affected by kineticLaw
    'dx25 = (1/(compartment_cell))*(( 1.0 * reaction_motor_r2) + (-1.0 * reaction_motor_r3));',...# Species:   id = MYpYp, name = MYpYp, affected by kineticLaw
    'dx26 = (1/(compartment_cell))*(( 1.0 * reaction_motor_r3) + (-1.0 * reaction_motor_r4));',...# Species:   id = MYpYpYp, name = MYpYpYp, affected by kineticLaw
    'dx27 = (1/(compartment_cell))*(( 1.0 * reaction_motor_r4));');


%=========================
% EXPERIMENTS RELATED DATA
%=========================
inputs.exps.n_exp = 2;
y0_all = [3.1200e-006    0    0    2.8900e-006    5.9100e-007    0    0    4.4400e-007...
    0    0    6.7800e-007    8.4700e-007    0    0    3.0000e-006    3.4800e-008...
    1.9300e-006    6.8700e-008    2.0000e-005    9.9000e-006    7.0000e-009    6.2400e-009...
    7.7700e-010    2.9900e-010    3.7800e-010    2.3100e-009];
% Experiment 1
    inputs.exps.u_interp{1} = 'step';
    inputs.exps.n_steps{1}  = 3;
    inputs.exps.u{1}        = [0 0.333e-7  0.66e-7 ];
    inputs.exps.t_con{1}    = [0 60  120 180 ];
    inputs.exps.t_f{1}      = 180;                        % Experiments duration
    inputs.exps.n_s{1}      = 40;                        % [] Number of sampling times for each experiment.
    inputs.exps.t_s{1}      = linspace(0,180,40);
    inputs.exps.exp_y0{1}   = y0_all;
% Experiment 2
    inputs.exps.u_interp{2} = 'step';
    inputs.exps.n_steps{2}  = 3;
    inputs.exps.u{2}        = [2e-7 0.333e-7   1e-7 ];
    inputs.exps.t_con{2}    = [0 60  120 180];
    inputs.exps.t_f{2}      = 180;                        % Experiments duration
    inputs.exps.n_s{2}      = 40;                        % [] Number of sampling times for each experiment.
    inputs.exps.t_s{2}      = linspace(0,180,40);
    inputs.exps.exp_y0{2}   = y0_all;

% Same for all experiments
    for iexp = 1:2
        inputs.exps.n_obs{iexp}     = 8;                        % Number of observed quantities per experiment
        inputs.exps.obs_names{iexp} = char( 'Ap', 'Bp',  'Yp', 'MYp', 'MYpYp', 'MYpYpYp', 'MYpYpYpYp','Bias' );
        inputs.exps.obs{iexp}       = char( 'Ap=x17', 'Bp=x19', 'Yp=x22', 'MYp=x24', 'MYpYp=x25', 'MYpYpYp=x26',...
            'MYpYpYpYp=x27','Bias=(x23 + x24)./(x23 +x24 +x25 +x26 +x27)');
    end
    
    inputs.exps.data_type    = 'pseudo'; 
    % Experimental data obtained by AMIGO_SData
%     chemotaxis_pseudodata;  % contains inputs.exps.exp_data and error_data
    
%================================
% PSEUDO-EXPERIMENTS RELATED DATA
%=================================
% inputs.exps.data_type    = 'pseudo';    
% inputs.exps.noise_type   = 'homo_var';
% for iexp = 1:4
%     inputs.exps.std_dev{iexp}=0.1*ones(1,8);
% end

%==================================
% UNKNOWNS RELATED DATA
%==================================

% GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERIMENTS)

index_theta  = [1 2 4 5 7:12, 15:36 47:52];  % indices of estimated parameters
inputs.PEsol.id_global_theta =  inputs.model.par_names(index_theta,:);

% nominal parameter vector, pnom:
pars = inputs.model.par(index_theta);


inputs.PEsol.global_theta_max = pars*1e5;  % upper bounds - mandatory
inputs.PEsol.global_theta_min = pars*1e-5; % lower bounds - mandatory
inputs.PEsol.global_theta_guess =inputs.model.par(index_theta);% pars;


%==================================
% COST FUNCTION RELATED DATA
%==================================

inputs.PEsol.PEcost_type = 'llk';                     % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'userPEcost' 
inputs.PEsol.PEcostJac_type = 'llk';
inputs.PEsol.llk_type    = 'hetero';                % 'QI'           

%==================================
% NUMERICAL METHODS RELATED DATA
%==================================
%
inputs.plotd.plotlevel = 'min';
inputs.nlpsol.nlpsolver = 'ess';
inputs.nlpsol.eSS.local.solver = 'nl2sol';
inputs.nlpsol.eSS.local.finish = 'nl2sol';
inputs.nlpsol.eSS.local.nl2sol.maxfeval = 150;
inputs.nlpsol.eSS.maxeval = 20000;
inputs.nlpsol.eSS.maxtime = 900;
inputs.nlpsol.eSS.log_var = 1:38;
inputs.nlpsol.eSS.local.nl2sol.objrtol =  inputs.ivpsol.rtol;
inputs.nlpsol.eSS.local.nl2sol.tolrfun = 1e-4;
