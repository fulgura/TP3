function [ CantCorrectos, Correctos ] = Resultados( P, Y, salidas, ocultas, W ,W2 )
%% RESULTADOS Calculo de cantidad de correctamente clasificados en la capa
% de salida de una red SOM.
%   

%% Implementacion 
[entradas, CantPatrones] = size(P);
%Obtengo las Salidas de Train 
SalidasTrain = zeros(salidas,CantPatrones);
for i= 1:CantPatrones
    distancias = sqrt(sum((P(:,i)*ones(1,ocultas) - W).^2));
    [DMin, ganadora] = min(distancias);  
    SalidasTrain(:,i) = W2(:,ganadora);
end;

indices = (SalidasTrain >= - 0.2) & (SalidasTrain <= 0.2);
SalidasTrain(indices) = 0;

indices = (SalidasTrain >= 0.8) & (SalidasTrain <= 1.2);
SalidasTrain(indices) = 1;
    
   
%% Calculo solo la cantidad de correctos
CantCorrectos = sum(all(SalidasTrain == Y,1));


%% Calculamos la cantidad de correctos por clase.
Correctos = zeros(salidas, 1);
for i = 1:salidas
    [rows, cols] = find(Y(i,:) == 1);
    Correctos(i) = sum(all(SalidasTrain(:,cols) == Y(:,cols),1));
end


end

