function [ clases, ganadoras] = Ganadoras( P, T, W )
%GANADORAS Summary of this function goes here
%   Detailed explanation goes here

[CantPatrones, Columnas] = size(P);
[entradas,ocultas] = size(W);

% calcular para c/clase la lista de patrones que contiene
clases = zeros(ocultas,max(T));
ganadoras = zeros(1, CantPatrones);

for i = 1:CantPatrones
    %Calcular la neurona ganadora
    distancias = sqrt(sum((P(:,i)*ones(1,ocultas) - W).^2));
    [DMin, ganadora] = min(distancias);
    ganadoras(1,i) = ganadora;
    c= T(i); %ven?a con los patrones
    clases(ganadora, c) = clases(ganadora, c ) + 1;
end

end

