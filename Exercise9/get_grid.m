function [ grid_p ] = get_grid( rect, grid_dist )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

num_col = (rect(2,1)-rect(1,1))/grid_dist +1;
num_row = (rect(3,2)-rect(1,2))/grid_dist +1;

grid_p = [];
for r = 0:num_row-1
    for c = 0:num_col-1
        grid_p = [grid_p; [rect(1,1)+c*grid_dist, rect(1,2)+r*grid_dist] ];
    end
end

end

