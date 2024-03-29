classdef ConjuntoDatos  < handle
    %CONJUNTODATOS Summary of this class goes here
    %   Detailed explanation goes here
    
    % The following properties can be set only by class methods
    properties (SetAccess = private)
        DatosOriginales
        ColumnaDesdeAtributos
        ColumnaHastaAtributos
        ColumnaClase
    end
    properties
        Datos
        CantidadPatrones
        CantidadAtributos
    end
    properties (Dependent = true, SetAccess = private)
        Patrones
        Clase
    end
    methods
        function CD = ConjuntoDatos(DatosOriginales, ColumnaDesdeAtributos, ColumnaHastaAtributos, ColumnaClase)
            CD.DatosOriginales = DatosOriginales;
            CD.ColumnaDesdeAtributos = ColumnaDesdeAtributos;
            CD.ColumnaHastaAtributos = ColumnaHastaAtributos;
            CD.ColumnaClase = ColumnaClase;
            
            CD.Datos = CD.DatosOriginales;
            
            [CD.CantidadPatrones, CD.CantidadAtributos] = size(CD.Datos);
            
        end
        %% Retorna la matriz de patrones utilizada para los calculos en la
        % neurona no lineal
        function patrones = get.Patrones(CD)
            patrones = CD.Datos(:, CD.ColumnaDesdeAtributos:CD.ColumnaHastaAtributos);
        end
        
        %% Retorna la el vector clase utilizado para los calculos en la
        % neurona no linal
        function clase = get.Clase(CD)
            clase = CD.Datos(:, CD.ColumnaClase);
        end
        %% Modifica el conjunto de datos desordenandolos en forma aleatoria
        function Mezclar(obj)
            
            mezcla = randperm(obj.CantidadPatrones);
            obj.Datos = obj.Datos(mezcla,:);
            
        end
        
        %% Hace el escalado de todas las columnas del conjunto de datos. 
        % El escalado se hace calculando (x-min) / (maximo-minimo)
        function Escalar(CD)
            
            for index=CD.ColumnaDesdeAtributos:CD.ColumnaHastaAtributos
                minimo = min(CD.Datos(:, index));
                maximo = max(CD.Datos(:, index));
                CD.Datos(:,index) = ((CD.Datos(:,index) - minimo) ./ (maximo - minimo));
            end
            
        end
        %% Hace el escalado de las columnas indicadas en los par?metros.
        function EscalarColumnas(CD, ColumnaDesde, ColumnaHasta)
            
            for index=ColumnaDesde:ColumnaHasta
                minimo = min(CD.Datos(:, index));
                maximo = max(CD.Datos(:, index));
                CD.Datos(:,index) = ((CD.Datos(:,index) - minimo) ./ (maximo - minimo));
            end
            
        end
        
        %% Vuelve a leer los datos con los que originalmente se creo la
        % instancia.
        % Los datos originales son guardados para poder voler a hacer
        % modificaciones (escalado, mezclado, escalado por columnas)
        function Recargar(CD)
            CD.Datos = CD.DatosOriginales;
            [CD.CantidadPatrones, CD.CantidadAtributos] = size(CD.Datos);
            
        end
        %% Separa el conjunto de datos original en dos nuevos subconjuntos 
        % La sepraci?n se hace mediante el par?metro porcentaje 
        % Los valores de retorno [Training Test] son tambi?n instancias de
        % la clase ConjuntoDatos
        function [Training Test] = Separar(CD,porcentaje)
            sizeM = size(CD.Datos);
            CantPatrones = sizeM(1);
            
            n = floor(CantPatrones*porcentaje);
            
            Training = ConjuntoDatos(CD.Datos(1:n,:), CD.ColumnaDesdeAtributos, CD.ColumnaHastaAtributos, CD.ColumnaClase);
            Test = ConjuntoDatos(CD.Datos((n+1):CantPatrones,:), CD.ColumnaDesdeAtributos, CD.ColumnaHastaAtributos, CD.ColumnaClase);
        end
    end
    
end

