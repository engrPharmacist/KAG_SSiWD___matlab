function [ffun_value] = ffun(fenotyp)

% Przykladowa funkcja przystosowania

x = fenotyp;

y = (sin(x).^2)./(1+0.5*x)+0.5;
ffun_value = y;

end