function Vecindad = FuncionVecindad(IndGan,W,Indices)
    [numAtt,numFil,numCol] = size(W);
    Vecindad = zeros(numFil,numCol);
    
    for i=1:1:numFil
        for j=1:1:numCol
            if (IndGan(1)==i && IndGan(2)==j)
                Vecindad(i,j) = 1; %Ganador
            else
                if (sum(abs(IndGan-Indices(:,i,j))==1))
                    Vecindad(i,j) = 0.15; %Suma exacta de uno
                end
            end
        end
    end
end

