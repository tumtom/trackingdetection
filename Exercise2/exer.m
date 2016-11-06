



I_check = double(imread('checkerboard_tunnel.png'));

I = I_check;
sigma_d = 3;
sigma_i = 3;
alpha = 0.05;
threshold = 1 * 10^7;

corners = harris(I, sigma_d, sigma_i, alpha, threshold);

imagesc(I);
hold on;
plot(corners(:,1),corners(:,2));