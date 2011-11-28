function [W, b, ite] = Perceptron(P, T, alfa, MAX_ITERA)
%% Perceptron

[CantAtrib, CantPatrones] = size(P);

%% Preparamos los W iniciales
W = 0.5*rand(1, CantAtrib);
b = 0.5*rand;

ite = 0;
todoBien = 0;

while (ite<MAX_ITERA) && (todoBien == 0)
    ite= ite + 1;
    
    todoBien = 1;
    
    for patr = 1 : CantPatrones
        neta = W * P(:,patr) + b;
        y = hardlim(neta);
        if T(patr) ~= y
            todoBien = 0;
            
            W = W + alfa * (T(patr) - y)*P(:,patr)';
            
            b = b + alfa * (T(patr) - y);
        end
    end
end