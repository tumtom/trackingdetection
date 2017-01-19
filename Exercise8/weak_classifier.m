function model = weak_classifier(train_set, sample_weights, labels)

model = struct('min_error',[],'min_error_thr',[],'pos_neg',[],'dim',[]);

sample_n = size(train_set,1);
min_error = sum(sample_weights);
min_error_thr = 0;
pos_neg = 'pos';

% for each dimension
for dim=1:size(train_set,2)
	sorted = sort(train_set(:,dim),1,'ascend');

	% for each interval in the specified dimension
	for i=1:(sample_n+1)
        if(i==1)
            thr = sorted(1)-0.5;
        elseif(i==sample_n+1)
            thr = sorted(sample_n)+0.5;
        else
    		thr = (sorted(i-1)+sorted(i))/2;
        end
        
		ind1 = train_set(:,dim) < thr;
		ind2 = ~ind1;
		tmp_err = sum(sample_weights((labels.*ind1)==2)) + sum(sample_weights((labels.*ind2)==1));

		if(tmp_err < min_error)
			min_error = tmp_err;
			min_error_thr = thr;
			pos_neg = 'pos';
			model.dim = dim;
		end

		ind1 = train_set(:,dim) < thr;
        ind2 = ~ind1;
        tmp_err = sum(sample_weights((labels.*ind1)==1)) + sum(sample_weights((labels.*ind2)==2));

		if(tmp_err < min_error)
            min_error = tmp_err;
            min_error_thr = thr;
            pos_neg = 'neg';
			model.dim = dim;
        end
	end
end

model.min_error = min_error;
model.min_error_thr = min_error_thr;
model.pos_neg = pos_neg;

