function lab02()
    clc();
    close all;
    n = 1000;
    a = 0.99;    
    
    x_t = white_noise(n);
    first = x_t;
    noise = x_t;
    first_1 = first(1 : n - 1);
    first_2 = first(2 : n);
    expected_first = mean(x_t);
    disp_first = var(x_t);
    first_autocorr = autocorr(first);
    
    x_t = sliding_avg(noise, n, a);
    second = x_t;
    second_1 = second(1 : n - 1);
    second_2 = second(2 : n);
    expected_second = mean(x_t);
    disp_second = var(x_t);
    second_autocorr = autocorr(second);
    
    x_t = reccur(noise, n, a);
    third = x_t;
    third_1 = third(1 : n - 1);
    third_2 = third(2 : n);
    expected_third = mean(x_t);
    disp_third = var(x_t);
    third_autocorr = autocorr(third);
    
    t = zeros(1, n);
    
    for i = 1 : n
        t(i) = i;
    end
    
    figure;
    
    subplot(1, 3, 1);
    scatter(t, first, 5, 'filled');
    title('x1 realization', 'FontSize', 12);
    xlabel({'time', strcat('Expected value: ', num2str(expected_first)), strcat('Dispersion value: ', num2str(disp_first))}, 'FontSize', 10);
    ylabel('value(time)', 'FontSize', 10);
    axis([0 n -10 10])
    grid on;
    grid minor;
    
    subplot(1, 3, 2);
    scatter(t, second, 5, 'filled');
    title('x2 realization', 'FontSize', 12);
    xlabel({'time', strcat('Expected value: ', num2str(expected_second)), strcat('Dispersion value: ', num2str(disp_second))}, 'FontSize', 10);
    ylabel('value(time)', 'FontSize', 10);
    axis([0 n -10 10])
    grid on;
    grid minor;
    
    subplot(1, 3, 3);
    scatter(t, third, 5, 'filled');
    title('x3 realization', 'FontSize', 12);
    xlabel({'time', strcat('Expected value: ', num2str(expected_third)), strcat('Dispersion value: ', num2str(disp_third))}, 'FontSize', 10);
    ylabel('value(time)', 'FontSize', 10);
    axis([0 n -10 10])
    grid on;
    grid minor;
    
    figure;
    
    subplot(1, 3, 1);
    hist(first, 30);
    title('x1 histogram', 'FontSize', 12);
    
    subplot(1, 3, 2);
    hist(second, 30);
    title('x2 histogram', 'FontSize', 12);
    
    subplot(1, 3, 3);
    hist(third, 30);
    title('x3 histogram', 'FontSize', 12);
    
    figure;
    
    subplot(1, 3, 1);
    scatter(first_1, first_2, 5, 'filled');
    title('x1 mutual distribution', 'FontSize', 12);
    xlabel('value(time)', 'FontSize', 10);
    ylabel('value(time + 1)', 'FontSize', 10);
    axis([-10 10 -10 10])
    grid on;
    grid minor;
    
    subplot(1, 3, 2);
    scatter(second_1, second_2, 5, 'filled');
    title('x2 mutual distribution', 'FontSize', 12);
    xlabel('value(time)', 'FontSize', 10);
    ylabel('value(time + 1)', 'FontSize', 10);
    axis([-10 10 -10 10])
    grid on;
    grid minor;
    
    subplot(1, 3, 3);
    scatter(third_1, third_2, 5, 'filled');
    title('x3 mutual distribution', 'FontSize', 12);
    xlabel('shift value', 'FontSize', 10);
    ylabel('value(time + 1)', 'FontSize', 10);
    axis([-10 10 -10 10])
    grid on;
    grid minor;
    
    figure;
    
    subplot(1, 3, 1);
    scatter(t, first_autocorr, 5, 'filled');
    title('x1 autocorellation', 'FontSize', 12);
    xlabel('shift value', 'FontSize', 10);
    ylabel('corellation value', 'FontSize', 10);
    axis([0 n -0.2 1])
    grid on;
    grid minor;
    
    subplot(1, 3, 2);
    scatter(t, second_autocorr, 5, 'filled');
    title('x2 autocorellation', 'FontSize', 12);
    xlabel('shift value', 'FontSize', 10);
    ylabel('corellation value', 'FontSize', 10);
    axis([0 n -0.2 1])
    grid on;
    grid minor;
    
    subplot(1, 3, 3);
    scatter(t, third_autocorr, 5, 'filled');
    title('x3 autocorellation', 'FontSize', 12);
    xlabel('value(time)', 'FontSize', 10);
    ylabel('corellation value', 'FontSize', 10);
    axis([0 n -0.2 1])
    grid on;
    grid minor;
    
end

function [result] = autocorr(x_t)
    x_t_size = size(x_t);
    n = x_t_size(1, 2);
    result = zeros(1, n);
    for i = 1 : n
        shifted = zeros(1, n);
        shifted(i + 1 : n) = x_t(1 : n - i);
        corr = corrcoef(x_t, shifted);
        result(i) = corr(2, 1);
    end

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

function [x] = reccur(noise, n, a)
    b = 1 - a;
    w = noise;
    x = zeros(1, n);
    for i = 2 : n
        x(i) = a * x(i - 1) + b * w(i - 1);
    end
end