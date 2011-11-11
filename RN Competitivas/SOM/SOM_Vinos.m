clear all
clc


%% Leemos el Archivo de Vinos para generar el P
Datos = csvread('Vinos.csv');
[Filas Columnas] = size(Datos);
Datos = escalar(Datos, 2:Columnas);
P = Datos(:, 2:Columnas);
NroClase = Datos(:, 1);
P = P';



% Disposicion de las neuronas de la capa oculta
fil_ocultas =6;
col_ocultas = 5;
pos = gridtop( col_ocultas, fil_ocultas);
pasos=linkdist(pos);
[entradas, CantPatrones] = size(P);
ocultas = fil_ocultas * col_ocultas;

mezcla = randperm(CantPatrones);
P = P(:, mezcla);
NroMezcla = NroClase(mezcla);


% Pesos iniciales
W = 0.5 * ones(entradas,ocultas);

%% Definimos variables
vecinas=3;
ITE_MAX = 500;
alfa = 0.05;
ite = 0;
Reduccion = 20;
WAnt = 100 * ones(entradas,ocultas);
Dife = mean(sqrt(sum((WAnt - W).^2)));
ITE_MIN = (vecinas + 2) * Reduccion;


%% Calculo del SOM0
while ( (ite <= ITE_MAX ) & (Dife > 0.00001) ) || (ite < ITE_MIN),
    
    WAnt = W;
    for patr = 1:CantPatrones,
        %% buscar el W mas proximo
        % mayor contiene el n?mero de neurona ganadora
        
        distancias = sqrt(sum((P(:,patr) * ones(1,ocultas) - W).^2));
        [DMin, ganadora] = min(distancias);
        
        %% Actualizar la neurona ganadora y su vecindad
        for c = 1:ocultas
            if pasos(ganadora, c) <= vecinas
                % Actualizar W por que es la ganadora o la vecina
                W(:,c) = W(:,c) + alfa * (P(:, patr) - W(:, c));
            end
        end
        
    end
    Dife = mean(sqrt(sum((WAnt - W).^2)));
    
    if (vecinas>=1) & (mod(ite,Reduccion)==0),
        vecinas = vecinas-1;
    end
    ite = ite + 1;
    
    %% Imprimimos variables que nos interesan
    [ite]
    
end


%% Dibujemos la red de los ejemplos de Vino TIPO I

mapa = zeros(fil_ocultas, col_ocultas);

for patr = 1:CantPatrones
    
    if NroClase(patr) == 1
        % buscar el W m?s pr?ximo
        distancias = sqrt(sum((P(:,patr)*ones(1,ocultas) - W) .^2));
        [DMin, ganadora] = min(distancias);
        mapa(ganadora) = mapa(ganadora) + 1;
    end
    
end



for f=fil_ocultas:-1:1
    mapa(f,:)
end

mapa(fil_ocultas:-1:1,:)


% %% mapa para todas las clases
% % calcular para c/clase la lista de patrones que contiene
% clases = [];
% clases = zeros(ocultas,max(NroClase));
% for i = 1:CantPatrones,
%     %Calcular la neurona ganadora
%     [DMax mayor] = max(-sqrt( sum(((ones(ocultas,1)*P(i,:) - W).^2),2 ) ));
%     c = NroClase(i); %ven?a con los patrones
%     clases(mayor, c) = clases(mayor, c ) + 1;
% end

