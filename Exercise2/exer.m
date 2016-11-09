I_check = double(imread('checkerboard_tunnel.png'));
I_house = imread('house.png');
I = I_check;

maxLevel = 3;

R_levels = {};

for level=0:maxLevel
    sigma_init = 1.5;
    sigma_scale = 1.2;
    sigma_i = sigma_scale^level * sigma_init;
    sigma_d = sigma_i*0.7;

    alpha = 0.06;
    threshold = 500;

    [r,c,R] = harris(I, sigma_d, sigma_i, alpha, threshold);
    R_levels{level+1}=[r,c];
    
    subplot(ceil(sqrt(maxLevel+1)),ceil(sqrt(maxLevel)),level+1);
    imshow(I);
    hold on;
    scatter(r,c,'r');
    hold off;
    t = sprintf('level: %d, sigma_d:%f, sigma_i:%f',level,sigma_d,sigma_i);
    title(t);
end

min_occurance = 2;
Result = [];
R_temp = R_levels{:};
unique_pairs = unique(R_temp,'rows');
for i=1:size(unique_pairs,1)
    r=unique_pairs(i,1);
    c=unique_pairs(i,2);
    max=-1;
    sigma_max=0;
    occurance = 0;
    for level=0:maxLevel
        a = ismember([r,c],R_levels{level+1});
        if (a(1) && a(2))
            occurance = occurance + 1;
            sigma_init = 1;
            sigma_scale = 1.4;
            sigma_i = sigma_scale^level * sigma_init;
            log = LoG(I,r,c,sigma_i);
            if log > max
                max=log;
                sigma_max=sigma_i;
            end
        end
    end
    if occurance >= min_occurance
        Result = [Result;[r,c,max,sigma_max]];
    end
end
            
%corners = detectHarrisFeatures(I,'FilterSize',sigma_d*3);
%plot(corners.selectStrongest(400));
%hold off;
