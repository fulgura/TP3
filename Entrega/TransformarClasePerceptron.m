function [ T ] = TransformarClasePerceptron( Clase, NroClase )
%TRANSFORMARCLASEPERCEPTRON Summary of this function goes here
%   Detailed explanation goes here

[CantPatrones, Cols] = size(Clase);

T = zeros(CantPatrones, 1);

for i = 1 : CantPatrones
    if(Clase(i) == NroClase)
        T(i) = 1;
    end
end

end

