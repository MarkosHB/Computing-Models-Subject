function [Input,Output,Target] = ValoresIOT(Data,W, i)
Input = Data(i, 1:end-1);
Target = Data(i, end);
Output = [Input, - 1] * W; %Sin funcion signo
end

