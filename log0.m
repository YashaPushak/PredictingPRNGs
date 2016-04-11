function [x] = log0(x)
x(x~=0) = log(x(x~=0));