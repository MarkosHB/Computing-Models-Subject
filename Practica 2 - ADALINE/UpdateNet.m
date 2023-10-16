function W = UpdateNet(W,LR,Output,Target,Input)
% Discretizamos las salidas
out = Signo(Output);

%Calculamos el nuevo peso a partir de la regla de aprendizaje 
W = W + LR * (Target - out) * [Input, -1]';

end