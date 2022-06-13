function [pop]=inicjalizacja(param)

popsize = param.K;       % liczba chromosomow K
chromlength = param.L;   % dlugosc wektora binarnego L
fenotyp_max = param.fenotyp_max;   % minmalna wartosc fenotupu, zdeokdowanego wektora binarnego
fenotyp_min = param.fenotyp_min;   % maksymalna wartosc fenotupu, zdeokdowanego wektora binarnego

pop = round(rand(popsize, chromlength+3));
for i = 1:popsize
    pop(i, 1:32) = dec2bin(typecast(single(fenotyp_min + (fenotyp_max - fenotyp_min).*rand(1,1)), 'uint32'), 32) - '0';
    pop(i, 33:64) = dec2bin(typecast(single(fenotyp_min + (fenotyp_max - fenotyp_min).*rand(1,1)), 'uint32'), 32) - '0';
end

% 3) na podstawie kodowanie binarnego liczby zmiennoprzecinkowej pojedynczej precyzji (chromlength = param.L = 32)
pop(:, chromlength+1) = typecast(uint32(bin2dec(num2str(pop(:,1:32)))),'single'); 
pop(:, chromlength+2) = typecast(uint32(bin2dec(num2str(pop(:,33:64)))),'single'); 

%wartosc funkcji przystosowania -> ffun() to przykladowa funkcja w m-pliku
pop(:, chromlength+3) = ffun([pop(:, chromlength+1); pop(:, chromlength+2)]);

end