function [d] = everageDistance(M)
	[row, col] = size(M);
	d = 0;
	for i = 1:col
		d = d + sqrt(M(1,i)^2 + M(2,i)^2);	
	end
	d = d/col;
end