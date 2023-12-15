function [Gx,Gy] = CalculoGanadora(W,Patron)
    Gx=1;
    Gy=1;
    distOpt = inf;
    [numAtt,numFil,numCol] = size(W);
    
    for i=1:1:numFil
        for j=1:1:numCol
            dist = norm(W(:,i,j)-Patron,2);
            if dist < distOpt
                Gx=i;
                Gy=j;
                distOpt=dist;
            end
        end
    end
end

