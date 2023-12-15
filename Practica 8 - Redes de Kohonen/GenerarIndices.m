function Indices=GenerarIndices(FC)
Indices=zeros(2,FC(1),FC(2));
for x=1:FC(1)
    for y=1:FC(2)
        Indices(:,x,y)=[x,y];
    end
end