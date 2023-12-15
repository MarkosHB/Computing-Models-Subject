function DibujarD(data)
A1=repmat([1 0 0],length(data),1);
B1=data(:,3:5);
Clase1=find(sum(B1==A1,2)==3);
plot(data(Clase1,1),data(Clase1,2),'Color','b','Marker','x','LineStyle','none');hold on;
A2=repmat([ 0  1 0],length(data),1);
B2=data(:,3:5);
Clase2=find(sum(B2==A2,2)==3);
plot(data(Clase2,1),data(Clase2,2),'Color','b','Marker','*','LineStyle','none');hold on;
A3=repmat([ 0  0 1],length(data),1);
B3=data(:,3:5);
Clase3=find(sum(B3==A3,2)==3);
plot(data(Clase3,1),data(Clase3,2),'Color','b','Marker','+','LineStyle','none');hold on;

