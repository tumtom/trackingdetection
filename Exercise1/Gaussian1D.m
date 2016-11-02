function [ g ] = Gaussian1D(u, sigma)
    g = 1/(2*sigma^2) * exp(-(u^2)/(sigma^2));
end