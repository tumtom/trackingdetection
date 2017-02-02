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

max_it = 20;
xc = x;
yc = y;
num_images = 50;

for i=1:num_images
    Ic = imread(sprintf('sequence/2043_0001%2d.jpeg',40+i));
    change = 50;
    cur_it = 1;
    x_min = round(xc-a_cols/2);
    x_max = round(xc+a_cols/2);
    y_min = round(yc-a_rows/2);
    y_max = round(yc+a_rows/2);
    
    a = Ic(y_min:y_max, x_min:x_max, :);
    I_hsv = rgb2hsv(a);
    H = I_hsv(:, :, 1);
    %bins = colorHist(H_prev, 256);
    P_i = probMap(H, bins);
    
    f=figure;
    subplot(2,2,1);
    imshow(a);
    subplot(2,2,2);
    mesh(P_i);
    
    

while change >= 2 && cur_it <= max_it

    cur_it = cur_it +1;
    xc_upper = 0;
    yc_upper = 0;
    lower = 0;

for x_i = x_min:x_max
    for y_i = y_min:y_max    
        xc_upper = xc_upper + x_i * P_i(y_i-y_min+1,x_i-x_min+1);
        lower = lower + P_i(y_i-y_min+1,x_i-x_min+1);
        yc_upper = yc_upper + y_i * P_i(y_i-y_min+1,x_i-x_min+1);
    end
end

    last_xc = xc;
    last_yc = yc;

    xc = xc_upper / lower;
    yc = yc_upper / lower;
    
    [xc,yc,P_i(20,20)]
    
    
    x_min = round(xc-a_cols/2);
    x_max = round(xc+a_cols/2);
    y_min = round(yc-a_rows/2);
    y_max = round(yc+a_rows/2);

    change = sqrt((last_xc - xc)^2 + (last_yc - yc)^2);

    a = Ic(y_min:y_max, x_min:x_max,:);
    I_hsv = rgb2hsv(a);
    H = I_hsv(:, :, 1);
    P_i = probMap(H, bins);
end

%f=figure;
subplot(2,2,3);
imshow(Ic);
hold on;

p1 = [y_min, x_min];
p2 = [y_min, x_max];
p3 = [y_max, x_min];
p4 = [y_max, x_max];

plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','r','LineWidth',2);
plot([p2(2),p4(2)],[p2(1),p4(1)],'Color','r','LineWidth',2);
plot([p4(2),p3(2)],[p4(1),p3(1)],'Color','r','LineWidth',2);
plot([p3(2),p1(2)],[p3(1),p1(1)],'Color','r','LineWidth',2);

scatter(xc,yc);
saveas(f,sprintf('res_tracking/rt_%02d.jpeg',i));

hold off;

kdf = 0;

end