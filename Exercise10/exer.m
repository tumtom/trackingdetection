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
    
     a = Ic(round(yc-a_rows/2):round(yc+a_rows/2), round(xc-a_cols/2):round(xc+a_cols/2),:);
    I_hsv = rgb2hsv(a);
    H = I_hsv(:, :, 1);
    %bins = colorHist(H, 256);
    P_i = probMap(H, bins);
    
    

while change >= 2 && cur_it <= max_it

    cur_it = cur_it +1;



xc_upper = 0;
yc_upper = 0;
lower = 0;

for r = 1:size(P_i,1)
    for c = 1:size(P_i,2)
        xc_upper = xc_upper + xc * prob(r,c);
        lower = lower + prob(r,c);
        yc_upper = yc_upper + yc * prob(r,c);
    end
end

last_xc = xc;
last_yc = yc;

xc = xc_upper / lower;
yc = yc_upper / lower;

change = sqrt((last_xc - xc)^2 + (last_yc - yc)^2);

 a = I(round(yc-a_rows/2):round(yc+a_rows/2), round(xc-a_cols/2):round(xc+a_cols/2),:);
    I_hsv = rgb2hsv(a);
    H = I_hsv(:, :, 1);
P_i = probMap(H, bins);
end

kdf = 0;

end