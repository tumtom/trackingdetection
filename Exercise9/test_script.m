load('An.mat');

I_ref = imread('img_sequence/0000.png');
rect = [
    [100,100];
    [200,100];
    [100,200];
    [200,200];
    ];

grid_p = get_grid(rect);
