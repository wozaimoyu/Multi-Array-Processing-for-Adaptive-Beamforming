%% Init
clear; close all; clc;
addpath("fonctions");

%% Question 3: nombre de capteurs minimal
Mmax = 15;    % nombre de capteurs maximal à tester
N = 500;      % nombre d'échantillons
theta_x = 0:.1:85;
theta_s = [40, 45];
noise = 0.1;

figure("Name", "Question n°3", "NumberTitle", "off")
ylabel("Energie estimée")
xlabel("Angle d'arrivée {\theta} (en degré)")
for M = 1:Mmax
    signal = create_signal(deg2rad(theta_s), [1, 1], noise, M, N);
    P_MUSIC = MUSIC(signal, length(theta_s), deg2rad(theta_x));
    plot(theta_x, P_MUSIC)
    grid on
    title("MUSIC: " + M + " capteurs")
    pause(1)
end

%% Question 4
M = 15;   % nombre de capteurs
N = 500;  % nombre d'échantillons
theta_x = 0:.1:85;
theta_s = [40, 45];
noise_list = [0.1, 0.25, 0.5, 1];

for i = 1:length(noise_list)
    signal = create_signal(deg2rad(theta_s), [1, 1], noise_list(i), M, N);
    
    P_MUSIC = MUSIC(signal, length(theta_s), deg2rad(theta_x));
    P_CAPON = CAPON(signal, deg2rad(theta_x));
    
    compare_MUSIC_CAPON(P_MUSIC, P_CAPON, theta_s, theta_x, M, noise_list(i))
end

%% Fonction d'affichage
function compare_MUSIC_CAPON(P_MUSIC, P_CAPON, theta_s, theta_x, M, noise)
    figure("Name", "localisation_s_" + noise, "NumberTitle", "off")
    subplot(2, 1, 1)
    plot(theta_x, P_MUSIC)
    title("MUSIC")
    grid
   
    subplot(2, 1, 2)
    plot(theta_x, P_CAPON)
    title("CAPON")
    grid
    
    sgtitle("\theta {\in}\{" + strrep(num2str(theta_s), "  ", "°, ") + "°\},  M=" + M + ",  {\sigma^2}=" + noise)
end
