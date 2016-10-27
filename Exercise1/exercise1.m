%config
H = [[1,1,1];[1,1,1];[1,1,1]];
image_path = 'lena.gif';


%beginning of script

[m,n] = size(H);
I_raw = imread(image_path);

%preparing the image
[w,h] = size(I_raw);
I = zeros(M+w,N+h);

%copy old image in the middle
image_start_row = ceil(m/2);
image_start_col = ceil(n/2);
image_end_row = image_start_row+w;
image_end_col = image_start_col+h;
I(image_start_row:image_end_row-1,image_start_col:image_end_col-1) = I_raw(1:w,1:h);

%create new image
R = zeros(size(I));

%apply filter
for x=image_start_row:image_end_row
    for y=image_start_col:image_end_col
        %needs J.m in same folder
        v=J(I,H,x,y);
        R(x,y)=v;
    end
end