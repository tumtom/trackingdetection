%% task 1 - convolution and mean filter

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
MeanFilter = convolve(I_raw,MeanFilterKernel,'border_mirror');

%show the result with the colormap of the original image
subplot(1,2,1);
imshow(I_raw,I_raw_cm);
title('original');
subplot(1,2,2);
imshow(MeanFilter,I_raw_cm);
title('convolution');

imwrite(MeanFilter,I_raw_cm,'Mean.png');

%% Task 2 - Gaussian Filter


sigma = 1.0;
GaussianFilterKernel_Sigma1 = CreateGaussian(sigma);
sigma = 3.0;
GaussianFilterKernel_Sigma3 = CreateGaussian(sigma);
Gauss_Sigma1 = convolve(I_raw,GaussianFilterKernel_Sigma1,'border_mirror');
start_2D = tic;
Gauss_Sigma3 = convolve(I_raw,GaussianFilterKernel_Sigma3,'border_mirror');
time_2D = toc(start_2D);
imwrite(Gauss_Sigma1,I_raw_cm,'Gauss1.png')
imwrite(Gauss_Sigma3,I_raw_cm,'Gauss3.png')

sigma = 1.0;
GaussianFilterKernel1D_Sigma1 = CreateGaussian1D(sigma).';
sigma = 3.0;
GaussianFilterKernel1D_Sigma3 = CreateGaussian1D(sigma);
start_1D = tic;
Gauss_Sigma1 = convolve(I_raw,GaussianFilterKernel1D_Sigma1,'border_mirror');
Gauss_Sigma13 = convolve(Gauss_Sigma1,GaussianFilterKernel1D_Sigma3,'border_mirror');
time_1D = toc(start_1D);
imwrite(Gauss_Sigma13,I_raw_cm,'Gauss1D_13.png')

%% task 3 - gradient

[magnitude,orientation] = gradient(I_raw);
imwrite(orientation,'Gradient_orient_2.png');
magnitude =  (256 / max(max(magnitude)) - min(min(magnitude))) * (magnitude - min(min(magnitude))); 
orientation =  (256 / max(max(orientation)) - min(min(orientation))) * (orientation + pi/2); 
imwrite(magnitude,I_raw_cm,'Gradient_mag.png');
imwrite(orientation,I_raw_cm,'Gradient_orient.png');


D_x = [[-1,0,1];[-1,0,1];[-1,0,1]];

G_x = convolve(GaussianFilterKernel_Sigma3, D_x, 'border_mirror');
I1 = convolve(I_raw,G_x, 'border_mirror');
I1 = convolve(I1,D_x, 'border_mirror');
imwrite(I1,I_raw_cm,'Gradient_w_Gauss3.png');

G_x = convolve(GaussianFilterKernel_Sigma3, D_x, 'border_mirror');
G_x_D_x = convolve(G_x,D_x, 'border_mirror');
I2 = convolve(I1,G_x_D_x, 'border_mirror');
imwrite(I2,I_raw_cm,'Gradient_w_Gauss3_2.png');