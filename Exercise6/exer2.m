%use results of exer.m
run('exer.m');

nrImages = 44;

%loop trough all images
for i=1:nrImages
    I_i_raw = imread(strcat('img_sequence/',num2str(i,'%04d'),'.png'));
    I_i = single(rgb2gray(I_i_raw));
    [fs, ds] = vl_sift(I_i);
    [matches, scores] = vl_ubcmatch(d_obj_points, ds);
    tform = estimateGeometricTransform(fs(1:2,matches(2,:))',obj_points(:,matches(1,:))','projective','Confidence',97);
    matched_points = obj_points(:,matches(1,:))';
    X = transformPointsInverse(tform,matched_points)
    f=figure();
    imshow([I_0_raw,I_i_raw]);
    hold on;
    for k=1:size(matched_points,1)
       h = line([matched_points(k,1),(X(k,1)+size(I_0_raw,2))],[matched_points(k,2),X(k,2)])
       set(h,'linewidth', 1, 'color', 'b') ;
    end
    saveas(f,strcat('results/matches_',num2str(i,'%04d'),'.png'))
    outputView = imref2d(size(I_0));
    Ir = imwarp(I_i_raw, tform, 'OutputView', outputView);
    %save it to a folder called results (should exist!)
    imwrite(Ir,strcat('results/restored_',num2str(i,'%04d'),'.png'));
end