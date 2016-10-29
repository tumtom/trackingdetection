%kernel
H = [
    [1,1,1];
    [1,1,1];
    [1,1,1]
    ];
MeanFilterKernel = 1/9 * H;
%some interesting kernels at http://setosa.io/ev/image-kernels/

%image path
image_path = 'lena.gif';

%load image
[I_raw,I_raw_cm] = imread(image_path);

%call our convolution function
RES = convolve(I_raw,MeanFilterKernel,'border_mirror');

%show the result with the colormap of the original image
subplot(1,2,1);
imshow(I_raw,I_raw_cm);
title('original');
subplot(1,2,2);
imshow(RES,I_raw_cm);
title('convolution');
