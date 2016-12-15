%use results of exer.m
%run('exer.m');

function [ms, A, Ms] = exer2()

    [I_0, A, M, d_obj_points, obj_points] = exer();

    nrImages = 44;

    ms = {};
    Ms = {};

    %loop trough all images
    for i=1:nrImages
        I_i_raw = imread(strcat('img_sequence/',num2str(i,'%04d'),'.png'));
        I_i = single(rgb2gray(I_i_raw));
        [fs, ds] = vl_sift(I_i);
        [matches, scores] = vl_ubcmatch(d_obj_points, ds);
        tform = estimateGeometricTransform(fs(1:2,matches(2,:))',obj_points(:,matches(1,:))','projective','Confidence',97);
        outputView = imref2d(size(I_0));
        Ir = imwarp(I_i_raw, tform, 'OutputView', outputView);
        %save it to a folder called results (should exist!)
        imwrite(Ir,strcat('results/restored_',num2str(i,'%04d'),'.png'));

        mi =  fs(1:2,matches(2,:));
        c = obj_points(:,matches(1,:));
        mh = ones(3, size(mi, 2));

        mh(1:2, :) = mi;
        ms{i} = mh;
        
        Ms{i} = M(:, matches(1,:));
    end

end