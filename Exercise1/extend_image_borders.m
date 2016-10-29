function [ I, image_start_row, image_end_row, image_start_col, image_end_col ] = extend_image_borders( I_raw, H, method )
%extends the matrix I_raw in size such that kernel H can be applied to all pixels
%therefore the border pixels have to be filled with a value.
%method specifies how to to this:
%   'border_black': use black pixels to fill the sides of the bigger array
%   'border_extend': extend border pixels to all sides
%   'border_mirror': tbd
%returns: 
%   new matrix I
%   the position of the old image in the new matrix: image_start_row, image_end_row, image_start_col, image_end_col

[m,n] = size(H);

%preparing the image
[w,h] = size(I_raw);
I = zeros(m+w,n+h);

%some variables that tell us where the old image is in the new matrix
image_start_row = ceil(m/2);
image_start_col = ceil(n/2);
image_end_row = image_start_row+w-1;
image_end_col = image_start_col+h-1;

%copy old image in the middle
I(image_start_row:image_end_row,image_start_col:image_end_col) = I_raw(1:w,1:h);

switch method
    case 'border_black'
        %nothing to do
    case 'border_extend'
        border_size_left = image_start_col - 1;
        border_size_top = image_start_row - 1;
        border_size_right = n+h - image_end_col;
        border_size_bottom = m+w - image_end_row;
        %left side
        left_side = repmat(I_raw(:,1),1,border_size_left);
        I(image_start_row:image_end_row,1:border_size_left) = left_side;
        %right side
        right_side = repmat(I_raw(:,h),1,border_size_right);
        I(image_start_row:image_end_row,image_end_col+1:image_end_col+border_size_right) = right_side;
        %top side
        top = repmat(I_raw(1,:),border_size_top,1);
        I(1:border_size_top,image_start_col:image_end_col) = top;
        %bottom side
        bottom = repmat(I_raw(w,:),border_size_bottom,1);
        I(image_end_row+1:image_end_row+border_size_bottom,image_start_col:image_end_col) = bottom;
        %now for the corners
        %left upper corner
        I(1:image_start_row,1:image_start_col) = I_raw(1,1);
        %left lower corner
        I(image_end_row:m+w,1:image_start_col) = I_raw(w,1);
        %right upper corner
        I(1:image_start_row,image_end_col:n+h) = I_raw(1,h);
        %right lower corner
        I(image_end_row:m+w,image_end_col:n+h) = I_raw(w,h);        
    otherwise
        print('undefined method');
end

