function [pop]=inicjalizacja(param)

popsize = param.K;       % liczba chromosomow K
chromlength = param.L;   % dlugosc wektora binarnego L
fenotyp_max = param.fenotyp_max;   % minmalna wartosc fenotupu, zdeokdowanego wektora binarnego
fenotyp_min = param.fenotyp_min;   % maksymalna wartosc fenotupu, zdeokdowanego wektora binarnego

% populacja poczatkowa
% pop = [chromosom, fenotyp, wartosc funkcji przystosowania]

%chromosom
pop = round(rand(popsize, chromlength+2));

% fenotyp (aktywne 1 z 3)
% 1) na podstawie klasycznego kodowania dwójkowego
pop(:, chromlength+1) = bin2dec(num2str(pop(:,1:chromlength)));

%org_pop=pop;

% 2) na podstawie odwzorowania liniowego kodu binarnego w dziedzine liczb rzeczywistych
%pop(:, chromlength+1) = fenotyp_min + ((fenotyp_max-fenotyp_min)/(2^chromlength - 1)) * bin2dec(num2str(pop(:,1:chromlength)));

% 3) na podstawie kodowanie binarnego liczby zmiennoprzecinkowej pojedynczej precyzji (chromlength = param.L = 32)
%-----------------
%    UWAGA: zlosliwe losowanie moze owocowac ciagiem binarnym, ktory po 'dekodowaniu' da np. NaN, Inf lub -Inf
%           co z kolei uniemozliwia prowadzenie dalszych obliczen ;), np. poprawna selekcja z metoda ruletki
%               [0 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1] -> NaN 
%               [1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1] -> NaN
%               [0 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1] -> NaN
%               [1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1] -> NaN
%               [0 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] -> Inf
%               [1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] -> -Inf 
%-----------------
%pop(:, chromlength+1) = typecast(uint32(bin2dec(char(pop(:,1:chromlength) + '0'))),'single');


%wartosc funkcji przystosowania -> ffun() to przykladowa funkcja w m-pliku
pop(:, chromlength+2) = ffun(pop(:, chromlength+1))

end