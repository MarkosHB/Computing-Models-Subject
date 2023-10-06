function W = UpdateNet(W,LR,Output,Target,Input)

%Calculamos el nuevo peso a partir de la regla de aprendizaje 
W = W + LR * (Target - Output) * Input;

end