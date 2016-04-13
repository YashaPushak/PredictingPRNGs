function [learner] = configureRandomSampling(~,~,~,~,~,k,~)
%Random sampling has no parameters to configure, we are simply using this
%wrapper function for convenience and consistency.

learner.train = @(X,y) randomSampling(X,y);
learner.featureType = 's';
learner.labelSize = k;
learner.name = 'Random Sampling';

end