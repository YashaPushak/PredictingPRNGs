function [learner] = configureRandomSampling(~,~,~,~)
%Random sampling has no parameters to configure, we are simply using this
%wrapper function for convenience and consistency.

learner.train = @(X,y) randomSampling(X,y,depth,nTrees);
learner.featureType = 's';

end