classdef AdaboostClassifier
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        weakClassifiers; %multiple WeakClassifier objects
        alpha;
    end
    
    methods
        function obj=AdaboostClassifier()
        end
        
        function obj=Train(obj,trainingExamples,labels)
        end
        
        function obj=Test(obj,testingExamples)
        end
    end
    
end

