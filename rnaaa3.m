function [sys, x0] = rnaaa3(t,x,u,flag)

% Exemplo didático para uso da S-Function
%
% Um único neuronio linear para identificação de um sistema linear
% 
% T = 1/0 define se treina ou apenas opera a RNA
% Wnet = vetor de pesos da rede treinada para testar

if flag == 0
   ninput=3;				% Num de entradas = yk+1  yk  uk
   nout=1;					% Num de saidas = ye(k+1) mais os pesos da rede
   
   x0 = [0 ;  0;   0];    % Inicializa vetor de estados (coluna)
     %  ye;  yk yk-1 yk-2    uk  uk-1  uk-2    Pesos
   sys= [0;size(x0,1); nout; ninput;0;0];  % Depois que defini, nunca mudei desde 19xx!
%---------------------------------------------------------------------
% flag = 2 --> retorna estados do sistema
elseif flag == 2
% Recupera os estados passados e já insere as entradas atuais
   Yk=u(2);     % Saida atual atualizada pela entrada
   Ykm1=x(3);   % Yk anterior
   Uk=u(3);     % Saida atual atualizada pela entrada
   Ukm1=x(2);   % Uk anterior
   X=[Uk ;  Yk];
   Y=u(1);
      
   net=feedforwardnet(3,'trainrp');        % Neuronios na camada oculta
   net.trainParam.epochs = 500;  % Epocas de treinamento
   net.trainParam.goal = 1e-15; 
   net = train(net,X,Y); % Treina a rede
   
   Yn=sim(net, X);          % Calcula saida da rede
      
   %if T  % Se for para treinar
   %end
   sys =[Yn X]';	  % Retorna o vetor de estados (coluna)
%---------------------------------------------------------------------
% flag = 3 --> Retorna vetor de saida
%
elseif flag == 3
	sys= [x(1)]' ;    % Retorna apenas o valor estimado pela RNA e os pesos
end