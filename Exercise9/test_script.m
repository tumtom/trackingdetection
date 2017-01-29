load('An.mat');

I_ref = imread('img_sequence/0000.png');
rect = [
    [100,100];
    [200,100];
    [100,200];
    [200,200];
    ];
rect_v = [rect(:,1)', rect(:,2)']';

grid_dist = 5;
grid_p = get_grid(rect, grid_dist);

ref_iten = itensities(grid_p,I_ref);

%loop for images
for im_num = 1:44    
    I_cur = imread(sprintf('img_sequence/00%2d.png',im_num));
    
    
    %loop for An
    for i=size(Ai,1):1

    %warp grid_p with current parameter vector
    tform = estimateGeometricTransform(p,rect_v,'projective','Confidence',97);

    warped_grid = [];
     for i = 1:size(grid_p)
            p = [grid_p(i,:),1];
            p_t = p*tform.T;
            p_t = p_t ./ p_t(3);
            p_t = round(p_t);
            warped_grid = [warped_grid; [p_t(1,1), p_t(1,2)] ];
     end

    %calc itensities
    cur_iten = itensities(grid_p,I_ref);
    %diff
    diff_iten=cur_iten-ref_iten;
    %parameter update
    d_p = Ai(i)*diff_iten;

    d_p_ = [d_p(1:4,1)'; d_p(5:8,1)'];
    p_ = [p(1:4,1)'; p(5:8,1)'];
    H_c = estimateGeometricTransform(rect, d_p_, 'projective','Confidence',97);
    H_u = estimateGeometricTransform(p_, d_p_, 'projective','Confidence',97);

    H_n = H_c.T*H_u.T;

    rect_new = [];
    for i = 1:size(rect,1)
            p_before = [rect(i,:),1];
            p_after = p_before*H_n;
            p_after = p_after ./ p_after(3);
            p_after = round(p_after);
            rect_new = [rect_new; [p_after(1,1), p_after(1,2)] ];
    end
end

end