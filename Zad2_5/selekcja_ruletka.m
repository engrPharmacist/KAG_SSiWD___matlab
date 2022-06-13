function [newpop]=selekcja_ruletka(oldpop, param)
 
popsize = param.K;       % liczba chromosomow K
chromlength = param.L;   % dlugosc wektora binarnego L

% suma przystosowan wszyskich chromosomow w poulacji
totalfit=sum(oldpop(:,chromlength+2));

% prawdopodobienstwo wylosowania kazdego z chromosomow
prob=oldpop(:,chromlength+2) / totalfit;

% suma skumulowana wyzej wyznaczonych prawdopodobienstw = 1 (pelne kolo ruletki)
prob=cumsum(prob);

% wektor liczb losowych (na potrzeby krecenia kolem ruletki)
rns=sort(rand(popsize,1));

% zmienne pomocnicze
fitin=1; newin=1;

% selekcja chromosomow do nowej populacji
while newin<=popsize
    
    if (rns(newin)<prob(fitin))
        
        newpop(newin,:)=oldpop(fitin,:);
        newin=newin+1;
        
    else
        
        fitin=fitin+1;
        
    end
    
end

end