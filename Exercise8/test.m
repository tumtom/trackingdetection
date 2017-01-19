function [L,hits,pred_labels] = test(adaboost_model,te_func_handle,test_set,...
                                true_labels)
% comment here
%

hypothesis_n = length(adaboost_model.weights);
sample_n = size(test_set,1);
class_n = length(unique(true_labels));
temp_L = zeros(sample_n,class_n,hypothesis_n);		% likelihoods for each weak classifier

% for each weak classifier, likelihoods of test samples are collected
for i=1:hypothesis_n
	[temp_L(:,:,i),hits,error_rate] = te_func_handle(adaboost_model.parameters{i},...
													 test_set,ones(sample_n,1),true_labels);
	temp_L(:,:,i) = temp_L(:,:,i)*adaboost_model.weights(i);
end

L = sum(temp_L,3);
pred_labels = func8(L);
hits = sum(func8(L)==true_labels);

