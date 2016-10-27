function v = J ( I,H,x,y )
v=0;
[m, n] = size(H);
middle_rows = ceil(m/2);    %these are redundantly calculated each time the func is called
middle_cols = ceil(n/2);

%in outer loop trough the rows starting with upper row
for i=1:m
    offset_rows = i - middle_rows;
    %loop trough the columns starting at left side
    for j=1:n
        offset_cols = j - middle_cols;
        v = v+H(i,j)*I(x - offset_rows, y - offset_cols);
   end
end

end

