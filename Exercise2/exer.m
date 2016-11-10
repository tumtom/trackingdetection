%read images
I_check = double(imread('checkerboard_tunnel.png'));
I_house = imread('house.png');
I_test = imread('test.png');
I_sample = rgb2gray(imread('sample2.jpg'));

%parameters for checkerboard_tunnel
Res1 = harris_laplace(I_check, 3, 1.5, 1.2, 0.06, 300);

figure();
imshow(I_check);
hold on;
scatter(Res1(:,2), Res1(:,1), 20);

%parameters for test
Res2 = harris_laplace(I_test, 7, 1.5, 1.2, 0.02, 0);

figure();
imshow(I_test);
hold on;
scatter(Res2(:,2), Res2(:,1), 20);

%parameters for house
Res3 = harris_laplace(I_house, 7, 3, 1.2, 0.04, 20);

figure();
imshow(I_house);
hold on;
scatter(Res3(:,2), Res3(:,1), 20);

%parameters for sample2
Res4 = harris_laplace(I_sample, 3, 1.5, 1.2, 0.06, 510);

figure();
imshow(I_sample);
hold on;
scatter(Res4(:,2), Res4(:,1), 20);

%harris-laplace for checkerboard_tunnel with n=0,5,17

%n=0
Res5 = harris_laplace(I_check, 0, 1.5, 1.2, 0.06, 300);
subplot(ceil(sqrt(3)),ceil(sqrt(2)),1);
imshow(I_check);
hold on;
scatter(Res5(:,2), Res5(:,1), 20);
title('level 0');

%n=5
Res6 = harris_laplace(I_check, 5, 1.5, 1.2, 0.06, 300);
subplot(ceil(sqrt(3)),ceil(sqrt(2)),2);
imshow(I_check);
hold on;
scatter(Res6(:,2), Res6(:,1), 20);
title('level 5');

%n=17
Res7 = harris_laplace(I_check, 17, 1.5, 1.2, 0.06, 300);
subplot(ceil(sqrt(3)),ceil(sqrt(2)),3);
imshow(I_check);
hold on;
scatter(Res7(:,2), Res7(:,1), 20);
title('level 17');