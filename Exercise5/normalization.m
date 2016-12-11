function [M_norm, U] = normalization(M)

% Translate origin to the center of mass
	[c_x, c_y] = centerMass(M);
	T = eye(3,3);
	T(1,3) = c_x;
	T(2,3) = c_y;

	M_transl = T*M;

% Scale coordinate system
	d = everageDistance(M_transl);
	S = eye(3,3);
	S(1,1) = sqrt(2)/d;
	S(2,2) = sqrt(2)/d;

	M_norm = S*M_transl;
    U = S*T;
end


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

function [d] = everageDistance(M)
	[row, col] = size(M);
	d = 0;
	for i = 1:col
		d = d + sqrt(M(1,i)^2 + M(2,i)^2);	
	end
	d = d/col;
end