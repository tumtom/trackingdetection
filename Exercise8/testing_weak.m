function [L,hits,error_rate] = testing_weak(model,test_set,sample_weights,true_labels)


feat = test_set(:,model.dim);
if(strcmp(model.pos_neg,'pos'))
	ind = (feat>model.min_error_thr)+1;
else
	ind = (feat<model.min_error_thr)+1;
end

hits = sum(ind==true_labels);
error_rate = sum(sample_weights(ind~=true_labels));

L = zeros(length(feat),2);
L(ind==1,1) = 1;
L(ind==2,2) = 1;

