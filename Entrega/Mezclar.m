function [ M ] = Mezclar( Datos )
%MEZCLAR Summary of this function goes here
%   Detailed explanation goes here

[CantidadPatrones, CantidadAtributos] = size(Datos);

mezcla = randperm(CantidadPatrones);
M = Datos(mezcla,:);
end

