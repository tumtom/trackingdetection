
function [ g ] = Gaussian(u, v, sigma)
    g = 1/(2*sigma^2) * exp(-(u^2+v^2)/(sigma^2));
end





