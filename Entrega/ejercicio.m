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
MAX_ITE = 1000;          % 
Salidas = 7;            % Cantidad de clases definidas
vecindad = 5;           % 

%% Mezcla de los datos utilidados para training
[CantidadPatrones, CantidadColumnas] = size(Train);
Train = Mezclar(Train);
TrainEscalado = Escalar(Train, 2, CantidadColumnas);

%% Generamos la matriz con los unos coincidiendo con el valor de la clase
Patrones = TrainEscalado(:,2:CantidadColumnas);
T = TrainEscalado(:,1);
Clase = TransformarClase(CantidadPatrones, Salidas, T);


%% Pasamos por la red SOM

W = Som(Patrones', MAX_ITE, Alfa, vecindad, FilasOcultas, ColumnasOcultas);

% [ clases, ganadoras] = Ganadoras( Patrones', Clase, W )

W2 = CapaSalida(Patrones', Clase', W, Salidas, (FilasOcultas * ColumnasOcultas), MAX_ITE, Beta)

















