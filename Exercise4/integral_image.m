function [ I_int ] = integral_image( I )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[I_rows,I_cols] = size(I);
I_ex = zeros(I_rows+2, I_cols+2);
I_ex(2:I_rows+1,2:I_cols+1) = I(1:I_rows,1:I_cols);

for r=2:I_rows
    for c = 2:I_cols
        I_ex(r,c) = I_ex(r,c) + I_ex(r-1,c) + I_ex(r,c-1) - I_ex(r-1, c-1);
    end
end

I_int = I_ex(2:I_rows+1,2:I_cols+1);

end

