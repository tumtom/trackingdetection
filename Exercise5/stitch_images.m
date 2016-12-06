run('/home/tom/ownCloud/Skripte/Master/Semester3_WS1617/TrackingDetection/Excercises/Exercise3/vlfeat/toolbox/vl_setup.m')

Ia = single(imread('box.pgm'));
Ib = single(imread('scene.pgm'));

[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db) ;

points = [];
points(1,:) = round(fa(1,matches(1,:)));
points(2,:) = round(fa(2,matches(1,:)));
points(3,:) = round(fb(1,matches(2,:)));
points(4,:) = round(fb(2,matches(2,:)));

points = points';

number_of_points_in_set = 5;
threshold_distance = 1000;
threshold_number_inliers = 20;
number_of_trials = 5;
Cset = ransac(points,number_of_points_in_set,threshold_distance,threshold_number_inliers,number_of_trials);