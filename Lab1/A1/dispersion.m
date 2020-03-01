function [D] = dispersion(lambda,beta)
%DISPERSION function to calculate a fiber dispersion parameter
%   D = -(2pi * c)/Lambda * ß
c = physconst('LightSpeed');
D = -(2*pi*c/lambda)*beta;
end

