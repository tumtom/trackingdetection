function [haarFeat,haarFeatResponse] = readin_classifiers()
global I;

Image = imread('res/faceA.jpg');
I = integral_image(Image);
%read classifiers
load('res/Classifiers.mat');
haarFeat = {};
haarFeatResponse = {};
for i = 2:size(classifiers,2)
    haarFeat{i} = HaarFeatures(classifiers(:,i));
    haarFeatResponse{i} = haarFeat{i}.HaarFeaturesCompute();
end

end
