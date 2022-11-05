function y = create_signal(theta_rad, sigma2_s, sigma2_v, M, N)
    K = length(theta_rad);
    A = exp(-1i * pi * sin(theta_rad).' * (0:M-1));
    signal = sqrt(sigma2_s) .* randn(N, K);
    noise = sqrt(sigma2_v).' * randn(N, M);
    y = signal * A + noise;
end
