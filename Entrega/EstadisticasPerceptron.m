function [correctos incorrectos] = EstadisticasPerceptron(P,T,W,b)
% 
%
% Cantidad de patrones
[CantAtrib, CantPatrones] = size(P);

y = hardlimSafe(W * P + b * ones(1,CantPatrones));

correctos = sum((T == y));
incorrectos = CantPatrones - correctos;
