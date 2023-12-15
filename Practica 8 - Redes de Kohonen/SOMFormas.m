clear;
clc;
close all;
 
load('DatosTri.mat');NumA=2;

eta0=0.9;
IterMax=1000;
FC=[8 6];
 
[NumDatos,~]=size(data); 
W=rand(NumA,FC(1),FC(2)); %Inicializar random los w
W=GenerarSOMcuadrada(FC);

DibujarW(W,FC);
DibujarD(data)
axis([-1.5 1.5 -1.5 1.5])
pause

Indices=GenerarIndices(FC);
for i=1:IterMax
    fprintf('i: %d\n',i);
    ind=randperm(NumDatos);
    for j=1:NumDatos
        eta=eta0*(1-i/IterMax); % Mal -> No estamos en lotes
        Patron=(data(ind(j),1:NumA))';
    
        [Gx,Gy]=CalculoGanadora(W,Patron);
        IndGan=[Gx,Gy]';
        
        Vecindad=FuncionVecindad(IndGan,W,Indices);
        W=IncrementarPesos(W,Patron,Vecindad,eta);

    end
    

    if mod(i,10)==0
        DibujarW(W,FC);
        DibujarD(data)
        axis([-1.5 1.5 -1.5 1.5])
        drawnow
    end

end

DibujarW(W,FC);
DibujarD(data)
axis([-1.5 1.5 -1.5 1.5])

figure
DibujarClase(data,W);
