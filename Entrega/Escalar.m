function [ Datos ]  = Escalar( Datos, ColumnaDesde, ColumnaHasta )
%ESCALAR Summary of this function goes here
%   Detailed explanation goes here

for index = ColumnaDesde :  ColumnaHasta
    minimo = min(Datos(:, index));
    maximo = max(Datos(:, index));
    divisor = (maximo - minimo);
    % Evitamos la division por cero (Para el caso en que todos loa valores de una columna sean todos los mismos)
    
    if divisor == 0
        divisor = 1;
    end
    Datos(:,index) = ((Datos(:,index) - minimo) ./ divisor);
end
end

