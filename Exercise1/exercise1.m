%kernel
H = [
    [0,0,0];
    [0,0,0];
    [0,1,0];
    [0,0,0];
    [0,0,0]
    ];
%image path
image_path = 'lena.gif';


%beginning of script

[m,n] = size(H);
[I_raw,I_raw_cm] = imread(image_path);

%preparing the image
%needs extend_image_borders.m in same folder
[I, image_start_row, image_end_row, image_start_col, image_end_col] = extend_image_borders(I_raw, H, 'border_mirror');

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

%remove the added border 
RES = zeros(size(I_raw));
RES(1:size(I_raw,1),1:size(I_raw,2)) = R(image_start_row:image_end_row,image_start_col:image_end_col);

%show the result
imshow(RES,I_raw_cm);