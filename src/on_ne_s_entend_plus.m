%% Init
close all; clear; clc; addpath("fonctions/")
load ../database/data.mat
t0 = 2;  % nombre de secondes avant le début de la conversation

%% calculs
M = min(size(data));  % nombre de capteurs
N = max(size(data));  % nombre d'échantillons
N0 = t0 * Fs;         % nombre d'échantillons de bruit pur
theta = struct("min", -90, "max", 90, "step", 0.01);  % angles d'étude
theta.x = theta.min:theta.step:theta.max;  % linspace

bruit = data(:, 1:N0).';
signal = data(:, N0+1:end).';

% Estimation du nombre de source
R = cov(data.');
lambda = sort(eig(R), "descend");
multi_factor_sigma2 = 5;
sigma2 = mean(var(bruit));
K = sum(lambda > multi_factor_sigma2 * sigma2);

% Estimation des orientations des sources
orientations_MUSIC = MUSIC(signal, K, deg2rad(theta.x));
theta.min_indexes = find(islocalmin(orientations_MUSIC));
theta.estimes = theta.step * theta.min_indexes + theta.min;
theta.conv = theta.estimes(theta.estimes > 0);  % retire les sources images

% Projection pour récupérer les conversations
a = exp(-1i * pi * sin(theta.estimes(theta.estimes > 0)) * (0:M-1));
conversations = real(a * data).';
nb_conversations = min(size(conversations));

% Lecture de l'audio
player = audioplayer(conversations(:), Fs);
play(player)

%% Affichage
temps = (1:N)./Fs;
figure
subplot(2, 1, 1)
plot(temps, data(1, :))
hold on
plot([t0, t0], max(abs(data(1, :))).*[-1, 1])
xlabel("Temps (seconde)")
title("Observation des données")
legend(["Signal reçu sur un capteur", "début des conversations"])

subplot(2, 2, 3)
stem(lambda)
hold on
plot(ones(1, M) .* multi_factor_sigma2 * sigma2);
grid on
title("Nombre de source")
xlabel("Valeurs propres")
legend(["Spectre", multi_factor_sigma2 + "{\sigma^2}"])

subplot(2, 2, 4)
plot(theta.x, orientations_MUSIC)
hold on
plot(theta.estimes, orientations_MUSIC(theta.min_indexes), "s")
xlabel("{\theta} (en degrés)")
legend(["MUSIC", "Minimums"])
title("Orientation des sources")
grid on


figure;
for i=1:nb_conversations
    subplot(ceil(sqrt(nb_conversations)), ceil(sqrt(nb_conversations)), i)
    plot(temps, conversations(:, i))
    grid
    xlabel("Temps (seconde)")
    title("Conversation " + i)
end
sgtitle("Les conversations séparées")
