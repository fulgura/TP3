function [ W2 ] = CapaSalida(P, Y, W, salidas, ocultas, ITE_MAX, Beta )
%CAPASALIDA Summary of this function goes here
%   Detailed explanation goes here

%% hacer la capa de salida como hicimos con CPN, tomar el 80 para entrenar
% y 20 de testeo. Actualizar los valores de los arcos que salen de la
% neurona ganadora, ver ppt de CPN pag. 12. Solo se actualiza de la
% neurona ganadora a la capa de salida. 

[entradas, CantPatrones] = size(P);
W2 = zeros( salidas, ocultas);
W2Ant = 100*ones(salidas, ocultas);
ite = 0;
Dife = max(sqrt(sum(W2Ant - W2).^2));

while ( ite <= ITE_MAX )  & (Dife > 0.001), 
    ite = ite + 1;
    W2Ant = W2;
    for i=1:CantPatrones, 
        %buscar el W mas proximo 
        distancias = sqrt(sum((P(:,i)*ones(1,ocultas) - W).^2));
        [DMin, ganadora] = min(distancias);
        
        %Actualizar los pesos que salen de la neurona 
        %  ganadora 
        W2( :, ganadora) = W2(:, ganadora) + Beta * (Y(:, i) - W2 (:, ganadora));    
    end  
    Dife = max(sqrt(sum(W2Ant - W2).^2));
    [ite Dife]
     
end

end

