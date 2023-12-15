function W = IncrementarPesos(W,Patron,Vecindad,eta)
    [numAtt,numFil,numCol] = size(W);
    for i=1:1:numFil
        for j=1:1:numCol
            W(:,i,j) = W(:,i,j) + (eta*Vecindad(i,j) * (Patron-W(:,i,j))); %Cambio en el espacio de entrada
        end
    end
end

