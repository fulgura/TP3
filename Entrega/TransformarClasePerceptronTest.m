%% Limpiamos todo
clear all;
clc;

%% Leemos los datos especificos del TP
Train = csvread('Segment_Train.csv');   % <210x20 double>



%% Mezcla de los datos utilidados para training
[CantidadPatrones, CantidadColumnas] = size(Train);
Train = Mezclar(Train);


TrainEscalado = Escalar(Train, 2, CantidadColumnas);

%% Generamos la matriz con los unos coincidiendo con el valor de la clase
Patrones = TrainEscalado(:,2:CantidadColumnas);

T = TrainEscalado(:,1);
Clase = TransformarClasePerceptron(T, 3);

T = T(1:10,:)
Clase = Clase(1:10,:)
