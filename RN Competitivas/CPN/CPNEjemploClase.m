clear all
clc

%% Entrenamiento de los pesos que van desde la capa de entrada a la capa oculta.
P = [1 -1	1 3 0.8 -1.5 -0.7 -2	1.3	1.7; 1	2 -2 3 1.5	1.8	1.6	3 -0.8 -2 ];
Y = [ 1 -0.5	1.5 2 1 -0.5 -0.5 -0.8	1.5	1.5 1 0.5-1 21 0.5 0.4 1.5-1 -1 ];

[entradas, CantPatrones] = size(P);
salidas = size(Y,1);
% normalizando los vectores de entrada
P_norm = normalizar(P);
figure(1);

plot(P(1,:), P(2,:),'+', P_norm(1,:), P_norm(2,:),'o');
axis([-4 4 -4 4]);


%% Ponemos los centros en el mismo lugar
W = [ 0	0	0;
    0.5 0.5 0.5];

ocultas = length(W);
W_norm = normalizar(W);
hold on
plotsom(W_norm)
pause(0.2)

%% Calculamos

ITE_MAX = 10; 
ite = 0; 
alfa = 0.25;


while ( ite <= ITE_MAX )%% & ('los pesos no cambien mucho'),
    ite = ite + 1;
    
    for i=1:CantPatrones,
        %buscar el W mas proximo
        [distancia,mayor] = max(P_norm(:,i)' * W_norm);
        %Actualizar la neurona mas proxima
        W_norm(:, mayor) = W_norm(:,mayor) + alfa * (P_norm(:, i) - W_norm(:,mayor));
        W_norm = normalizar(W_norm);
    end
    % redibujar
    hold off
    plot(P(1,:), P(2,:),'+', P_norm(1,:), P_norm(2,:),'o');
    
    hold on
    
    axis([-4 4 -4 4]);
    W_norm = normalizar(W);
    plotsom(W_norm)
    pause(0.2)
    
    
end


