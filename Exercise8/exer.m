% loading the training sets

load('res/data3.mat')

tr_n = size(dat,1);
weak_learner_n = 3;

samples = dat(:,1:2);

labels = dat(:,3);
labels( (dat(:,3) == 1),1) = 2;
labels((dat(:,3) == -1),1) = 1;

te_labels = labels;

% Displaying the training sets
figure;
hold on; axis square;
indices = labels==1;
plot(samples(indices,1),samples(indices,2),'b*');
indices = ~indices;
plot(samples(indices,1),samples(indices,2),'r*');
title('Training set');

% Training error rates
label_error = zeros(1,weak_learner_n);

for i=1:weak_learner_n
	m = adaboost(@weak_classifier,@testing_weak,samples,labels,i);
    [L_tr,hits,pred_labels] = test(m,@testing_weak,samples,labels);
	label_error(i) = (tr_n-hits)/tr_n;
end

figure;
hold on; axis square;
indices = pred_labels==1;
plot(samples(indices,1),samples(indices,2),'b*');
indices = ~indices;
plot(samples(indices,1),samples(indices,2),'r*');
title('Training set after adaboost');


figure(); 
plot(1:weak_learner_n,label_error);
axis([1,weak_learner_n,0,1]);
title('Training Error');
xlabel('weak classifier number');
ylabel('error rate');
grid on;
