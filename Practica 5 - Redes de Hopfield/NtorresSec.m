clear all;

% Inicializacion
N = 8;
Theta = zeros(N,N);
Theta(:,:) = -1;

w = zeros(N,N,N,N);

for i=1 : 1:N
    for j=1 : 1:N
        w(i,j,1:N,j) = -2;
        w(i,j,i,1:N)= -2;
        w(i,j,i,j) = 0;
    end
end

% Evolucion de la red
epoc = 20;
Shist = zeros(N,N,epoc);

last_e = 2;
for e = 2:epoc
    Shist(:,:,e) = Shist(:,:,e-1);
    for i=1:N
        for j=1:N
            h = 0;
            for l=1:N
                for k=1:N
                    h = h+Shist(l,k,e)*w(i,j,l,k);
                end
            end
            Shist(i,j,e) = int16(h>Theta(i,j));
        end
    end
    cambio = Shist(i,j,e) ~= Shist(i,j,e-1);
    if cambio
        last_e = e;
        break;
    end
end

Shist(:,:,last_e);
  



