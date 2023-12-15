function DibujarClase(data,W)
%Indica en qué clase se ha especializado cada neurona
[NA,NNx,NNy]=size(W);
[Nd,~]=size(data);
VC=[1 2 3 1 2 3];

MapF=zeros(NNx,NNy,3);
for i=1:3
T=data(:,NA+1:end);
IndC=find(T(:,i));
LC=length(IndC);

MapT=ones(NNx,NNy,3);

Map=zeros(NNx,NNy);
    for j=1:length(IndC)
        Patron=(data(IndC(j),1:NA))';
        [Gx,Gy]=CalculoGanadora(W,Patron);
        Map(Gx,Gy)=Map(Gx,Gy)+1;
    end
    
    LevelMin=0.3;
    Map2=Map/max(max(Map));
    Map2(find(~Map2))=-LevelMin*2;
    Map3=Map2/2+LevelMin;
    MapT(:,:,VC(i+1))=MapT(:,:,VC(i+1))-Map3;
    MapT(:,:,VC(i+2))=MapT(:,:,VC(i+2))-Map3;
    
    MapF=MapF+MapT;
   subplot(2,3,i); image(MapT)
end
MapF=MapF-2;    
subplot(2,3,5);image(MapF);
drawnow;