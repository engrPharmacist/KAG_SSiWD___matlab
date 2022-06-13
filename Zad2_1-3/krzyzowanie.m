function [child1, child2]=krzyzowanie(parent1, parent2, param)

chromlength = param.L;              % dlugosc wektora binarnego L
pc = param.pc;                      % prawdopodobienstwo krzyzowania
fenotyp_max = param.fenotyp_max;    % minmalna wartosc fenotupu, zdeokdowanego wektora binarnego
fenotyp_min = param.fenotyp_min;    % maksymalna wartosc fenotupu, zdeokdowanego wektora binarnego

if (rand<pc)
    
    % okreslenie punktu krzyzowania
    cpoint=round(rand*(chromlength-2))+1;
    
    % krzyrzowanie rodzicow
    child1=[parent1(:,1:cpoint) parent2(:,cpoint+1:chromlength)];
    child2=[parent2(:,1:cpoint) parent1(:,cpoint+1:chromlength)];
    
    % fenotyp dzieci (aktywne 1 z 3)
    % 1) na podstawie klasycznego kodowania dwójkowego    
    child1(:, chromlength+1)=bin2dec(num2str(child1(:,1:chromlength)));
    child2(:, chromlength+1)=bin2dec(num2str(child2(:,1:chromlength)));
    
    % 2) na podstawie odwzorowania liniowego kodu binarnego w dziedzine liczb rzeczywistych
    %child1(:, chromlength+1)=fenotyp_min + ((fenotyp_max-fenotyp_min)/(2^chromlength - 1)) * bin2dec(num2str(child1(:,1:chromlength)));
    %child2(:, chromlength+1)=fenotyp_min + ((fenotyp_max-fenotyp_min)/(2^chromlength - 1)) * bin2dec(num2str(child2(:,1:chromlength)));
    
    % 3) na podstawie kodowanie binarnego liczby zmiennoprzecinkowej pojedynczej precyzji (chromlength = param.L = 32)
    %child1(:, chromlength+1)=typecast(uint32(bin2dec(num2str(child1(:,1:chromlength)))),'single');
    %child2(:, chromlength+1)=typecast(uint32(bin2dec(num2str(child2(:,1:chromlength)))),'single');

    
    %wartosc funkcji przystosowania dzieci -> ffun() to przykladowa funkcja w m-pliku
    child1(:, chromlength+2)=ffun(child1(:, chromlength+1));
    child2(:, chromlength+2)=ffun(child2(:, chromlength+1));
    
else
    
    child1=parent1;
    child2=parent2;
    
end

end