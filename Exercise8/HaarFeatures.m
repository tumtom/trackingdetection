classdef HaarFeatures
    
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        featuresPositions;
        featuresType;
        featuresAttribute;
    end
    
    methods
        %constructor
        function obj=HaarFeatures(Attributes)
            obj.featuresPositions = Attributes(1:4);
            obj.featuresType = Attributes(5);
            obj.featuresAttribute = Attributes(6:14);
        end
        
        function resp=HaarFeaturesCompute(obj)
            global I;
            r = obj.featuresPositions(1);
            c = obj.featuresPositions(2);
            w = obj.featuresPositions(3);
            h = obj.featuresPositions(4);
            
            if obj.featuresType == 1
                Rectangle1 = I_sum(r, c, ((w/2) - 1), (h - 1));
                Rectangle2 = I_sum(r, (c + w/2), ((w/2) - 1), (h - 1));
                resp= Rectangle1 + Rectangle2;
            elseif obj.featuresType == 2
                R1 = I_sum(r,c,w-1,h/2 -1);
                R2 = I_sum(r+h/2,c,w-1,h/2-1);
                resp = R1 + R2;
            elseif obj.featuresType == 3
                R1 = I_sum(r,c,w/3-1,h-1);
                R2 = I_sum(r,c+w/3,w/3-1,h-1);
                R3 = I_sum(r,c+2/3*w,w/3-1,h-1);
                resp = R1 - R2 + R3;
            elseif obj.featuresType == 4
                R1 = I_sum(r,c,w-1,h/3-1);
                R2 = I_sum(r+h/3,c,w-1,h/3-1);
                R3 = I_sum(r+2/3*h,c,w-1,h/3-1);
                resp = R1 - R2 + R3;
            else
                R1 = I_sum(r,c,w/2-1,h/2-1);
                R2 = I_sum(r,c+w/2,w/2-1,h/2-1);
                R3 = I_sum(r+h/2,c,w/2-1,h/2-1);
                R4 = I_sum(r+h/2,c+w/2,w/2-1,h/2-1);
                resp = R1 - R2 + R3 - R4;   
            end
        end
    end
    
end

