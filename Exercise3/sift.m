function [] = sift( Ia, Ib, edge, peak)

pfx = fullfile(vl_root,'figures','demo') ;
randn('state',0) ;
rand('state',0) ;

f = figure(1) ; 
clf ;

[fa,da] = vl_sift(im2single(rgb2gray(Ia)),'edgethresh', edge, 'PeakThresh', peak) ;
[fb,db] = vl_sift(im2single(rgb2gray(Ib)), 'edgethresh', edge, 'PeakThresh', peak) ;
imshow(Ib);
hold on;
vl_plotframe(fb(:,:)) ;

% Output file path
%resultImagePath = '/home/katerina/myDocuments/Uni/TUM/Tracking&Detection/exercises/pot2_features.jpg';

% Save output images
%saveas(f, resultImagePath, 'jpg');

[matches, scores] = vl_ubcmatch(da,db) ;

[drop, perm] = sort(scores, 'descend') ;
matches = matches(:, perm) ;
scores  = scores(perm) ;

f = figure(1) ; clf ;
imagesc(cat(2, Ia, Ib)) ;
axis image off ;
%vl_demo_print('sift_match_1', 1) ;

f2 = figure(2) ; clf ;
imagesc(cat(2, Ia, Ib)) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(Ia,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

[s1, s2] = size(matches);
if (s2 >= 4)
    [tform,p_a,p_b] = estimateGeometricTransform([xa;ya]',[xb;yb]','projective');

    xa = p_a(:,1)';
    xb = p_b(:,1)';
    ya = p_a(:,2)';
    yb = p_b(:,2)';
end

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
vl_plotframe(fb(:,matches(2,:))) ;
axis image off ;

box = minBoundingBox(p_b');
line(box(1,:),box(2,:),'LineWidth',2,'color','r');
line(box(1,[1,4]),box(2,[1,4]),'LineWidth',2,'color','r');

box2 = minBoundingBox(p_a');
line(box2(1,:),box2(2,:),'LineWidth',2,'color','r');
line(box2(1,[1,4]),box2(2,[1,4]),'LineWidth',2,'color','r');

% Output file path
%resultImagePath = '/home/katerina/myDocuments/Uni/TUM/Tracking&Detection/exercises/pot2_sift.jpg';

% Save output images
%saveas(f2, resultImagePath, 'jpg');

close(f);
close(f2);

end
