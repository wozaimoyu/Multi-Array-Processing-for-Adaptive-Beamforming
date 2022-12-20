function P = CAPON(signal, theta)
    M = size(signal, 2);
    R = cov(signal);
    T = length(theta);
    P = zeros(1, T);
    a = exp(-1i * pi * sin(theta).' * (0:M-1));
    for t = 1:T
        P(t) = 1 / (a(t, :) / R * conj(transpose(a(t, :))));
    end
    P = real(P);
end
