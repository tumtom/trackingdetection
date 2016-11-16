pfx = fullfile(vl_root,'figures','demo') ;
randn('state',0) ;
rand('state',0) ;
figure(1) ; clf ;

% --------------------------------------------------------------------
%                                                    Create image pair
% --------------------------------------------------------------------

Ia = imread('pot.jpg');
Ib = imread('test_pot2_scaled.jpg');


% --------------------------------------------------------------------
%                                           Extract features and match
% --------------------------------------------------------------------

[fa,da] = vl_sift(im2single(rgb2gray(Ia))) ;
[fb,db] = vl_sift(im2single(rgb2gray(Ib))) ;


[matches, scores] = vl_ubcmatch(da,db) ;

[drop, perm] = sort(scores, 'descend') ;
matches = matches(:, perm) ;
scores  = scores(perm) ;

figure(1) ; clf ;
imagesc(cat(2, Ia, Ib)) ;
axis image off ;
%vl_demo_print('sift_match_1', 1) ;

figure(2) ; clf ;
imagesc(cat(2, Ia, Ib)) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(Ia,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

[tform,p_a,p_b] = estimateGeometricTransform([xa;ya]',[xb;yb]','similarity');

%showMatchedFeatures(Ia,Ib,fa,fb);

xa = p_a(:,1)';
xb = p_b(:,1)';
ya = p_a(:,2)';
yb = p_b(:,2)';

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
vl_plotframe(fb(:,matches(2,:))) ;
axis image off ;

box = minBoundingBox(p_b');
%scatter(box(1,:),box(2,:),50);
line(box(1,:),box(2,:),'LineWidth',5,'color','r');
line(box(1,[1,4]),box(2,[1,4]),'LineWidth',5,'color','r');
%vl_demo_print('sift_match_2', 1) ;