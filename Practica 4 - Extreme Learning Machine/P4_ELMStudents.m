clear all;

D = load('handwriting.mat');
X = D.X;

[N, K] = size(X);
J = 10;

Y = zeros(N,J);

% Generate the Y Label
for i =1:10
    Y(1+(500*(i-1)):i*500,i) =1;
end

% Scale the data
Xscaled = (X-min(X))./(max(X)-min(X));

% Remove the NaN elements
Xscaled = Xscaled(:,any(~isnan(Xscaled)));

% Compute again the number of total elements and attributes
[N, K] = size(Xscaled);

CVHO = cvpartition(N,'HoldOut',0.25);

XscaledTrain = Xscaled(CVHO.training(1),:);
XscaledTest = Xscaled(CVHO.test(1),:);
YTrain = Y(CVHO.training(1),:);
YTest = Y(CVHO.test(1),:);


% Create the validation set
[NTrain, K] = size(XscaledTrain);
CVHOV = cvpartition(NTrain,'HoldOut',0.25);

% Generate the validation sets
XscaledTrainVal = XscaledTrain(CVHOV.training(1),:);
XscaledVal = XscaledTrain(CVHOV.test(1),:);
YTrainVal = YTrain(CVHOV.training(1),:);
YVal = YTrain(CVHOV.test(1),:);

% Performance Matrix
Performance = zeros(7,6);

i = 0;
j = 0;
% Estimate the hyper-parameters values
for C = [10^(-3) 10^(-2) 10^(-1) 1 10 100 1000]
    i = i+1;
    for L = [50 100 500 1000 1500 2000]
        j = j+1;

        % generamos los t aleatorios
        t = 2*rand(L,K) - 1;

        % Calculamos la matriz H de activacion
        m = t * XscaledTrainVal';
        h = 1 ./ (1 + exp(-m'));

        % Calculamos la matriz de pesos
        I = eye(size(h,2));
        w = inv(I ./ C + h' * h) * h' * YTrainVal;

        mm = t * XscaledVal';
        h_val = 1 ./ (1+exp(-mm'));

        YestimatedVal = h_val * w;

        maxValores = max(YestimatedVal');

        tPatron = size(YVal);

        MatrizMax = zeros(tPatron) + maxValores';

        Label = YestimatedVal == MatrizMax;

        % Implementar el ELM neuronal, calcular el rendimiento asociado a C
        % y L
        Performance(i,j) = sum(sum(Label==YVal)) / size(YVal,1);
        
    end
    j=0;
end

C = [10^(-3) 10^(-2) 10^(-1) 1 10 100 1000];
L = [50 100 500 1000 1500 2000];

[maxValue, linearIndexesOfMaxes] = max(Performance(:));
[rowsOfMaxes colsOfMaxes] = find(Performance == maxValue);

Copt = C(rowsOfMaxes(1));
Lopt = L(colsOfMaxes(1));

% Calcular con el conjunto de entrenamiento el ELM neuronal y
% reportar el error cometido en test 90-94%

t = 2 * rand(Lopt, K) - 1;
m = t * XscaledTrain';
h = 1 ./ (1 + exp(-m'));

I = eye(size(h,2));
w = inv(I ./ Copt + h' * h) * h' * YTrain;

mm = t * XscaledTest';
h_val = 1 ./ (1+exp(-mm'));

YestimatedVal = h_val * w;

maxValores = max(YestimatedVal');

tPatron = size(YTest);

MatrizMax = zeros(tPatron) + maxValores';

Label = YestimatedVal == MatrizMax;

ACC = sum(sum(Label == YTest)) / size(YTest,1)
ERM = sum(sum(Label ~= YTest)) / size(YTest,1)


