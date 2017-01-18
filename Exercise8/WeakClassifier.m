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
      
            %number of examples
            nrEx = size(trainingExamples,1);
            %initialize the distribution D_i to equal distrib. if not given
            if iszero(importanceWeights)
              D_i = ones(nrEx,1) * 1/nrEx; 
            else
              %else use given distribution
              D_i = importanceWeights;
            end
            
            %get random threshold between 0 and 255
            threshold = 255*rand();
            
            sample = ...
                
            %choose threshold by random
            %choose one row of trainingExamples according to D_i
           
            %check if chosen row of trainingExamples itensity in the image
            %is > threshold
            
            rnd = rand();
            d = -1;
            threshold = -1;
            sign = 0;
            
                totalError = sum(importanceWeights);
                currentError = 0;
                for t = 1:nrEx 
                    if label(t) == -1
                        currentError = currentError + importanceWeights(t);
                    
   // Цикл по всем координатам пространства
   for (int d = 0; d < trainingSet.Dimensionality; d++)
   {
 

    // Определяем максимальную ошибку
    double totalError = 0.0;
    for (int i = 0; i < trainingSet.Count; i++)
     totalError += _weights[i];
 
    // Инициализируем значение ошибки для поиска минимальной ошибки
    double currentError = 0.0;
    for (int i = 0; i < trainingSet.Count; i++)
     currentError += trainingSet.Labels[i] == -1 ? _weights[i] : 0.0;
 
    // Ищем в отсортированном массиве лучший параметр threshold, который будет минимизировать
                               //ошибку, и определяем знак классификатора
    for (int i = 0; i < trainingSet.Count - 1; i++)
    {
     // Обновляем ошибку при рассмотрении текущего объекта
     int index = indices[i];
     if (trainingSet.Labels[index] == +1)
      currentError += _weights[index];
     else
      currentError -= _weights[index];
 
     // Если идут одинаковые данные, то порог не ищем
     if (data[i] == data[i + 1])
      continue;
 
     // Определяем потенциально возможное значение для threshold
     double testThreshold = (data[i] + data[i + 1]) / 2.0;
 
     // Запоминаем значение threshold, если ошибка минимальна, и определяем знак
     if (currentError < minimumError) // Классификатор с _sign = +1
     {
      minimumError = currentError;
      _d = d;
      _threshold = testThreshold;
      _sign = +1;
     }
     if ((totalError - currentError) < minimumError) // Классификатор с _sign = -1
     {
      minimumError = (totalError - currentError);
      _d = d;
      _threshold = testThreshold;
      _sign = -1;
     }
    }
   }
  }
            
            
            %if yes -> +1
            %if no -> -1
           
            
            
    }
   }
  }
        end
        
        function obj=Test(obj,testExamples)
        end
    end
    
end

