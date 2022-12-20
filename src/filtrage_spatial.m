%% Init
clear; close all; clc;
addpath("fonctions");

%% Questions 2 à 5
theta = {40, 40, [40, 45], [40, 50]};  % élévation des sources
sigma2_s = {1, 1, [1, 1], [1, 10]};    % énergie des sources
sigma2_v = {0.1, 0.1, 0.1, 0.1};       % énergie du bruit (liée aux capteurs)
N = {500, 500, 500, 500};              % nombre d'échantillons
M = {5, 20, 12, 20};                   % nombre de capteurs
theta_x = 0:1:90;                      % abscisse pour les plots

for i = 1:length(theta)
    y = create_signal(deg2rad(theta{i}), sigma2_s{i}, sigma2_v{i}, M{i}, N{i});
    P_capon = CAPON(y, deg2rad(theta_x));
    plot_single_CAPON(i+1, theta_x, theta{i}, P_capon, M{i}, N{i})
end

%% Question 6
sigma2_v6 = [1, 5, 10, 20];
P = zeros(length(sigma2_v6), length(theta_x));
for i = 1:length(sigma2_v6)
    y = create_signal([40, 50], [1, 1], sigma2_v6(i), 20, 500);
    P(i, :) = CAPON(y, theta_x);
end
plot_multiple_CAPON(6, theta_x, sigma2_v6, P)

%% Affichage
function plot_single_CAPON(n_question, theta_x, theta_s, P_CAPON, M, N)
    figure("Name", "Question n°" + n_question, "NumberTitle", "off")
    plot(theta_x, P_CAPON)
    if length(theta_s) == 1
        title("\theta=" + theta_s + "°,  M=" + M + ",  N=" + N)
    else
        title("\theta {\in}\{" + strrep(num2str(theta_s), "  ", "°, ") + "°\},  M=" + M + ",  N=" + N)
    end
    ylabel("Energie estimée")
    xlabel("Angle d'arrivée {\theta} (en degré)")
    grid
end

function plot_multiple_CAPON(n_question, theta_x, sigma2, P)
    figure("Name", "Question n°" + n_question, "NumberTitle", "off")
    plot(theta_x, P)
    legend("{\sigma^2}=" + num2str(transpose(sigma2)))
    ylabel("Energie estimée")
    xlabel("Angle d'arrivée {\theta} (en degré)")
    grid
end
