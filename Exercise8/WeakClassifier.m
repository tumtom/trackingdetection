classdef WeakClassifier
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dimensionThreshold;
        threshold;
    end
    
    methods
        %constructor
        function obj=WeakClassifier()
        end
        
        function obj=Train(obj,trainingExamples,labels,importanceWeights)
        end
        
        function obj=Test(obj,testExamples)
        end
    end
    
end

