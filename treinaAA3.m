function [net] = treinaAA3(X,Y);

% Copiar e colar no Command Window a linha abaixo, para rodar o algoritmo.
% treinaAA3(out.amostraU.data, out.amostraY.data)
clc

%Entradas e saídas (regressores e autoregressores) em linha
tam=length(X);
Xt=[X(1:tam-1) Y(2:tam)]';
Yt=Y(1:tam-1)';

% Cria nova rede
net=feedforwardnet(3,'trainlm');     % Neuronios na camada oculta e função de treinamento.
net.trainParam.epochs = 100;  % Epocas de treinamento
net.trainParam.goal = 1e-5;  

% Treina a rede
net_treinada = train(net,Xt,Yt);

%==========================================================
% Confere dados da RNA gerada
plot(Yt); hold on; grid on;
sY=sim(net_treinada,Xt);              % Resultados da simulação da RNA
plot(sY,'r');
legend('Real','RNA');

net=net_treinada;

