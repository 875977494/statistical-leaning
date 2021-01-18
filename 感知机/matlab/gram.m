function G = gram(x, row) 
    for i = 1 : row
        for j = 1 : row
            G(i, j) = x(i, :) * x(j, :)';
        end
    end
end