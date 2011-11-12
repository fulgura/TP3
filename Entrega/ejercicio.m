%% Limpiamos todo
clear all;
clc;

%% Leemos los datos especificos del TP
Train = csvread('Segment_Train.csv');   % <210x20 double>
Test = csvread('Segment_Test.csv');     % <2100x20 double>

%% Definimos los parametros necesarios para el experimento
FilasOcultas = 9;       % Disposicion de las neuronas de la capa oculta
ColumnasOcultas = 9;    % 

Alfa = 0.05;            % 
Beta = 0.05;            % 
MAX_ITE = 100;          % 

vecindad = 5;           % 

%% Mezcla de los datos utilidados para training
Train = Mezclar(Train);

Train = Escalar(Train, 1:3);

[CantPatrones, entradas] = size(Train);






