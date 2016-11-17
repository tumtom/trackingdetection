%hog

Ia = im2single(imread('pot.jpg'));
Ib = im2single(imread('test_pot1_scaled.jpg'));

cellSize = 8 ;
fa = vl_hog(Ia, cellSize, 'verbose') ;
fb = vl_hog(Ib, cellSize, 'verbose') ;

w=zeros(0,0,0,0);
%
w(:,:,:,1)=fa(:,:,:);
res = vl_nnconv(fb,w,[]);

figure(2) ; clf ; vl_imarraysc(res) ; colormap gray ;

[best,bestIndex] = max(res(:));

[hy,hx] = ind2sub(size(res),bestIndex);

x = (hx-1) * cellSize +1;
y = (hy-1) * cellSize +1;

modelWidth = size(fa, 2);
modelHeight = size(fa, 1);



vl_plotbox()

imshow(Ib);
hold on;
rectangle('Position',[x,y,modelWidth,modelHeight]);