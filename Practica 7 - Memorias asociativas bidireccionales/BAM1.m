clear all;

x(1,:) = [1 1 1 -1 1 -1 -1 1 -1];
x(2,:) = [1 -1 -1 1 -1 -1 1 1 1];

y(1,:) = [1 -1 -1];
y(2,:) = [-1 -1 1];

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
        s(:,epoc)
        s2(:,epoc)
        break;
    end
end



