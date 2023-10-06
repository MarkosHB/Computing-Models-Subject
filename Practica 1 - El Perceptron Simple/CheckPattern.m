function Salida = CheckPattern(Data, W)
%Variable de control
Salida = true;

%Para cada uno de los patrones...
for i = 1:size(Data,1)
    %... obtenemos su prediccion y la salida prevista
    [in, out, target] = ValoresIOT(Data,W,i);
    % Si no coinciden, paramos de iterar
    if out ~= target
        Salida = false;
        break;
    end
end