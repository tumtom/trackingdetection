function [] = exer3()

    [ms, A, Ms] = exer2();
    
    nrImages = 44;
    
    %run('exer2.m');

    %A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];
    
    X = [];
    Y = [];
    Z = [];
    
    for t = 1:nrImages
        x0 = [0,0,0,0,0,0]; 
        ms_i = ms{t};
        Ms_i = Ms{t};

        x = fminsearch(@func,x0)

        R = rotationVectorToMatrix(x(1:3));
        T = x(4:6);

        C = (-1)*R.'*T.';
        
        name = strcat('pos_',num2str(t,'%04d'),'.mat');
        %fid = fopen(name, 'w');
        %fwrite(fid, C, 'double');
        %fclose(fid);
        
        save(name, 'C');
        
        X = [X; C(1,1)];
        Y = [Y; C(2,1)];
        Z = [Z; C(3,1)];
        
        %plot3(C(1,1), C(2,1), C(3,1));
    end
    
    figure
    stem3(X, Y, Z);

    function f = func(x)
        r = x(1:3);
        R = rotationVectorToMatrix(r);

        T = x(4:6)';

        sum = 0;
        for i = 1:size(ms_i,2)
            u = A*(R*Ms_i(:,i)+T);
            u = u/u(3,1);
        
            w = u - ms_i(:,i);
            sum = sum + norm(w)^2;
        end
        
        f = sum;
    end

    function n = norm(x)
        n = sqrt(x(1,1)^2 + x(2,1)^2 + x(3,1)^2);
    end

end