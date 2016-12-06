%Create points

% Source (22,10); (140, 19); (139, 202); (279, 203)
% Distant (127, 166); (186, 177); (166, 271); (243, 282);
M_s = [22 140 139 279; 10 19 202, 203];
M_d = [127 186 166 243; 166 177 271 282];
n = 4;

%Create homogeneous
M_s_h = ones(3, n);
M_d_h = ones(3, n);

M_s_h(1:2, :) = M_s;
M_d_h(1:2, :) = M_d;

%Normalize
M_s_h_norm = normalization(M_s_h);
M_d_h_norm = normalization(M_d_h);

%Find homography