clear all;

barco = load("./Matrices/barco.mat");
coche = load("./Matrices/coche.mat");
textoBarco = load("./Matrices/textoBarco.mat");
textoCoche = load("./Matrices/textoCoche.mat");

x(1,:) = reshape(barco.barco, 1, size(barco.barco,1) * size(barco.barco,2));
x(2,:) = reshape(coche.coche, 1, size(coche.coche,1) * size(coche.coche,2));
y(1,:) = reshape(textoBarco.textoBarco, 1, size(textoBarco.textoBarco,1) * size(textoBarco.textoBarco,2));
y(2,:) = reshape(textoCoche.textoCoche, 1, size(textoCoche.textoCoche,1) * size(textoCoche.textoCoche,2));

w = x' * y;

epocMax = 21;
s = zeros(size(x,2), epocMax);
s2 = zeros(size(y,2),epocMax);
sinit = x(1,:); 
%sinit = x(2,:); 

s2init = sign(sinit*w);
s(:,1) = sinit;
s2(:,1) = s2init;

for epoc = 2 : 1 : epocMax
    % Recalcular la s
    s(:,epoc) = sign(w*s2(:,epoc-1));
    s2(:,epoc) = sign(s(:,epoc)'*w); 
    %No es epoc-1 pq s2 coge el actualizado de s
    
    if (sum(s(:,epoc) == s(:,epoc-1)) == size(x,2))
        subplot(3,1,1);
        imshow(reshape(s(:,1),size(barco.barco,1), size(barco.barco,2)));
        subplot(3,1,2);
        imshow(reshape(s2(:,epoc),size(textoBarco.textoBarco,1), size(textoBarco.textoBarco,2)));
        subplot(3,1,3);
        imshow(reshape(s(:,epoc),size(barco.barco,1), size(barco.barco,2)));
        break;
    end
end



