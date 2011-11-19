%% Limpiamos todo
clear all;
clc;

%% Leemos los datos de training para comprobar cuales clases son
% linealmente separables

Train = csvread('Segment_Train.csv');   % <210x20 double>

%% Mezcla de los datos utilidados para training
[CantidadPatrones, CantidadColumnas] = size(Train);
Train = Mezclar(Train);
TrainEscalado = Escalar(Train, 2, CantidadColumnas);

%% Generamos la matriz con los unos coincidiendo con el valor de la clase
Patrones = TrainEscalado(:,2:CantidadColumnas);
Clase = TrainEscalado(:,1);

%% Invertimos las matrices para trabajar con la red perceptron
Patrones = Patrones';
Clase = Clase';


