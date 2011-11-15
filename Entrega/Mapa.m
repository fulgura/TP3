function [ mapa ] = Mapa( FilasOcultas, ColumnasOcultas, clases)
%MAPA 
%  

fid=fopen('Salidas/mapa.csv','A');

mapa = cell(FilasOcultas, ColumnasOcultas);
ocultas = FilasOcultas * ColumnasOcultas;
for nro = 1:ocultas 
    texto = ''; 
    for cl = 1:length(clases(1,:)) 
        if clases(nro, cl) > 0 
            if ~isempty(texto)
                texto = strcat(texto, ' ; '); 
            end 
            textoA = sprintf('c%d->%d', cl, clases(nro,cl));
            texto= [texto textoA];
        end; 
    end; 
    fila = FilasOcultas -floor( (nro-1)/ColumnasOcultas ); 
    col  = mod( (nro-1), ColumnasOcultas ) + 1; 
    mapa(fila,col) = {[texto]};
    fprintf(fid,'%s,',texto);
    if (col == ColumnasOcultas)
        fprintf(fid, '\n');
    end
end; 

fclose(fid);

end

