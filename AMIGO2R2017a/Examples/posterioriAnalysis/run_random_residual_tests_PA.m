% Tutorial example 1. for R-squared test
% 
% R-square test compares the user''s model to the mean of the data using
% the residuals and the mean value of the data. 
% 
% 	R2 ~ 1 =>  the model is much better than using the simple mean of the data
% 	R2 << 1 =>  the simple mean explains the observations better than the model.
%
% Tutorial example 2. for Chi2 test
% 
% We check the distribution of the residuals. If the residuals have
% standard normal distribution, then the sum of squared residuals (Chi2=Sum_i R_i^2) follows
% Chi-2 distribution. One can test how much the computed Chi2 value
% differs from the theoretical value. The inverse of the Chi2 distribution
% tells you how probable that you observe bigger Chi2 value than your
% computed value. If this probability is less than 0.05, we reject the model.


%clc
%clear
% In this tutorial we will simulate the parameter estimation result. We
% directly generate the residuals using random distributions. Then, we test
% the residuals against the 0-hypothesis: they are from uncorrelated,
% normal distribution. 


%% Posteriori Analysis inputs:
postAnalysis.n_experiment = 1;

% we have 10 observables, and 50 data for each observable, thus the
% residual matrix is 50x10. 
postAnalysis.residuals{1} = randn(50,10);
postAnalysis.obs_names{1} = char('y1', 'y2', 'y3', 'y4','y5', 'y6', 'y7', 'y8','y9', 'y10');  

% the data usually has higher variance than the model's residuals:
postAnalysis.data{1} = randn(50,10);

% in this case we see that, the R2 is somewhere 0.5:
% It is better to use the model for prediction, because the model fits the
% data better than using just the simple mean value of the data. 

% HINTs:
% Try to increase/decrase of the residuals/data variance
% postAnalysis.data = randn(50,10);
% => if the data 

% 
% Try what if the residuals are biased: 
% randn(50,10) + 0.01;   -- small bias is not detected
% randn(50,10) + 0.4;    -- bias ~ 40% of the standard deviation is well-detected
%
% increas the standard deviation:
% 10*randn(50,10)       -- nothing happens: the algorithm estimates the std...
%
% Try different number of observables, to see how it effects the output
% e.g. randn(10,10), randn(10000,10) 

% we do not specify the standard deviation: the algorithm will do it, but
% this will decrease the degree-of-freedom by 1. 
postAnalysis.std_dev{1} = [];
% if you do not declare standard deviation, that is equivalent to declaire like 
% postAnalysis.std_dev = std(postAnalysis.residuals) and 
% postAnalysis.n_estimatedParameters + 1 

% the residuals were generated, thus we did not fit any parameter
postAnalysis.n_globalParameters = 0;
postAnalysis.n_localParameters{1} = 0;
postAnalysis.costType = 'none';
% run the test. See the commandline for the details. 
stat = AMIGO_PEPostAnalysis(postAnalysis);