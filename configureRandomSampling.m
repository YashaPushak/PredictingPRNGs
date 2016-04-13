function [learner] = configureRandomSampling(~,~,~,~,~,~,~)
%Random sampling has no parameters to configure, we are simply using this
%wrapper function for convenience and consistency.

learner.train = @(X,y) randomSampling(X,y);
learner.featureType = 's';

end