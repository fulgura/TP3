%% Limpiamos todo
clear all;
clc;

fprintf('i, correctos, incorrectos\n');

for i = 1 : 7
    %% Leemos los datos de training para comprobar cuales clases son
    % linealmente separables
    
    Train = csvread('Segment_Train.csv');   % <210x20 double>
    
    %% Mezcla de los datos utilidados para training
    [CantidadPatrones, CantidadColumnas] = size(Train);
    Train = Mezclar(Train);
    TrainEscalado = Escalar(Train, 2, CantidadColumnas);
    
    %% Generamos la matriz con los unos coincidiendo con el valor de la clase
    Patrones = TrainEscalado(:,2:CantidadColumnas);
    T = TrainEscalado(:,1);
    
    %% Aplicamos la transformaci?n necesaria para poder correr un
    % perceptr?n y determinar si esa clase es linealmente separable
    Clase = TransformarClasePerceptron(T, i);
    
    %% Invertimos las matrices para trabajar con la red perceptron
    Patrones = Patrones';
    Clase = Clase';
    
    %% Parametros del perceptr?n
    Alfa = 0.05;
    MAX_ITERA = 1000;
    [W, b, ite] = Perceptron(Patrones, Clase, Alfa, MAX_ITERA);
    [correctos incorrectos] = EstadisticasPerceptron(Patrones, Clase, W, b);
    
    fprintf('%d, %d, %d\n', i, correctos, incorrectos)
end

