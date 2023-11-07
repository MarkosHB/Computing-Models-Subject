function [y, h, s, u] = salidaRed(patron, t, w, Beta)
%% Función que calcula la salida de la red (y), los pesos (h, s) y la salida de la capa oculta (s)
%% ->> Completar aquí <<-
u = patron * t';
s = logistica(u,Beta);
h = s * w';
y = logistica(h,Beta);            %cálculo de salida de la red, capa de salida
end

