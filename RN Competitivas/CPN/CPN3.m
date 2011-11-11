clear all
clc


P = [14 10 9 9 10 1 1 1 1 0 4 5 5 5 5 6 8 8 2 2 2 14 15 15 15 16;
    1 3 4 5 5 1 2 3 4 2 5 4 5 6 7 6 3 4 2 3 4 2 1 3 4 2];
figure(1)
plot(P(1,:), P(2,:), '+')
axis( [-11 18 -11 8] )

ocultas = 4;
W = [ -10 0 0 0;
    -10 2 2 2];
hold on
plotsom(W)


MAX_ITE = 100;
alfa = 0.25;
ite = 0;
[entradas, CantPatrones] = size(P);


while (ite < MAX_ITE) %%&& Los W no cambien mucho
    
    ite = ite + 1;
    
    for patr = 1:CantPatrones;
        %Calcular la ganadora
        distancias = sqrt(sum((P(:,patr) * ones(1,ocultas) - W).^2));
        [DMin, ganadora] = min(distancias);
        
        %solo se actualizan los pesos de las ganadoras
        W(:,ganadora) = W(:,ganadora) + ...
                    alfa * (P(:,patr) - W(:,ganadora));
    end
    
    % redibujar
    hold off
    plot(P(1,:), P(2,:), '+')
    axis( [-11 18 -11 8] )
    hold on
    plotsom(W);
    pause(0.1);
    
    
end