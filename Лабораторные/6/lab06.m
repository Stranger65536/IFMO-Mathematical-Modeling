function lab06()
    clc();
    close all;
    n = 4;
    lam = 2.13;
    mu = 3.47;
    dt = 1;
    L = 20;
    p = zeros(1, n + 1);
    p(:) = 0; p(1) = 1;
    [x, y] = ode45(@func, [0:dt:dt * L], p);
    plot(x, y, 'LineWidth', 2); 
    grid; 
    legend('p0(t)', 'p1(t)', 'p2(t)', 'p3(t)', 'p4(t)', 0); 
    print_matrix(x, y);
    p(:) = 0;
    for k = 0 : n
        p(1) = p(1) + (lam / mu) ^ k / factorial(k);
    end
    p(1) = 1 / p(1);
    for k = 1 : n
        p(k + 1) = (lam / mu) ^ k / factorial(k) * p(1);
    end
    fprintf('p(i) = ');
    fprintf('%5.4f ', p);
    fprintf('\n');
    fprintf('sum(pi) = %2.1f\n', sum(p));
end

function A = func(t, p) 
    lam = 2.13;
    mu = 3.47;
    A = [-lam * p(1) + mu * p(2);
          lam * p(1) - (lam + 1 * mu) * p(2) + 2 * mu * p(3);
          lam * p(2) - (lam + 2 * mu) * p(3) + 3 * mu * p(4);
          lam * p(3) - (lam + 3 * mu) * p(4) + 4 * mu * p(5);
          lam * p(4) - 4 * mu * p(5)];
end

function print_matrix(x, y)
    n = length(x);
    for i = 1 : n
        for j = 1 : 5
            fprintf(' p%d(%3.1f) = %5.4f', j, x(i), y(i, j));
        end
        fprintf('\n');
    end
end