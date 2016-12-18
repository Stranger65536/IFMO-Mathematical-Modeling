function lab03()
    clc();
    close all;

    k = 15;
    mx = 8 + 0.1 * k;
    dx = 2 + 0.2 * k;
    a0 = 1 + 0.02 * k;
    a1 = 7 - 0.01 * k;
    b0 = 5 + 0.05 * k;
    b1 = 8 + 0.02 * k;
    t = 0:0.2:5;
    
    my = mx * b0 / a0;
    dy = dx * (a1 * b0^2 + a0 * b1^2) / (a0 * a1 * (a0 + a1));
    
    fprintf('mx: %7.2f dx: %7.2f\n', mx, dx);
    fprintf('my: %7.2f dy: %7.2f\n', my, dy);
end