% SIFT
% Shell 1

Ia = im2single(imread('shell.jpg'));
Ib = im2single(imread('test_shell1_scaled.jpg'));

sift( Ia, Ib, 8, 0);

% Shell 2

Ia = im2single(imread('shell.jpg'));
Ib = im2single(imread('test_shell2_scaled.jpg'));

sift( Ia, Ib, 8, 0);

% Pot 1

Ia = im2single(imread('pot.jpg'));
Ib = im2single(imread('test_pot1_scaled.jpg'));

sift( Ia, Ib, 8, 0);

% Pot 2

Ia = im2single(imread('pot.jpg'));
Ib = im2single(imread('test_pot2_scaled.jpg'));

sift( Ia, Ib, 8, 0);

%HOG
% % Shell 1

Ia = im2single(imread('shell_small.jpg'));
Ib = im2single(imread('test_shell1_small.jpg'));

detect = hog(Ib, Ia, 2, 4)

f20 = figure(20);
imshow(Ib);
hold on;

rectangle('Position',detect);

saveas(f20, 'shell1_hog', 'jpg');

% Shell 2
% 
Ia = im2single(imread('shell_small.jpg'));
Ib = im2single(imread('test_shell2_small.jpg'));

hog( Ib, Ia, 2, 4);

f21 = figure(21);
imshow(Ib);
hold on;

rectangle('Position',detect);

saveas(f21, 'shell2_hog', 'jpg');

% Pot 1

Ia = im2single(imread('pot_small.jpg'));
Ib = im2single(imread('test_pot1_small.jpg'));

hog( Ib, Ia, 2, 4);

f22 = figure(22);
imshow(Ib);
hold on;

rectangle('Position',detect);

saveas(f22, 'pot1_hog', 'jpg');

% Pot 2

Ia = im2single(imread('pot_small.jpg'));
Ib = im2single(imread('test_pot2_small.jpg'));

hog( Ib, Ia, 2, 4);

f23 = figure(23);
imshow(Ib);
hold on;

rectangle('Position',detect);

saveas(f23, 'pot2_hog', 'jpg');