function [child]=mutacja(parent, param)

chromlength = param.L;              % dlugosc wektora binarnego L
pm = param.pm;                      % prawdopodobienstwo mutacji
fenotyp_max = param.fenotyp_max;    % minmalna wartosc fenotupu, zdeokdowanego wektora binarnego
fenotyp_min = param.fenotyp_min;    % maksymalna wartosc fenotupu, zdeokdowanego wektora binarnego

if (rand<pm)
    
    mpoint=round(rand*(chromlength-1))+1;
    
    child=parent;
    
    child(mpoint)=abs(parent(mpoint)-1);
    
    % fenotyp dziecka (aktywne 1 z 3)
    % 1) na podstawie klasycznego kodowania dwójkowego
    child(:, chromlength+1)=bin2dec(num2str(child(:,1:chromlength)));
    
    % 2) na podstawie odwzorowania liniowego kodu binarnego w dziedzine liczb rzeczywistych
    %child(:, chromlength+1)=fenotyp_min + ((fenotyp_max-fenotyp_min)/(2^chromlength - 1)) * bin2dec(num2str(child(:,1:chromlength)));
    
    % 3) na podstawie kodowanie binarnego liczby zmiennoprzecinkowej pojedynczej precyzji (chromlength = param.L = 32)
    %child(:, chromlength+1)=typecast(uint32(bin2dec(num2str(child(:,1:chromlength)))),'single');
    
    
    %wartosc funkcji przystosowania dziecka -> ffun() to przykladowa funkcja w m-pliku
    child(:, chromlength+2)=ffun(child(:, chromlength+1));
    
else
    
    child=parent;
    
end

end