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
        
        function obj=HaarFeaturesCompute(obj,I)
            if obj.featuresType == 1:
                Rectangle1= [r c ((winW idth/2) − 1) (winHeight − 1)];
                Rectangle2= [r (c + winW idth/2) ((winW idth/2) − 1)(winHeight − 1)];
                Feature_response= Rectangle1 + Rectangle2;

            
        end
    end
    
end

