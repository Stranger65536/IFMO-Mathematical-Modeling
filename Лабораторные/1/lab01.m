function lab01()
    clc();
    n = 1000;
    a = 0;    
    t = 500;
    count = 1000;
    
    first = white_noise(n);
    
    [x_t, x_t1] = get_w_t_sliding(count, n, a, t);
    second = x_t;
    d_x_t = var(x_t);
    [a1, a2] = get_a_by_disp(d_x_t);
    
    covar = cov(x_t, x_t1);
    cov_x_t_x_t1 = covar(2, 1);
    [a21, a22] = get_a_by_cov(cov_x_t_x_t1);
    
    fprintf('a for sliding average by disp: %7.4f %7.4f\n', a1, a2);
    fprintf('a for sliding average by covar: %7.4f %7.4f\n', a21, a22);
    
    [x_t, x_t1] = get_w_t_autoregr(count, n, a, t);
    e_x_t = mean(x_t);
    e_x_t1 = mean(x_t1);
    d_x_t = var(x_t);
    covar = cov(x_t, x_t1);
    cov_x_t_x_t1 = covar(2, 1);
    a3 = get_a_by_disp_and_cov(d_x_t, cov_x_t_x_t1);
    
    fprintf('a for autoregr by expected: %7.4f\n', a3);
    
        t = zeros(1, n);
    
%     x1 = white_noise(n);
%     e1str = strcat('  E(x1) = ', num2str(mean(x1)), ';');
%     d1str = strcat('  D(x1) = ', num2str(var(x1)), ';');
%     q1str = strcat('  Q(x1) = ', num2str(std(x1)), ';');
%     info1 = strcat(e1str, d1str, q1str);
    
%     xt = sliding_avg(x1, n, a);
%     e2str = strcat('  E(x2) = ', num2str(mean(x2)), ';');
%     d2str = strcat('  D(x2) = ', num2str(var(x2)), ';');
%     q2str = strcat('  Q(x2) = ', num2str(std(x2)), ';');
%     info2 = strcat(e2str, d2str, q2str);
%     e3str = strcat('  E(x3) = ', num2str(mean(x3_t)), ';');
%     d3str = strcat('  D(x3) = ', num2str(var(x3_t)), ';');
%     q3str = strcat('  Q(x3) = ', num2str(std(x3_t)), ';');
%     cov3 = cov(x3_t1, x3_t);
%     corr3 = corrcoef(x3_t1, x3_t);
%     cov3str = strcat('  Cov(x3(t"), x3(t)) = ', num2str(cov3(1, 2)), ';');
%     cor3str = strcat('  Corr(x3(t"), x3(t)) = ', num2str(corr3(1, 2)), ';');
%     info3 = strcat(e3str, d3str, q3str);
%     info32 = strcat(cov3str, cor3str);
    
    for i = 1 : n
        t(i) = i;
    end
    
    figure;
    
    subplot(1, 3, 1);
    scatter(t, first, 5, 'filled');
    title('x1 realization', 'FontSize', 12);
    xlabel('time', 'FontSize', 10);
    ylabel('value(time)', 'FontSize', 10);
    axis([0 n -5 5])
    grid on;
    grid minor;

%     subplot(1, 3, 2);
%     hist(x1, 30);
%     title('x1 histogram', 'FontSize', 12);
    
    subplot(1, 3, 2);
    scatter(t, second, 5, 'filled');
    title('x2 realization', 'FontSize', 12);
    xlabel('time', 'FontSize', 10);
    ylabel('value(time)', 'FontSize', 10);
    axis([0 n -5 5])
    grid on;
    grid minor;
    
%     subplot(2, 3, 5);
%     hist(x2, 30);
%     title('x2 histogram', 'FontSize', 12);
    
    subplot(1, 3, 3);
    scatter(x_t, x_t1, 5, 'filled');
    title('x3 realization', 'FontSize', 12);
    xlabel('value(time)', 'FontSize', 10);
    ylabel('value(time + 1)', 'FontSize', 10);
    grid on;
    grid minor;
   
%     subplot(2, 3, 6);
%     hist(x3_t, 30);
%     title('x3 histogram', 'FontSize', 12);
%     xlabel(info32, 'FontSize', 10);
end

function [x_t, x_t1] = get_w_t_sliding(count, n, a, t)
    x_t = zeros(1, count);
    x_t1 = zeros(1, count);
    for i = 1 : count
        w = sliding_avg(white_noise(n), n, a);
        x_t(i) = w(t);
        x_t1(i) = w(t + 1);
    end
end

function [x_t, x_t1] = get_w_t_autoregr(count, n, a, t)
    x_t = zeros(1, count);
    x_t1 = zeros(1, count);
    for i = 1 : count
        w = autoregr(white_noise(n), n, a);
        x_t(i) = w(t);
        x_t1(i) = w(t + 1);
    end
end

function [a] = get_a_by_disp_and_cov(disp_t, cov_t1_t)
    a = cov_t1_t / disp_t;
end

function [a1, a2] = get_a_by_disp(disp)
    a1 = 0.5 * (1 - sqrt(2 * disp - 1));
    a2 = 0.5 * (1 + sqrt(2 * disp - 1));
end

function [a1, a2] = get_a_by_cov(cov)
    a1 = 0.5 * (1 - sqrt(1 - 4 * cov));
    a2 = 0.5 * (1 + sqrt(1 - 4 * cov));
end

function [w] = white_noise(n)
    w = normrnd(0, 1, 1, n);
end

function [x] = sliding_avg(noise, n, a)
    b = 1 - a;
    w = noise;
    x = zeros(1, n);
    for i = 1 : n - 1
        x(i) = a * w(i + 1) + b * w(i);
    end
end

function [x] = autoregr(noise, n, a)
    b = 1 - a;
    w = noise;
    x = zeros(1, n);
    for i = 2 : n
        x(i) = a * x(i - 1) + b * w(i - 1);
    end
end