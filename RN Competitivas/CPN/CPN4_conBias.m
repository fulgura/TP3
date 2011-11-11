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


MAX_ITE = 40;
alfa = 0.25;
ite = 0;
[entradas, CantPatrones] = size(P);
%Calculamos el bias inicial s = cant. de neuronas ocultas
c = ones(1, ocultas) / ocultas; 
b = exp(1 - log(c));
gano = zeros(1, ocultas);

while (ite < MAX_ITE) %%&& Los W no cambien mucho
    
    ite = ite + 1;
    
    for patr = 1:CantPatrones;
        
        AplicarBias = (gano < 4); %% Vale 1 sino gan? 4 veces
        
        %Calcular la ganadora
        distancias = sqrt(sum((P(:,patr) * ones(1,ocultas) - W).^2)) - AplicarBias .* b;
        [DMin, ganadora] = min(distancias);
        gano(ganadora) = gano(ganadora) + 1;
        
        %solo se actualizan los pesos de las ganadoras
        W(:,ganadora) = W(:,ganadora) + ...
                    alfa * (P(:,patr) - W(:,ganadora));
        % Actualizamos el bias
        a = zeros(1, ocultas);
        a(ganadora)=1;
        % Obtener el valor original
        c = exp(1-log(b));
        % Atualiza para equilibrar las posibilidades.
        c = (1 - alfa) * c + alfa * a;
        b = exp(1-log(c)) - alfa * b;
        
    end
    
    % redibujar
    hold off
    plot(P(1,:), P(2,:), '+')
    axis( [-11 18 -11 8] )
    hold on
    plotsom(W);
    pause(0.1);
    
    gano
end

