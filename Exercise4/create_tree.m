

M = dlmread('trees/Tree0.txt',' ');
numberNodes = M(1,1);
numberLeafes = size(M,1) - numberNodes - 2;
NODES = M([2:(numberNodes+1)], :);
LEAF = M([(numberNodes+3) : size(M,1)], 1:3);
[rows, col] = size(NODES);
tree = {};

for node = 1:rows
    n = Node();
    n.id = NODES(node, 1);
    n.left = NODES(node, 2);
    n.right = NODES(node, 3);
    n.threshold = NODES(node, 4);
    n.x_0 = NODES(node, 5);
    n.y_0 = NODES(node, 6);
    n.z_0 = NODES(node, 7);
    n.x_1 = NODES(node, 8);
    n.y_1 = NODES(node, 9);
    n.z_1 = NODES(node, 10);
    n.box_size = NODES(node, 11);
    tree{node} = n;
end

for leaf=1:numberLeafes
    l=Leaf();
    l.id = LEAF(leaf,1);
    l.p_x = LEAF(leaf,2);
    l.p_y = LEAF(leaf,3);
    tree{numberNodes + leaf} = l;
end

I=imread('2007_000032.jpg');


I_r = I(:,:,1);
I_g = I(:,:,2);
I_b = I(:,:,3);
Int_r = integral_image(I_r);
Int_g = integral_image(I_g);
Int_b = integral_image(I_b);