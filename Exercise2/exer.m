



I_check = double(imread('check.png'));

I = I_check;
sigma_d = 1;
sigma_i = 3;
alpha = 0.04;
threshold = 1 * 10^7;
N = 50;

%corners = harris(I, sigma_d, sigma_i, alpha, threshold);
corners = moment_matrix( I, 0, 0, alpha, sigma_d, sigma_i);
imshow(corners);

%50 largest
%[corners_sorted,corners_pos] = sort(abs(corners(:)),'descend');
%largest = corners_sorted(1:N);
%largest_pos = corners_pos(1:N);
%imagesc(I);
%hold on;
%for i=1:N
%    [x,y] = ind2sub(size(corners),largest_pos(i));
%    s=scatter(x,y,50);
%end
%hold off;

%matlab harris
%corners = detectHarrisFeatures(I);
%imshow(I); hold on;
%plot(corners.selectStrongest(50));


%plot(corners(:,1),corners(:,2));