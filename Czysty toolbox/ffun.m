function [ffun_value] = ffun(fenotyp)

% Przykladowa funkcja przystosowania

x = fenotyp;

y = -(x .* x) + 31.0 * x;

ffun_value = y;

end