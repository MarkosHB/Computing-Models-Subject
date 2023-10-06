function [Input,Output,Target]=ValoresIOT(Data,W,i)
%Eliminamos la ultima columna de la fila i seleccionada
Input = Data(i,1:end-1);
%El target (objetivo) es la ultima columna
Target = Data(i, end);
%La salida (prediccion) se obtiene a partir del potencial sinaptico
Output = Signo(W*[Input,-1]);

end