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

p = rect;

rect_new = [];

%loop for images
for im_num = 1:44  
    if (im_num < 10)
        I_cur = imread(sprintf('img_sequence/000%d.png',im_num));
    else
        I_cur = imread(sprintf('img_sequence/00%d.png',im_num));
    end
    %loop for An
    for i=size(Ai,2):-1:1

        %warp grid_p with current parameter vector
        tform = estimateGeometricTransform(p,rect,'projective','Confidence',97);

        warped_grid = [];
         for k = 1:size(grid_p)
                p = [grid_p(k,:),1];
                p_t = p*tform.T;
                p_t = p_t ./ p_t(3);
                p_t = round(p_t);
                warped_grid = [warped_grid; [p_t(1,1), p_t(1,2)] ];
         end

        %calc itensities
        cur_iten = itensities(grid_p,I_cur);
        %diff
        diff_iten=cur_iten-ref_iten;
        %parameter update
        %diff_iten - row
        d_p = Ai(i)*diff_iten';
        %d_p - col
        
        d_p_ = [d_p(1:4,1)'; d_p(5:8,1)'];
        p_ = [p(1:4,1)'; p(5:8,1)'];
        H_c = estimateGeometricTransform(rect, d_p_, 'projective','Confidence',97);
        H_u = estimateGeometricTransform(p_, d_p_, 'projective','Confidence',97);

        H_n = H_c.T*H_u.T;

        for j = 1:size(rect,1)
                p_before = [rect(j,:),1];
                p_after = p_before*H_n;
                p_after = p_after ./ p_after(3);
                p_after = round(p_after);
                rect_new = [rect_new; [p_after(1,1), p_after(1,2)] ];
        end
    end
    
    rect_new
    p = rect_new;

end