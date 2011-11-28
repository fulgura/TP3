function y = hardlimSafe(x)
% 
% Esta funcion reemplaza la funcion hardlim la cual realiza el chequeo de
% variables por cada invocacion
% 
% 
% 
y = x >= 0;