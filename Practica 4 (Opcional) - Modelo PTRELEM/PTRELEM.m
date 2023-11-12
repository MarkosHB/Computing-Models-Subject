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


        % PTRELEM
        for J = 1:size(Y,2)
            % Obtener los patrones de la j-esima clase
            filas_clase_j = YTrainVal(:,J);
            C_j = XscaledTrainVal(filas_clase_j == 1, :);
            
            % Funcion de activacion
            m = t * C_j';
            Hj = 1 ./ (1 + exp(-m'));
            sumH = sum(Hj);
        
            % Matriz Mj
            Mj = [size(C_j,1) -sumH;
                 -sumH'  Hj'*Hj];

            matMs{J} = Mj;
        end

        % Calculo de M
        M = zeros(size(matMs{1},1));
        for J = 1:size(Y,2)
            M = M + matMs{J};
        end

        Bj = zeros(L+1,size(Y,2));
        % Calculo de los Bj
        for J = 1:size(Y,2)
            Bj(:,J) = eig(M,matMs{1,J} + C * eye(size(matMs{J},1)));
        end

        % Estimacion
        tPatron = size(YVal,1);
        MatrizMin = zeros(tPatron, size(YVal,2));
        Class_Rule = zeros(tPatron, size(YVal,2));

        m = t * XscaledVal';
        v = 1 ./ (1 + exp(-m));
        for J = 1:size(Y,2)
            Class_Rule(:,J) = abs(v' * Bj(2:end,J) - Bj(1,J)) / norm(Bj(2:end,J))^2 ;
        end
        [~, minIndices] = min(Class_Rule, [], 2);

        for pos = 1:tPatron
            MatrizMin(pos, minIndices(pos)) = 1;
        end
        
        Label = Class_Rule == MatrizMin;
        Performance(i,j) = sum(sum(Label==YVal)) / size(YVal,1);

    end
    j = 0;
end


C = [10^(-3) 10^(-2) 10^(-1) 1 10 100 1000];
L = [50 100 500 1000 1500 2000];

[maxValue, linearIndexesOfMaxes] = max(Performance(:));
[rowsOfMaxes colsOfMaxes] = find(Performance == maxValue);

Copt = C(rowsOfMaxes(1));
Lopt = L(colsOfMaxes(1));


