%%%%
% selects s points of corresponce points
% takes these points if threshold is >= t
% tries another random set of points if threshold < t
function CorresponseSet = ransac(correspP,s,t_distance,T_set,N_trials)
	largestSetC = [];
	for t=1:N_trials
		%select s random rows of the matrix
		SetP = datasample(correspP,s); 
		%calculate the H matrix
		%H = dlt(SetP);
		H = ones(2);
        SetC = [];
		%check which points go along with our calculated homography
		for i=1:size(correspP,1)
			p2_calc = H * (correspP(i,1:2))';
            p2_sift = correspP(i,3:4)';
			distance = sqrt( (abs(p2_calc(1)-p2_sift(1)))^2 + (abs(p2_calc(2)-p2_sift(2)))^2 );
			if distance <= t_distance		
				%save it
				SetC = [SetC;correspP(i,1:4)];
			end
		end
		if size(SetC,1) >= T_set
			CorresponseSet = SetC;
            return;
		elseif size(SetC,1) > size(largestSetC,2)
			largestSetC = SetC;
	end
	%all trials exceed
	CorresponseSet = largestSetC;
    return;
end
