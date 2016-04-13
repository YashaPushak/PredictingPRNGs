function [numsT] = lcgPRNG(n,k, seed)
%A basic linear congruential generator
%n - number of inputs
%k - Number of classes NOTE: Can only take values 2, 3, or 5 for this PRNG

%Parameters of the linear congruiential generator
a = 22695477;
c = 1;
m = 2^32;

%Set a random seed
if nargin < 3
    seed = 'shuffle';
end 

rng(seed);

nums = zeros(n,1);
numsT = zeros(n,1);

nums(1) = randi(2^31-1);
numsT(1) = mod(nums(1),k)+1;

for i = 2:n
    nums(i) = mod(a*nums(i-1) + c,m);
    numsT(i) = mod(nums(i),k)+1;
end


end