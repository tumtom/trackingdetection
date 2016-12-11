function [c_x, c_y] = centerMass(M)
	[row, col] = size(M);
	c_x = 0;
	c_y = 0;
	for i = 1:col
		c_x = c_x + M(1, i);
		c_y = c_y + M(2, i);
	end
	c_x = c_x/col;
	c_y = c_y/col;
end