function [ bins ] = colorHist( H, n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[rows, cols] = size(H);
bins=zeros(n,1);
gap = 1/n;
for x=1:cols
    for y=1:rows
        b = floor(H(y,x)/gap)+1;
        bins(b) = bins(b) + 1;
    end
end

end

