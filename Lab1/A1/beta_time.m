function [beta] = beta_time(sigma_in,sigma_out,L)
beta = sqrt((sigma_out^2 - sigma_in^2)*sigma_in^2)/ L;
end