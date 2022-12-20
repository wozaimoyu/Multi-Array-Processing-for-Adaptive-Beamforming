function directions = MUSIC(signal, K, theta_rad)
    M = size(signal, 2);
    R = cov(signal);
    [U, ~, ~] = svd(R);
    U = U(:, K+1:M);
    a = exp(-1i * pi * sin(theta_rad).' * (0:M-1));
    projection = a * U;
    directions = vecnorm(projection, 2, 2);
end
