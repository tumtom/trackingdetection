% Read an example image
x = imread('test_shell1_small.jpg') ;


% Convert to single format
x = im2single(x) ;


% Create a bank of linear filters
%w = randn(104,123,31,'single') ;
object = im2single(imread('shell_small.jpg'));
object_hog = vl_hog(object,8);

detect = detectAtMultipleScales(x,object_hog,2,[1:4]);
detect(4,1) = detect(4,1) - detect(2,1);
detect(3,1) = detect(3,1) - detect(1,1);
rectangle('Position',detect);