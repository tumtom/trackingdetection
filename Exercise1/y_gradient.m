function [ I_Dy ] = y_gradient( I )
% applies the D_y kernel to the image I

D_y = [[-1,0,1];[-1,0,1];[-1,0,1]].';
I_Dy = convolve(I,D_y,'border_extend');

end

