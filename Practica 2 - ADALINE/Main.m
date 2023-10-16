clear;
clc;
close all;

load DatosAND
%load DatosLS5
%load DatosLS10
%load DatosLS50
%load DatosOR
%load DatosXOR

Data(:,end)=Data(:,end)==1;

LR=0.5;
Limites=[-1.5, 2.5, -1.5, 2.5];
MaxEpoc=100;

%W=PerceptronWeigthsGenerator(Data);
W = [0;0;0];
ECM= zeros(MaxEpoc,1);

Epoc=1;

while ~CheckPattern(Data,W) && Epoc<MaxEpoc

    total_error = 0;
    error = 0;

     for i=1:size(Data,1)
        [Input,Output,Target]=ValoresIOT(Data,W,i);
       
        %GrapDatos(Data,Limites);
        %GrapPatron(Input,Output,Limites);
        %GrapNeuron(W,Limites);hold off;
        %drawnow
%         pause;
        
        if Signo(Output)~=Target %Discretizamos el output
           W=UpdateNet(W,LR,Output,Target,Input);
        end
        
        %GrapDatos(Data,Limites);
        %GrapPatron(Input,Output,Limites)
        %GrapNeuron(W,Limites);hold off;
        %drawnow
%         pause;

        error = (Target-Output)^2;
        total_error = total_error + error;
     
     end
     
    ECM(Epoc) = total_error / size(Data,1);
    Epoc=Epoc+1;
end

if CheckPattern(Data,W)
    fprintf("Sale Bien")
else
    fprintf("No sale")
end
