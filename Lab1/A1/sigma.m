function [sigma] = sigma(HPFW)
%SIGMA function to calculate sigma value
sigma = HPFW / (2*sqrt(log(2)));
end

