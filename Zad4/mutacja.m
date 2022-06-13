function [child]=mutacja(parent, param)

chromlength = param.L;              % dlugosc wektora binarnego L
pm = param.pm;                      % prawdopodobienstwo mutacji
fenotyp_max = param.fenotyp_max;    % minmalna wartosc fenotupu, zdeokdowanego wektora binarnego
fenotyp_min = param.fenotyp_min;    % maksymalna wartosc fenotupu, zdeokdowanego wektora binarnego

if (rand<pm)
    
    mpoint=round(rand*(chromlength-1))+1;
    
    child=parent;
    
    child(mpoint)=abs(parent(mpoint)-1);
    
    % 3) na podstawie kodowanie binarnego liczby zmiennoprzecinkowej pojedynczej precyzji (chromlength = param.L = 32)
    child(:, chromlength+1) = typecast(uint32(bin2dec(num2str(child(:,1:chromlength/2)))),'single');
    child(:, chromlength+2) = typecast(uint32(bin2dec(num2str(child(:,chromlength/2+1:chromlength)))),'single');
    
    %wartosc funkcji przystosowania dziecka -> ffun() to przykladowa funkcja w m-pliku
    child(:, chromlength+3)=ffun([child(:, chromlength+1); child(:, chromlength+2)]);
    
    if child(:, chromlength+1) > fenotyp_max || child(:, chromlength+1) < fenotyp_min
        val1 = fenotyp_min + (fenotyp_max - fenotyp_min).*rand(1,1);
        child(:, 1:chromlength/2) = dec2bin(typecast(single(val1), 'uint32'), chromlength / 2) - '0';
        child(:, chromlength+1) = typecast(uint32(bin2dec(num2str(child(:,1:chromlength/2)))),'single'); 
    end
    
    if child(:, chromlength+2) > fenotyp_max || child(:, chromlength+2) < fenotyp_min
        val2 = fenotyp_min + (fenotyp_max - fenotyp_min).*rand(1,1);
        child(:, chromlength/2+1:chromlength) = dec2bin(typecast(single(val2), 'uint32'), chromlength / 2) - '0';
        child(:, chromlength+2) = typecast(uint32(bin2dec(num2str(child(:,chromlength/2+1:chromlength)))),'single');
    end
    
    child(:, chromlength+3)=ffun([child(:, chromlength+1); child(:, chromlength+2)]);
    
else
    
    child=parent;
    
end

end