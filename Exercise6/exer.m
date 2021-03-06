function [I_0, A, M, d_obj_points, obj_points] = exer()
    I_0 = single(rgb2gray(imread('img_sequence/0000.png')));

    A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];

    %run('/home/tom/ownCloud/Skripte/Master/Semester3_WS1617/TrackingDetection/Excercises/Exercise3/vlfeat/toolbox/vl_setup.m')
    run('/home/katerina/myDocuments/Uni/TUM/Tracking&Detection/exercises/vlfeat-0.9.20/toolbox/vl_setup.m');

    [fs, ds] = vl_sift(I_0);
    points = [];
    points(1,:) = round(fs(1,:));
    points(2,:) = round(fs(2,:));
    obj_points=[];
    d_obj_points=[];
    for i=1:size(points,2)
        if points(1,i) > 95 && points(1,i) < 557 && points(2,i) > 65 && points(2,i) < 390
            obj_points=[obj_points,points(:,i)];
            d_obj_points=[d_obj_points,ds(:,i)];
        end
    end

    obj_points_hom = ones(3, size(obj_points,2));
    obj_points_hom(1:2, :) = obj_points;

    M = A^(-1)*obj_points_hom;
end

