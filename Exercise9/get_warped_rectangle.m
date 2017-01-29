function [ J ] = get_warped_rectangle( I, rect, max_x, max_y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% rectangle rect looks like
% p1_x p2_x p3_x p4_x 
% p1_y p2_y p3_y p4_y

r_x = rand()*max_x-(max_x/2);
r_y = rand()*max_y-(max_y/2);

for p=1:4
    rect(:,p) = rect(:,p) + [r_x;r_y];
end



end

