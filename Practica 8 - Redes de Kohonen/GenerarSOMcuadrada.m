function W=GenerarSOMcuadrada(FC)
for i=1:FC(1)
    for j=1:FC(2)
        W(:,i,j)=[i j];
    end
end


W=W-1;
W=2.*W./(max(FC)-1);
W=W-1;