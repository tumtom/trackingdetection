I=imread('sequence/2043_000140.jpeg');


a = I(308:346,505:555, :);

a_rows = 346-308;
a_cols = 555-505;
x = round(a_cols/2)+505;
y = round(a_rows/2)+308;

I_hsv = rgb2hsv(a);
H = I_hsv(:, :, 1);

bins = colorHist(H, 256);

prob = probMap(H, bins);

%loop here

max_it = 20;
cur_it = 1;
change = 50;
xc = x;
yc = y;
num_images = 50;

for i=1:num_images
    Ic = imread(sprintf('sequence/2043_0001%2d.jpeg',40+i));
    
    a = Ic(308:346,505:555,:);
    I_hsv = rgb2hsv(a);
    H = I_hsv(:, :, 1);
    %bins = colorHist(H, 256);
    P_i = probMap(H, bins);
    
    f=figure();
    mesh(P_i);
    hold off;
    saveas(f,sprintf('prob_dist/pd_%2d.jpeg',i));
end