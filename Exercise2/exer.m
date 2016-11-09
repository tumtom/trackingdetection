I_check = double(imread('checkerboard_tunnel.png'));
I_house = imread('house.png');
I = (checkerboard*255);

maxLevel = 4;

for level=0:maxLevel
    sigma_init = 1;
    sigma_scale = 1.4;
    sigma_i = sigma_scale^level * sigma_init;
    sigma_d = sigma_i*0.7;

    alpha = 0.04;
    threshold = 50;

    [r,c,R] = harris(I, sigma_d, sigma_i, alpha, threshold);
    subplot(ceil(sqrt(maxLevel+1)),ceil(sqrt(maxLevel)),level+1);
    imshow(I);
    hold on;
    scatter(r,c,'r');
    hold off;
    t = sprintf('level: %d, sigma_d:%f, sigma_i:%f',level,sigma_d,sigma_i);
    title(t);
end

%corners = detectHarrisFeatures(I,'FilterSize',sigma_d*3);
%plot(corners.selectStrongest(400));
%hold off;
