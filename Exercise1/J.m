function v = J ( I,H,x,y )
v=0;
[m, n] = size(H);
middle_rows = ceil(m/2);
middle_cols = ceil(n/2);

%in outer loop the rows starting upper row
for i=1:m
    offset_rows = i - middle_rows;
    %loop trough the columns starting left
    for j=1:n
        offset_cols = j - middle_cols;
        v = v+H(i,j)*I(x - offset_rows, y - offset_cols);
   end
end

end

