x1 = [3, 3];
x2 = [4, 3];
x3 = [1, 1];
x4 = [0, 0];
xt = [x1; x2; x3; x4];
y = [1, 1, -1, -1];
sigma = 1;
[w, b, alpha, row] = perceptron(xt, y, sigma);

%% »­Í¼
for i = 1 : row
    for j = 1 : row
        if y(i) == 1
            plot(xt(i, 1), xt(i, 2), 'rs');
        else 
            plot(xt(i, 1), xt(i, 2), 'b*');
        end
        hold on
    end
end

xline = 0 : 0.1 :5;
yline = -1 * w(1) * xline / w(2) - b / w(2);
plot(xline, yline, 'g-');
title('perceptron');
xlabel('x1');
ylabel('x2');