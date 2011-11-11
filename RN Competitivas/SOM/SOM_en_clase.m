clear all
clc

P = rands(2,1000);
% Disposicion de las neuronas de la capa oculta
fil_ocultas =6;
col_ocultas = 5;
pos = gridtop( col_ocultas, fil_ocultas);
pasos=linkdist(pos);
[entradas, CantPatrones] = size(P);
ocultas = fil_ocultas * col_ocultas;
% Pesos iniciales
W = 0.5 * ones(entradas,ocultas);
%% Ponemos los W alejados del centro.
W = 100 + 20 * rand(entradas, ocultas)
%% Primera versi?n del r?fico
figure(1)
plot(P(1,:), P(2,:),'+')
hold on
plotsom(W', pasos);
%%axis([-2 121 ]);


%% Definimos variables
vecinas=3;
ITE_MAX = 100;
alfa = 0.05;
ite = 0;

%% Calculo del SOM
while ( ite <= ITE_MAX ) %%& ?W no cambie mucho? ,
    for patr = 1:CantPatrones,
        %% buscar el W mas proximo
        % mayor contiene el n?mero de neurona ganadora
        
        distancias = sqrt(sum((P(:,patr) * ones(1,ocultas) - W).^2));
        [DMin, ganadora] = min(distancias);
        
        %% Actualizar la neurona ganadora y su vecindad
        for c = 1:ocultas
            if pasos(ganadora, c) <= vecinas
                % Actualizar W por que es la ganadora o la vecina
                W(:,c) = W(:,c) + alfa * (P(:, patr) - W(:, c));
            end
        end
        
        %% redibujar
        if (mod(ite,15) == 0)
            hold off
            figure(1)
            plot(P(1,:), P(2,:),'+')
            hold on
            plotsom(W', pasos)
            title(sprintf('ite = %d vecinas = %d', ite, vecinas))
            %pause(0.1)
        end
        
    end
    if (vecinas>=1) & (mod(ite,20)==0),
        vecinas = vecinas-1;
    end
    ite = ite + 1;
    
    %% Imprimimos variables que nos interesan
    [ite]
    
end






