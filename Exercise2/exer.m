I_check = double(imread('checkerboard_tunnel.png'));
I_house = imread('house.png');
I = (checkerboard*255);

for level=0:1
    sigma_init = 1.4;
    sigma_scale = 1.4;
    sigma_i = sigma_scale^level * sigma_init;
    sigma_d = sigma_i*0.7;

    alpha = 0.04;
    threshold = 50;

    figure();
    [r,c,R] = harris(I, 1, 1, alpha, threshold);
    imshow(I);
    hold on;
    scatter(r,c,'r');
end

%corners = detectHarrisFeatures(I,'FilterSize',sigma_d*3);
%plot(corners.selectStrongest(400));
%hold off;
