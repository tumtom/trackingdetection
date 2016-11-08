I_check = double(imread('checkerboard_tunnel.png'));

%I = (checkerboard*255);
I = I_check;
sigma_d = 1;
sigma_i = 3;
alpha = 0.04;
threshold = 700;

figure();
[r,c,R] = harris(I, sigma_d, sigma_i, alpha, threshold);
imshow(I);
hold on;
scatter(r,c,'r');

corners = detectHarrisFeatures(I,'FilterSize',sigma_d*3);
plot(corners.selectStrongest(400));
hold off;
