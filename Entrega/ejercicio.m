%% Limpiamos todo
clear all;
clc;


%% Definimos los parametros necesarios para el experimento
FilasOcultas = 9;       % Disposicion de las neuronas de la capa oculta
ColumnasOcultas = 9;    %

Alfa = 0.05;            %
Beta = 0.05;            %
MAX_ITE = 1000;          %
Salidas = 7;            % Cantidad de clases definidas
vecindad = 5;           %

AciertosTrain = [];
AciertosTest = [];

for i = 1 : 10
    %% Leemos los datos especificos del TP
    Train = csvread('Segment_Train.csv');   % <210x20 double>
    Test = csvread('Segment_Test.csv');     % <2100x20 double>
    
    
    
    %% Mezcla de los datos utilidados para training
    [CantidadPatrones, CantidadColumnas] = size(Train);
    Train = Mezclar(Train);
    TrainEscalado = Escalar(Train, 2, CantidadColumnas);
    
    %% Generamos la matriz con los unos coincidiendo con el valor de la clase
    Patrones = TrainEscalado(:,2:CantidadColumnas);
    T = TrainEscalado(:,1);
    Clase = TransformarClase(CantidadPatrones, Salidas, T);
    
    %% Invertimos las matrices para trabajar con la red
    Patrones = Patrones';
    Clase = Clase';
    
    %% Pasamos por la red SOM
    W = Som(Patrones, MAX_ITE, Alfa, vecindad, FilasOcultas, ColumnasOcultas);
    
    % [ clases, ganadoras] = Ganadoras( Patrones', Clase, W )
    
    W2 = CapaSalida(Patrones, Clase, W, Salidas, (FilasOcultas * ColumnasOcultas), MAX_ITE, Beta);
    
    %% Caluclamos las cantidades de correctamente clasificados en training y la
    % cantidada de correctamente clasificados para cada clase
    [ CantCorrectosTraining, CorrectosTraining ] = Resultados( Patrones, Clase, Salidas, (FilasOcultas * ColumnasOcultas), W ,W2 );
    
    %% La tasa de acierto por clase para el grupo de entrenamiento
    TasasAciertosTrain = [CorrectosTraining (CorrectosTraining ./ sum(Clase,2))];
    AciertosTrain = [AciertosTrain TasasAciertosTrain];
    
    %% Procesamos los valores a utilizar para testing
    
    [CantidadPatrones, CantidadColumnas] = size(Test);
    Test = Mezclar(Test);
    TestEscalado = Escalar(Test, 2, CantidadColumnas);
    
    %% Generamos la matriz con los unos coincidiendo con el valor de la clase
    Patrones = TestEscalado(:,2:CantidadColumnas);
    T = TestEscalado(:,1);
    Clase = TransformarClase(CantidadPatrones, Salidas, T);
    %% Invertimos las matrices para trabajar con la red
    Patrones = Patrones';
    Clase = Clase';
    
    %% Caluclamos las cantidades de correctamente clasificados en test y la
    % cantidada de correctamente clasificados para cada clase
    [ CantCorrectosTest, CorrectosTest ] = Resultados( Patrones, Clase, Salidas, (FilasOcultas * ColumnasOcultas), W ,W2 );
    
    %% La tasa de acierto por clase para el grupo de testeo
    TasasAciertosTest = [CorrectosTest (CorrectosTest ./ sum(Clase,2))];
    AciertosTest = [AciertosTest TasasAciertosTest];

end

dlmwrite('Salidas/AciertosTrain.csv',AciertosTrain,'delimiter','\t');
dlmwrite('Salidas/AciertosTest.csv',AciertosTest,'delimiter','\t');










