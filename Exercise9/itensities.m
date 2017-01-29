function [ it ] = itensities( warped_grid, I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

it = ones(1,size(warped_grid,1));

for i=1:size(warped_grid,1)
    it(i) = I(warped_grid(i,2),warped_grid(i,1));
end

it = double(it);
it = (it-min(it))./(max(it)-min(it));

end

