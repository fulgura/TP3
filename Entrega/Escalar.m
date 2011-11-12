function [ E ] = Escalar( Datos, Columnas )
%ESCALAR Summary of this function goes here
%   Detailed explanation goes here

for index = Columnas
    minimo = min(CD.Datos(:, index));
    maximo = max(CD.Datos(:, index));
    CD.Datos(:,index) = ((CD.Datos(:,index) - minimo) ./ (maximo - minimo));
end
end

