function [ R ] = response( I, x, y, sigma_d, sigma_i, alpha )
%calculate the response for:
% - I: image matrix (doubles!)
% - x: image row
% - y: pixel column in row x
% - sigma_d: differentiation scale
% - sigma_i: integration scale
% - alpha: parameter, usually between 0.04 and 0.06
%output: response for pixel x,y
%formula: R(x, σIn , σDn ) = det(M (x, σIn , σDn )) − α · trace(M (x, σIn , σDn ))^2

M = moment_matrix(I, x, y, sigma_d, sigma_i);

R = det(M) - alpha * trace(M)^2;

end

