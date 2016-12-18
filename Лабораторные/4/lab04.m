function lab04()
    clc();
    close all;
    n = 90;
    k = 15;
    c = 0.002 * k;
    p = zeros(n, 4);
    pi = zeros(4, 4, n);
    p(1, :) = [0.2 0.3 0.4 0.1];
    pi(:, :, 1) = [[0.1 + c 0.2 + c 0.3 - c 0.4 - c]
                   [0.2 + c 0.2 - c 0.3 + c 0.3 - c]
                   [0.4 + c 0.2 + c 0.1 - c 0.3 - c]
                   [0.5 + c 0.2 + c 0.2 - c 0.1 - c]];
    fprintf('p(0) = \n');
    fprintf(' %6.5f ', p(1, :));
    fprintf('\n');
    for i = 2 : n
        p(i, :) = p(1, :) * pi(:, :, 1) ^ i;
        fprintf('p(%d) = \n', i - 1);
        fprintf(' %6.5f', p(i, :));
        fprintf('\n');
        pi(:, :, i) = pi(:, :, 1) ^ i;
        fprintf('pi(%d) =\n', i - 1);
        print_matrix(pi, i);
        fprintf('--------------------------------\n');
    end
%     p(1, :) = [1 0 0 0];
%     pi(:, :, 1) = [[0.1 + c 0.2 + c 0.3 - c 0.4 - c]
%                    [0.2 + c 0.2 - c 0.3 + c 0.3 - c]
%                    [0.4 + c 0.2 + c 0.1 - c 0.3 - c]
%                    [0.5 + c 0.2 + c 0.2 - c 0.1 - c]];
%     fprintf('p(0) = \n');
%     fprintf(' %6.5f ', p(1, :));
%     fprintf('\n');
%     for i = 2 : n
%         p(i, :) = p(1, :) * pi(:, :, 1) ^ i;
%         fprintf('p(%d) = \n', i - 1);
%         fprintf(' %6.5f', p(i, :));
%         fprintf('\n');
%         pi(:, :, i) = pi(:, :, 1) ^ i;
%         fprintf('pi(%d) =\n', i - 1);
%         print_matrix(pi, i);
%         fprintf('--------------------------------\n');
%     end
    A = [[pi(1, 1, 1) - 1        pi(2, 1, 1)         pi(3, 1, 1)     pi(4, 1, 1)]
         [    pi(1, 2, 1)    pi(2, 2, 1) - 1         pi(3, 2, 1)     pi(4, 2, 1)]
         [    pi(1, 3, 1)        pi(2, 3, 1)     pi(3, 3, 1) - 1     pi(4, 3, 1)]
         [              1                  1                   1               1]];
    f = [0; 0; 0; 1];
    x = A \ f;
    fprintf('final p = ');
    fprintf(' %6.5f', x);
    fprintf('\n');
    
    temp = [[0.0 0.5 0.5 0.0 0.0 0.0]
            [0.0 0.0 0.0 0.5 0.5 0.0]
            [0.0 0.0 0.0 0.0 0.5 0.5]
            [0.0 0.0 0.0 1.0 0.0 0.0]
            [0.0 0.0 0.0 0.0 1.0 0.0]
            [0.0 0.0 0.0 0.0 0.0 1.0]];
    disp(temp^300);
end

function print_matrix(a, z)
    n = length(a(:, :, z));
    for i = 1 : n
        fprintf(' %6.5f', a(i, :, z));
        fprintf('\n');
    end
end