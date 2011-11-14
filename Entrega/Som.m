function [ W ] = Som( Patrones, MAX_ITE, Alfa, vecindad, FilasOcultas, ColumnasOcultas)
%SOM Summary of this function goes here
%   Detailed explanation goes here

pos = gridtop( FilasOcultas, ColumnasOcultas); 
pasos=linkdist(pos); 
[entradas, CantPatrones] = size(Patrones); 

ocultas = FilasOcultas * ColumnasOcultas; 
% Pesos iniciales 
W = ones(entradas, ocultas) * 0.5; 

ite = 0;
Reduccion = 20;
ITE_MIN = (vecindad + 2) * Reduccion;

WAnt = 100 * ones(entradas, ocultas);
Dife = mean(sqrt(sum(WAnt - W).^2));

while (( ite <= MAX_ITE ) && (Dife > 0.01)) || (ite < ITE_MIN)% "W no cambie mucho?
    ite = ite + 1;
    WAnt = W;
    for patr =1:CantPatrones, 
        %buscar el W mas proximo
        distancias = sqrt(sum((Patrones(:,patr) * ones(1,ocultas) - W).^2));
        [DMin, ganadora] = min(distancias);
        
        %Actualizar la neurona ganadora y su vecindad 
        for c=1:ocultas
            if pasos(ganadora,c) <= vecindad
                %actualizar W porque es la ganadora o una vecina
                W(:,c) = W(:,c) + Alfa * (Patrones(:,patr) - W(:,c));
            end
        end
    end
    Dife = mean(sqrt(sum(WAnt - W).^2));
    if (vecindad>=1) & (mod(ite,Reduccion)==0), 
        vecindad = vecindad - 1; 
    end 
end
end

