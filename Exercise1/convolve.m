function [ RES ] = convolve( I_raw, H, method )
%Uses the Kernel H to calculate the convulation across each pixel of Image I_raw.
%Border treatment can be selected with method:
%   'border_black': use black pixels to fill the sides of the bigger array
%   'border_extend': extend border pixels to all sides
%   'border_mirror': extend borders by mirroring the image across the
%Returns the resulting image RES with the kernel applied.

%preparing the image
%needs extend_image_borders.m in same folder
[I, image_start_row, image_end_row, image_start_col, image_end_col] = extend_image_borders(I_raw, H, method);

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


end

