%% TransformarClase

function [nuevaClase] = TransformarClase(CantidadPatrones, CantidadClases, T)

nuevaClase = zeros(CantidadPatrones, CantidadClases);

for index = 1:CantidadPatrones
    nuevaClase(index, T(index)) = 1;
end

end
