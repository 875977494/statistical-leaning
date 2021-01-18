function [w, b, alpha, row] = perceptron(xt, y, sigma)
    x = xt;
    [row, col] = size(x);
    
    w = zeros(1, col);
    alpha = zeros(1, row);
    b = 0;
    %% ������
    count = 0;
    %% ��������������
    iter = 1;
    
    G = gram(x, row);

    while count < row
        iter = iter + 1;
        count = 0;
        for i = 1 : row
            temp = 0;
            for j = 1 : row
                temp = temp + alpha(j) * y(j) * G(j, i);
            end
            % �������
            if (y(i) * (temp + b) <= 0) 
               alpha(i) = alpha(i) + sigma;
               b = b + sigma * y(i);
            else count = count + 1;
            end
        end
    end
    
    for i = 1 : row
       w = w + alpha(i) * y(i) * x(i, :); 
    end
end





