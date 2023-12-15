function DibujarW(W,FC)
clf
Wr=reshape(W,2,FC(1)*FC(2));
plot(W(1,:),W(2,:),'ro');hold on;
for x=1:FC(1)-1
    for y=1:FC(2)
        plot([W(1,x,y) W(1,x+1,y)],[W(2,x,y) W(2,x+1,y)],'-r')
    end
end
for x=1:FC(1)
    for y=1:FC(2)-1
        plot([W(1,x,y) W(1,x,y+1)],[W(2,x,y) W(2,x,y+1)],'-r')
    end
end