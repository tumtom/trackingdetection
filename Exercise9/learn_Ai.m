function[ A_i ] = learn_Ai (grid_dist, max_rand)


I = imread('img_sequence/0000.png');

rect = [
    [100,100];
    [200,100];
    [100,200];
    [200,200];
    ];

%

%grid = zeros( (rect(2,1)-rect(1,1))/grid_dist +1, (rect(3,2)-rect(1,2))/grid_dist +1);
%i=0;
%for y = rect(1,2):grid_dist:rect(3,2)
%    i=i+1;
%    grid(i)=[rect(1,1):grid_dist:rect(2,1);
%        end

num_col = (rect(2,1)-rect(1,1))/grid_dist +1;
num_row = (rect(3,2)-rect(1,2))/grid_dist +1;

grid_p = get_grid( rect );


max_x = max_rand;
max_y = max_rand;

it_diff = [];
P = [];

for n=1:500
    rect_rand = rect;

    for p=1:4
        rect_rand(p,:) = rect_rand(p,:) + [rand()*max_x-(max_x/2), rand()*max_y-(max_y/2)];
    end

    tform = estimateGeometricTransform(rect,rect_rand,'projective','Confidence',97);
    tform2 = estimateGeometricTransform(rect_rand,rect,'projective','Confidence',97);
    warped_grid = [];

    for i = 1:size(grid_p)
        p = [grid_p(i,:),1];
        p_t = p*tform.T;
        p_t = p_t ./ p_t(3);
        p_t = round(p_t);
        warped_grid = [warped_grid; [p_t(1,1), p_t(1,2)] ];
    end

    outputView = imref2d(size(I));
    Ir = imwarp(I, tform, 'OutputView', outputView);

    %% 


    it_warped = itensities(warped_grid,I);
    it_warped = it_warped + rand(1,size(it_warped,1));
    it_ref = itensities(grid_p,I);
    
    it_diff(:,n) = abs(it_ref - it_warped);
    d = rect - rect_rand;
    P(:,n) = [d(:,1)', d(:,2)']';
end


%% 
A_i = P*it_diff'*(it_diff * it_diff')^-1;


end