function [detect] = hog(I_ex, I_ob, cellSize, scale)

object_hog = vl_hog(I_ob,8);

detect = detectAtMultipleScales(I_ex,object_hog,cellSize,[1:scale]);

detect(4,1) = detect(4,1) - detect(2,1);
detect(3,1) = detect(3,1) - detect(1,1);

end