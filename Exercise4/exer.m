function exer()

I=imread('2007_000032.jpg');
[I_rows,I_cols,I_colors] = size(I);


I_r= integral_image(I(:,:,1));
I_g= integral_image(I(:,:,2));
I_b= integral_image(I(:,:,3));



%result will be stored here
Votes_p_x = zeros(I_rows,I_cols);
Votes_p_y = zeros(I_rows,I_cols);

%path to the tree txt files, without increasing number and .txt extension
treesFilesPath='trees/Tree';
%how many files 0...maxTreeFiles-1
maxTreeFiles=10;

trees = {};
numberNodes = zeros(1,maxTreeFiles+1);

for t=1:maxTreeFiles
     [trees{t},numberNodes(t)] = create_tree (strcat(treesFilesPath,num2str(t-1),'.txt'));
end
%% 


%for every pixel in the image x,y
for x=1:I_rows
    disp(x);
    for y=1:I_cols
        p_x = zeros(1,maxTreeFiles);
        p_y = zeros(1,maxTreeFiles);
        %for every tree that we have
        for t=10:maxTreeFiles
            %access current tree via trees(t) and all index > numberNodes(t) are leafes
            tree = trees{t};
            tree_max_node = numberNodes(t); 
            %loop trough the tree nodes
            next_index = 1; %id 0
            while (next_index > 0)
                %we have a node. so perform test 
                n = tree{next_index};
                box_compare = b(x+n.x_0,y+n.y_0,n.z_0,n.box_size) - b(x+n.x_1,y+n.y_1,n.z_1,n.box_size);
                if (box_compare < n.threshold)
                    next_index = con.left+1;    %go to the left child node
                else
                    next_index = n.right+1;   %go to the right child node
                end
            end
            %we ended at a leaf. which class did this pixel end in?
            l = tree{tree_max_node+abs(next_index)+1};
            p_x(t) = l.p_x;
            p_y(t) = l.p_y;
        end
    %we went trough all trees. now calculate the mean of all votes
    Votes_p_x(x,y) = sum(p_x) / (maxTreeFiles);
    Votes_p_y(x,y) = sum(p_y) / (maxTreeFiles);
    %disp([Votes_p_x(x,y),Votes_p_y(x,y)]);
    end
end

%now we can plot Votes_p_x and Votes_p_y ...

%% 

Heatmap = zeros(I_rows,I_cols);
for x=1:I_rows
    for y=1:I_cols
        Heatmap(h(x+Votes_p_x(x,y),y+Votes_p_y(x,y))) = Heatmap(h(x+Votes_p_x(x,y),y+Votes_p_y(x,y))) +1;
    end
end
imshow(Heatmap);
imagesc(Heatmap);


    function res = b(x, y, z_i, s )        
        if (z_i == 0)
            I_x = I_b;
        elseif (z_i == 1)
            I_x = I_g;
        else
            I_x = I_r;
        end
        D = I_x(h_y(y+s),h_x(x+s));
        C =  I_x(h_y(y+s),h_x(x-s));
        B = I_x(h_y(y-s),h_x(x+s));
        A = I_x(h_y(y-s),h_x(x-s));
        res = 1/(2*s+1)^2 * ( D - C - B + A );

    end

    %is x, but are cols!
    function x_limited=h_x(this_x) 
        x_limited = max(min(this_x,I_cols),1);
    end

    function y_limited=h_y(this_y)
        y_limited = max(min(this_y,I_rows),1);
    end

    function [x_limited,y_limited] = h(this_x,this_y)
        x_limited = max(min(floor(this_x),I_rows),1);
        y_limited = max(min(floor(this_y),I_cols),1);
    end


end

