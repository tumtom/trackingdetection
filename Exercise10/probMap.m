function [ D ] = probMap( I, hist )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

maximum = max(hist);
minimum = min(hist);

[rows, cols] = size(I);
gap = 1/256;
for row = 1:rows
    for col = 1:cols
        hue = I(row, col);
        bin = floor(hue/gap)+1;
        d = hist(bin);
        
        %D(row, col) = (d - minimum)/(maximum-minimum)*255;
        D(row, col) = ((d)/(maximum))*255;
    end
end

end

