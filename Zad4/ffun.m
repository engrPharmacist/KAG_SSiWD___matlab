function [ffun_value] = ffun(fenotyp)

% Przykladowa funkcja przystosowania
x_1 = fenotyp(1,:);
x_2 = fenotyp(2,:);
if x_1<-5 || x_1>5 || isnan(x_1)
    y= 120
elseif x_2<-5 || x_2>5 || isnan(x_2)
    y= 120
else
%y=-20*exp(-0.2*sqrt(0.5*(x_1.^2+x_2.^2)))-exp(0.5*(cos(2*pi*x_1)+cos(2*pi*x_2)))+20+exp(1);
y=(sin(x_1 + x_2)+(x_1-x_2)^2)- 1.5*x_1+2.5*x_2+1;
end
ffun_value = y;
end