function [ grid_p ] = get_grid( rect )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

grid_p = [];
for r = 0:num_row-1
    for c = 0:num_col-1
        grid_p = [grid_p; [rect(1,1)+c*5, rect(1,2)+r*5] ];
    end
end

end

