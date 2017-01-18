function [ ] = plot_data( M )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

size_scat = 5;
negative_class = -1;
negative_color = 'red';
positive_color = 'blue';

for r = 1:size(M,1)
    if (M(r,3) == negative_class)
        c = negative_color;
    else 
        c = positive_color;
    end
    scatter(M(r,1),M(r,2),size_scat,c);
    hold on;
end
hold off;




end

