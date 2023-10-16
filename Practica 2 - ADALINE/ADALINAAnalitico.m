clear;
clc;
close all;

load DatosAND
%load DatosLS5
%load DatosLS10
%load DatosLS50
%load DatosOR
%load DatosXOR

%Data(:,end)=Data(:,end)==1;
X = Data(:, 1:end-1);
Y = Data(:, end);

%Añadimos una columna de -1s al final
X = [X, -ones(size(Data,1),1)];

%Calculamos el vector de pesos
transpose = X';
W = inv(transpose * X) * transpose * Y;

%Separamos en clases
Output = X * W;
Label = (X*W >= 0.5); 

%Obtenemos el ECM y el Acc
ECM = (norm(Y-Output, 2))^2 / size(Data,1); % ||Y-Output||^2
Acc = sum(Y == Label) / size(X,1);

