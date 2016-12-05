%%%%
% selects s points of corresponce points
% takes these points if threshold is >= t
% tries another random set of points if threshold < t
function x = ransac(correspP,s,t_distance,T_set,N_trials)
	largestSetC = [];
	for t=1:N_trials
		%select s random rows of the matrix
		SetP = datasample(correspP,s); 
		%calculate the H matrix
		H = dlt(SetP);
		SetC = [];
		%check which points go along with our calculated homography
		for i=1:size(correspP,2)
			x2 = H * correspP(i,1);
			distance = %calculate the euklidean distance between the two points x2 and correspP(i,2)?
			if distance <= t_distance		
				%save it
				SetC = [SetC;correspP(i)];
			end
		end
		if size(SetC,2) >= T_set
			return SetC;
		elseif size(SetC,2) > size(largestSetC,2)
			largestSetC = SetC;
	end
	%all trials exceed
	return largestSetC;
end
