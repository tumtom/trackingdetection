%%%%
% selects s points of corresponce points
% takes these points if threshold is >= t
% tries another random set of points if threshold < t
function [CorresponseSet_s,CorresponseSet_d] = ransac(M_s,M_d,s,t_distance,T_set,N_trials)
	largestSetC_s = [];
    largestSetC_d = [];
	for t=1:N_trials
		%select s random rows of the matrix
        ran = round(rand([1,s])*size(M_s,2));
		SetP_s = M_s(:,ran);
        SetP_d = M_d(:,ran);      

        %Create homogeneous
		H = homography(SetP_s,SetP_d);
	
        SetC_s = [];
        SetC_d = [];
		%check which points go along with our calculated homography
		for i=1:size(M_s,2)
			p2_calc = H * M_s(:,i);
            p2_calc = p2_calc / p2_calc(3,1);
            p2_sift = M_d(:,i);
			distance = sqrt( (abs(p2_calc(1)-p2_sift(1)))^2 + (abs(p2_calc(2)-p2_sift(2)))^2 );
			if distance <= t_distance		
				%save it
				SetC_s = [SetC_s, M_s(:,i)];
                SetC_d = [SetC_d, M_d(:,i)];
			end
		end
		if size(SetC_s,2) >= T_set
			CorresponseSet_s = SetC_s;
            CorresponseSet_d = SetC_d;
            return;
		elseif size(SetC_s,2) > size(largestSetC_s,2)
			largestSetC_s = SetC_s;
            largestSetC_d = SetC_d;
	end
	%all trials exceed
    CorresponseSet_s = largestSetC_s;
	CorresponseSet_d = largestSetC_d;
    return;
end
