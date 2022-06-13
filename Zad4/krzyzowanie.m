function [child1, child2]=krzyzowanie(parent1, parent2, param)

chromlength = param.L;              % dlugosc wektora binarnego L
pc = param.pc;                      % prawdopodobienstwo krzyzowania
fenotyp_max = param.fenotyp_max;    % minmalna wartosc fenotupu, zdeokdowanego wektora binarnego
fenotyp_min = param.fenotyp_min;    % maksymalna wartosc fenotupu, zdeokdowanego wektora binarnego

if (rand<pc)
    
    %podwujne krzyrzowanie
    punkt_krzyzowania1=round(rand*(chromlength-2))+1;
    punkt_krzyzowania2=round(rand*(chromlength-2))+1;
    
    if punkt_krzyzowania2 == punkt_krzyzowania1
       punkt_krzyzowania2 = punkt_krzyzowania2+1;
    end
    if punkt_krzyzowania1>punkt_krzyzowania2
        temp=punkt_krzyzowania1;
        punkt_krzyzowania1=punkt_krzyzowania2;
        punkt_krzyzowania2=temp;
    end
    
    % krzyrzowanie rodzicow
    child1=[parent1(:,1:punkt_krzyzowania1) parent2(punkt_krzyzowania1+1:punkt_krzyzowania2) parent1(:,punkt_krzyzowania2+1:chromlength)];
    child2=[parent2(:,1:punkt_krzyzowania1) parent1(punkt_krzyzowania1+1:punkt_krzyzowania2) parent2(:,punkt_krzyzowania2+1:chromlength)];
    
    %  na podstawie kodowanie binarnego liczby zmiennoprzecinkowej pojedynczej precyzji (chromlength = param.L = 32)
    child1(:, chromlength+1)=typecast(uint32(bin2dec(num2str(child1(:,1:chromlength/2)))),'single');
    child1(:, chromlength+2)=typecast(uint32(bin2dec(num2str(child1(:,chromlength/2+1:chromlength)))),'single');
    
    child2(:, chromlength+1)=typecast(uint32(bin2dec(num2str(child2(:,1:chromlength/2)))),'single');
    child2(:, chromlength+2)=typecast(uint32(bin2dec(num2str(child2(:,chromlength/2+1:chromlength)))),'single');
    
    %wprowadzanie ograniczenia na obszar dostępnyh rozwiązań 
    if child1(:, chromlength+1) > fenotyp_max || child1(:, chromlength+1) < fenotyp_min
        val1 = fenotyp_min + (fenotyp_max - fenotyp_min).*rand(1,1);
        child1(:, 1:chromlength/2) = dec2bin(typecast(single(val1), 'uint32'), chromlength / 2) - '0';
        child1(:, chromlength+1) = typecast(uint32(bin2dec(num2str(child1(:,1:chromlength/2)))),'single');
    end
    if  child1(:, chromlength+2) > fenotyp_max || child1(:, chromlength+2) < fenotyp_min
        val2 = fenotyp_min + (fenotyp_max - fenotyp_min).*rand(1,1);
        child1(:, chromlength/2+1:chromlength) = dec2bin(typecast(single(val2), 'uint32'), chromlength / 2) - '0';
        child1(:, chromlength+2) = typecast(uint32(bin2dec(num2str(child1(:,chromlength/2+1:chromlength)))),'single');
    end
    if child2(:, chromlength+1) > fenotyp_max || child2(:, chromlength+1) < fenotyp_min
        val1 = fenotyp_min + (fenotyp_max - fenotyp_min).*rand(1,1);
        child2(:, 1:chromlength/2) = dec2bin(typecast(single(val1), 'uint32'), chromlength / 2) - '0';
        child2(:, chromlength+1) = typecast(uint32(bin2dec(num2str(child2(:,1:chromlength/2)))),'single');
    end
    if child2(:, chromlength+2) > fenotyp_max || child2(:, chromlength+2) < fenotyp_min
        val2 = fenotyp_min + (fenotyp_max - fenotyp_min).*rand(1,1);
        child2(:, chromlength/2+1:chromlength) = dec2bin(typecast(single(val2), 'uint32'), chromlength / 2) - '0';
        child2(:, chromlength+2) = typecast(uint32(bin2dec(num2str(child2(:,chromlength/2+1:chromlength)))),'single');
    end
    
    
    %wartosc funkcji przystosowania dzieci -> ffun() to przykladowa funkcja w m-pliku
    child1(:, chromlength+3)=ffun([child1(:, chromlength+1); child1(:, chromlength+2)]);
    child2(:, chromlength+3)=ffun([child2(:, chromlength+1); child2(:, chromlength+2)]);
    
else
    
    child1=parent1;
    child2=parent2;
    
end

end