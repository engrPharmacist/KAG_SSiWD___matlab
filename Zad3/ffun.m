function [ffun_value] = ffun(fenotyp)

% Przykladowa funkcja przystosowania

x = fenotyp;

%y= 15*sin(0.1*x)+10*sin(5*x)+7*cos(4*x);%1/3
y=- ( 15*sin(0.1*x)+10*sin(5*x)+7*cos(4*x));%2/4

ffun_value = y;

end