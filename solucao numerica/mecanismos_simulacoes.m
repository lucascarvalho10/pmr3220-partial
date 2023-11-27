clc;

% Definindo os valores diretamente
a = 1.5;      % valor desejado
b = 1.5;      % valor desejado
m = 10;        % valor desejado (massa do painel)

% Definindo o vetor de tempo
tempo = 0:0.1:72; % De 0 a 72 segundos com intervalo de 0.1 segundos

% Inicializando arrays para armazenar as posições, velocidades, torques, e rotações ao longo do tempo
posicoesA = zeros(3, length(tempo));
posicoesB = zeros(3, length(tempo));
velocidadesA = zeros(3, length(tempo));
velocidadesB = zeros(3, length(tempo));
torques1 = zeros(1, length(tempo));
torques2 = zeros(1, length(tempo));
rotacoesOmega1 = zeros(1, length(tempo));
rotacoesOmega2 = zeros(1, length(tempo));

% Funções para \omega_1(t) e \omega_2(t)
omega1_fun = @(t) 0.1 * sin(0.2 * t); % Ajustar conforme necessário
omega2_fun = @(t) 0.5 * cos(0.1 * t); % Ajustar conforme necessário

% Loop ao longo do tempo
for i = 1:length(tempo)
    % Substituindo os valores diretamente
    theta1 = 0.1 * tempo(i); % Ajustar
    theta2 = 0.5 * tempo(i); % Ajustar
    
    % Calculando numericamente as posições
    posicaoA = [a*cos(theta1)*cos(theta2); a*sin(theta1)*cos(theta2); a*sin(theta2)];
    posicaoB = [b*cos(theta1)*cos(theta2); b*sin(theta1)*cos(theta2); b*sin(theta2)];
    
    % Calculando numericamente as velocidades
    omega1 = omega1_fun(tempo(i));
    omega2 = omega2_fun(tempo(i));
    velocidadeA = [-a*omega1*sin(theta1)*cos(theta2) - a*omega2*cos(theta1)*sin(theta2);
                    a*omega1*cos(theta1)*cos(theta2) - a*omega2*sin(theta1)*sin(theta2);
                    0];
    velocidadeB = [-b*omega1*sin(theta1)*cos(theta2) - b*omega2*cos(theta1)*sin(theta2);
                    b*omega1*cos(theta1)*cos(theta2) - b*omega2*sin(theta1)*sin(theta2);
                    0];
    
    % Armazenando as posições, velocidades e rotações
    posicoesA(:, i) = posicaoA;
    posicoesB(:, i) = posicaoB;
    velocidadesA(:, i) = velocidadeA;
    velocidadesB(:, i) = velocidadeB;
    
    % Calculando numericamente os torques
    torques1(i) = -m*(a*omega1^2*sin(theta1)*cos(theta2) + a*omega2^2*cos(theta1)*sin(theta2));
    torques2(i) = -m*(b*omega2^2*sin(theta1)*cos(theta2) + b*omega1^2*cos(theta1)*sin(theta2));
    
    % Armazenando as rotações ao longo do tempo
    rotacoesOmega1(i) = omega1;
    rotacoesOmega2(i) = omega2;
end

% Plotando as posições ao longo do tempo
figure;

subplot(2, 1, 1);
plot(tempo, posicoesA(1, :), 'r', tempo, posicoesA(2, :), 'g', tempo, posicoesA(3, :), 'b');
title('Posição A ao longo do tempo');
legend('X', 'Y', 'Z');
xlabel('Tempo (s)');
ylabel('Posição');

subplot(2, 1, 2);
plot(tempo, posicoesB(1, :), 'r', tempo, posicoesB(2, :), 'g', tempo, posicoesB(3, :), 'b');
title('Posição B ao longo do tempo');
legend('X', 'Y', 'Z');
xlabel('Tempo (s)');
ylabel('Posição');

% Plotando as rotações e torques ao longo do tempo
figure;

subplot(2, 2, 1);
plot(tempo, rotacoesOmega1, 'r');
title('\omega_1 ao longo do tempo');
xlabel('Tempo (s)');
ylabel('\omega_1');

subplot(2, 2, 2);
plot(tempo, rotacoesOmega2, 'b');
title('\omega_2 ao longo do tempo');
xlabel('Tempo (s)');
ylabel('\omega_2');

subplot(2, 2, 3);
plot(tempo, torques1, 'r');
title('Torque 1 ao longo do tempo');
xlabel('Tempo (s)');
ylabel('Torque');

subplot(2, 2, 4);
plot(tempo, torques2, 'b');
title('Torque 2 ao longo do tempo');
xlabel('Tempo (s)');
ylabel('Torque');
