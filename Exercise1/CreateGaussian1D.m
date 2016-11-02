function [ G ] = CreateGaussian1D( sigma )
    n = 3*sigma;
    middle = floor(n/2) + 1;
    sum = 0;
    G(1, middle) = Gaussian1D(0, sigma);
    sum = sum + G(1, middle);
    
    for i = 1:1:floor(n/2)
    g_current = Gaussian1D(i, sigma);
	G(1, middle + i) = g_current;
	G(1, middle - i) = g_current;
    sum = sum + g_current * 2;
    end
    
    G = 1/sum * G;
end