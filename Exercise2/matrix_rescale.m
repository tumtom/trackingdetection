function newmat = matrix_rescale(mat,new_min,new_max)

scale_positive = new_max/max(mat(:));
scale_negative = abs(new_min/min(mat(:)));
newmat = mat;
newmat(mat < 0) = mat(mat < 0) .* scale_negative;
newmat(mat > 0) = mat(mat > 0) .* scale_positive;

end


