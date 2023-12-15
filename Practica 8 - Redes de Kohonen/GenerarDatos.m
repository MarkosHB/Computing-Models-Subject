clear;
clc;
close all;
Npat=200;
Count=0;
Data=[];

while Count<Npat 
    X=(3*rand(1,1))-1.5;
    Y=(2*rand(1,1))-0.5;
    Z=(Y>0) & (X<(1-Y))& (X>(Y-1));
    if Z==1 
        Data=[ Data; X Y 1];
        Count=Count+1;
    end
    size(Data);
end

MaxD=1;
MinD=-1;
Valmax=max(Data);
Valmin=min(Data);
Data=((MaxD-MinD)*(Data-Valmin)./(Valmax-Valmin))+MinD;

Data2=zeros(length(Data),5);
Data2(:,1:2)=Data(:,1:2);

Data2(:,3:5)=repmat([1 0 0],length(Data),1);
Data2(find(Data(:,2)>0),3:5)=repmat([0 1 0],length(find(Data(:,2)>0)),1);
Data2(find(Data(:,2)<0 &Data(:,1)<0),3:5)=repmat([0 0 1],length(find(Data(:,2)<0 &Data(:,1)<0)),1);

data=Data2;
% save (['DatosTri'  '.mat'], 'data')

DibujarD(data)