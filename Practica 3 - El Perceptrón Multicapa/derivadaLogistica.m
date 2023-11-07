function [Y] = derivadaLogistica(X,beta)
%% Calcula la derivada de la función logística para cada uno de los elementos del vector columna X
    %% ->> Completar aquí <<-
    g_x = logistica(X, beta);
    Y = 2 * beta * g_x .* (1 - g_x);
end

