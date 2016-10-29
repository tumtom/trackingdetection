function [ I, image_start_row, image_end_row, image_start_col, image_end_col ] = extend_image_borders( I_raw, c, method )
%extends the matrix I_raw in size such that kernel c can be applied to all pixels
%therefore the border pixels have to be filled with a value.
%method specifies how to to this:
%   'border_black': use black pixels to fill the sides of the bigger array
%   'border_extend': extend border pixels to all sides
%   'border_mirror': extend borders by mirroring the image across the
%   border
%returns: 
%   new matrix I
%   the position of the old image in the new matrix: image_start_row, image_end_row, image_start_col, image_end_col

[m,n] = size(c);

border_size_rows = floor(m/2);
border_size_cols = floor(n/2);

%preparing the image
[r,c] = size(I_raw);

I = zeros(r+2*border_size_rows,c+2*border_size_cols);
[I_rows,I_cols] = size(I);

%some variables that tell us where the old image is in the new matrix
image_start_row = border_size_rows+1;
image_start_col = border_size_cols+1;
image_end_row = border_size_rows+r;
image_end_col = border_size_cols+c;

%copy old image in the middle
I(image_start_row:image_end_row,image_start_col:image_end_col) = I_raw(1:r,1:c);

switch method
    case 'border_black'
        %nothing to do
    case 'border_extend'
        %left side
        left_side = repmat(I_raw(:,1),1,border_size_cols);  
        %right side
        right_side = repmat(I_raw(:,c),1,border_size_cols);   
        %top side
        top = repmat(I_raw(1,:),border_size_rows,1);
        %bottom side
        bottom = repmat(I_raw(r,:),border_size_rows,1);
        %assign
        I(1:border_size_rows,image_start_col:image_end_col) = top;
        I(image_start_row:image_end_row,1:border_size_cols) = left_side;
         I(image_start_row:image_end_row,image_end_col+1:image_end_col+border_size_cols) = right_side;
        I(image_end_row+1:image_end_row+border_size_rows,image_start_col:image_end_col) = bottom;
        %now for the corners
        %left upper corner
        I(1:image_start_row,1:image_start_col) = I_raw(1,1);
        %left lower corner
        I(image_end_row:I_rows,1:image_start_col) = I_raw(r,1);
        %right upper corner
        I(1:image_start_row,image_end_col:I_cols) = I_raw(1,c);
        %right lower corner
        I(image_end_row:I_rows,image_end_col:I_cols) = I_raw(r,c);       
    case 'border_mirror'
        left_side = fliplr(I_raw(:,1:border_size_cols));
        right_side = fliplr(I_raw(:,(c-border_size_cols)+1:c));
        bottom = flipud(I_raw((r-border_size_rows)+1:r,:));
        top = flipud(I_raw(1:border_size_rows,:));
         %assign
        I(1:border_size_rows,image_start_col:image_end_col) = top;
        I(image_start_row:image_end_row,1:border_size_cols) = left_side;
        I(image_start_row:image_end_row,image_end_col+1:image_end_col+border_size_cols) = right_side;
        I(image_end_row+1:image_end_row+border_size_rows,image_start_col:image_end_col) = bottom;
        %now for the corners
        %left upper corner
        I(1:image_start_row-1,1:image_start_col-1) = flipud(left_side(1:border_size_rows,1:border_size_cols));
        %left lower corner
        I(image_end_row+1:I_rows,1:image_start_col-1) = fliplr(bottom(1:border_size_rows,1:border_size_cols));
        %right upper corner
        I(1:image_start_row-1,image_end_col+1:I_cols) = flipud(right_side(1:border_size_rows,1:border_size_cols));
        %right lower corner
        bflp = fliplr(bottom);  %for the bottom corner, we have to first flip it and then cut out the piece
        I(image_end_row+1:I_rows,image_end_col+1:I_cols) = bflp(1:border_size_rows,1:border_size_cols);  
    otherwise
        print('undefined method');
end

