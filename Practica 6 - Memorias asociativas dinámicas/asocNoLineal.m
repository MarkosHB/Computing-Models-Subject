clear all;

numIt = 21;
s = [-1 -1 1 1 1]; %patron a memorizar
w = (1/size(s,2)) * s' * s;

%Quitamos las autoconexiones
w = w - diag(diag(w));

S = zeros(size(s,2), numIt);
%S(:,1) = [-1 -1 1 -1 1];
S(:,1) = [1 1 -1 -1 1];

last_e = 2;
for t = 2 : numIt
    cambio = false;
    S(:,t) = S(:,t-1);
    for i = 1 : size(s,2)
        h = sum(S(:,t)' .* w(i,:), "all");
        S(i,t) = (h>0) * 2 -1; %Escala [-1,1]
        cambio = cambio || S(i,t) ~= S(i,t-1);
    end

    if ~ cambio
        last_e = t;
        break;
    end
end

disp(S(:,last_e)');
