function [ G ] = CreateGaussian( sigma )
    n = 3*sigma;
    middle = floor(n/2) + 1;
    sum = 0;
    G(middle, middle) = Gaussian(0, 0, sigma);
    for i = 0:1:floor(n/2)
	for j = 0:1:floor(n/2)
        g_current = Gaussian(i, j, sigma);       
		G(middle + i, middle + j) = g_current;
		G(middle - i, middle + j) = g_current;
		G(middle - i, middle - j) = g_current;
		G(middle + i, middle - j) = g_current;
        if i == 0 && j == 0
            sum = g_current;
        elseif (i == 0 && j > 0) || (j == 0 && i > 0)
            sum = sum + g_current * 2;
        else
            sum = sum + (g_current*4);
        end
	end
    end
    
    G = 1/sum * G;
end
