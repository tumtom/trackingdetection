%run('/home/tom/ownCloud/Skripte/Master/Semester3_WS1617/TrackingDetection/Excercises/Exercise3/vlfeat/toolbox/vl_setup.m')

[Is,cm] = imread('scene.pgm');
Is = single(Is);
Id = single(imread('box.pgm'));

[fs, ds] = vl_sift(Is) ;
[fd, dd] = vl_sift(Id) ;
[matches, scores] = vl_ubcmatch(ds, dd) ;

points = [];
points(1,:) = round(fs(1,matches(1,:)));
points(2,:) = round(fs(2,matches(1,:)));
points(3,:) = round(fd(1,matches(2,:)));
points(4,:) = round(fd(2,matches(2,:)));


%Create points

M_s = [points(1,:); points(2,:)];
M_d = [points(3,:); points(4,:)];

n=size(M_s,2);

%Create homogeneous
M_s_h = ones(3, n);
M_d_h = ones(3, n);

M_s_h(1:2, :) = M_s;
M_d_h(1:2, :) = M_d;

%H = homography(M_s_h, M_d_h);

s=6;
t_distance = 4;
T_set = 5;
N_trials = 50;
%Find homography
[CorresponseSet_s,CorresponseSet_d] = ransac(M_s_h,M_d_h,s,t_distance,T_set,N_trials);

%H = homography(M_s_h,M_d_h);
H = homography(CorresponseSet_s,CorresponseSet_d);

I = zeros(size(Is,1), size(Is,2));
for r=1:size(Is, 1)
    for c=1:size(Is, 2)
        X = [c; r; 1];
        X_ = H*X;
        X_(1) = round(X_(1,1)/X_(3,1));
        X_(2) = round(X_(2,1)/X_(3,1));
        
        if (X_(1,1) > 0 && X_(2,1) > 0 && X_(1,1) <= size(I,1) && X_(2,1) <= size(I,2))
            I(X_(2,1), X_(1,1)) = Is(r,c);
        end
    end
end
figure()
imshow(I,cm);

%stiching

M_s_new = M_s_h;
for i = 1:size(M_s_h, 2)
    X = M_s_h(:, i);
    X_ = H*X;
    X_ = X_/X_(3,1);
    M_s_new(:,i) = X_;
end

[c_s_x, c_s_y] = centerMass(M_s_new);
[c_d_x, c_d_y] = centerMass(M_d);

scale_s = everageDistance(M_s_new);
scale_d = everageDistance(M_d);


for r = 1:size(Id,1)
    for c = 1:size(Id,2)
        new_row = round(c_s_y + scale_d/scale_s*(r-c_d_y));
        new_col = round(c_s_x + scale_d/scale_s*(c-c_d_x));
        if (new_row > 0) && (new_row <= size(I,1)) && (new_col > 0) && (new_col <= size(I,2))
            I(new_row, new_col) = Id(r,c);
        end
    end
end
imshow(I,cm);
