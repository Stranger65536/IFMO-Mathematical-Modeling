function lab05()
    clc();
    close all;
    k = 15;
    p = [0.2 0.25 0.3 0.25];
    l = [[           nan     3 + 0.02 * k   4 + 0.01 * k                0]
         [1.5 + 0.03 * k              nan              0   2.5 + 0.02 * k]
         [3.5 + 0.01 * k   4.5 + 0.02 * k            nan                0]
         [             0     5 - 0.02 * k   4 - 0.03 * k              nan]];
    A = [[l(1, 2) + l(1, 3) + l(1, 4)                      -l(2, 1)                      -l(3, 1)   -l(4, 1)]
         [                   -l(1, 2)   l(2, 1) + l(2, 3) + l(2, 4)                      -l(3, 2)   -l(4, 2)]
         [                   -l(1, 3)                      -l(2, 3)   l(3, 1) + l(3, 2) + l(3, 4)   -l(4, 3)]
         [                          1                             1                             1          1]];
    f = [0; 0; 0; 1];
    B = A \ f;
    h = 0.1;
    x_fin = 3;
    [x, y] = ode45(@func, [0:h:x_fin], p);
    plot(x, y, 'LineWidth', 2); 
    grid; 
    legend('p1(x)', 'p2(x)', 'p3(x)', 'p4(x)', 0); 
    print_matrix(x, y);
    fprintf('p(i) = ');
    fprintf('%5.4f ', B);
    fprintf('\n');
end

function A = func(t, p) 
    k = 15;
    l = [[           nan     3 + 0.02 * k   4 + 0.01 * k                0]
         [1.5 + 0.03 * k              nan              0   2.5 + 0.02 * k]
         [3.5 + 0.01 * k   4.5 + 0.02 * k            nan                0]
         [             0     5 - 0.02 * k   4 - 0.03 * k              nan]];
    A = [-(l(1, 2) * p(1) + l(1, 3) * p(1) + l(1, 4) * p(1)) + l(2, 1) * p(2) + l(3, 1) * p(3) + l(4, 1) * p(4);
         -(l(2, 1) * p(2) + l(2, 3) * p(2) + l(2, 4) * p(2)) + l(1, 2) * p(1) + l(3, 2) * p(3) + l(4, 2) * p(4);
         -(l(3, 1) * p(3) + l(3, 2) * p(3) + l(3, 4) * p(3)) + l(1, 3) * p(1) + l(2, 3) * p(2) + l(4, 3) * p(4);
         -(l(4, 1) * p(4) + l(4, 2) * p(4) + l(4, 3) * p(4)) + l(1, 4) * p(1) + l(2, 4) * p(2) + l(3, 4) * p(3)];
end

function print_matrix(x, y)
    n = length(x);
    for i = 1 : n
        for j = 1 : 4
            fprintf(' p%d(%3.1f) = %5.4f', j, x(i), y(i, j));
        end
        fprintf('\n');
    end
end