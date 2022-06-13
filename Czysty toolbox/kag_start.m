%-------------------------------------------------------------------------
% Klasyczny Algorytm Genetyczny
% - prosta implementacja algorytmu genetycznego - SSiWD
%-------------------------------------------------------------------------
clc
clear

% Parametry algorytmu SGA
%-------------------------------------------------------------------------
param.K = 4 * 2;        % liczba chromosomow K w popoulacji (ze wzgledu na przyjeta strategie powinna byc parzysta)

param.L = 5;            % dlugosc wektora binarnego L
%param.L = 16;            % dlugosc wektora binarnego L - odwzorowanie liniowe, np. L = 16
%param.L = 32;            % dlugosc wektora binarnego L - kodowanie binarne liczby zmiennoprzecinkowej pojedynczej precyzji, L = 32

param.fenotyp_max = 0;   % minmalna wartosc fenotupu, zdeokdowanego wektora binarnego
param.fenotyp_min = 31;  % maksymalna wartosc fenotupu, zdeokdowanego wektora binarnego

param.maxgen = 15;      % maksymalna liczba generacji algorytmu
param.pc = 0.85;        % prawdopodobienstwo krzyzowania
param.pm = 0.1;         % prawdopodobienstwo mutacji


% Inicjalizacja populacji poczatkowej
%-------------------------------------------------------------------------
% pop = [chromosom, fenotyp, wartosc funkcji przystosowania]
pop = inicjalizacja(param);

% Ryunek - aktualna populacja na tle optymalizowanej funkcji
figure

% Realizacja warunku zatrzymania
for gen = 1:1:param.maxgen
    
    clc; disp(['Generacja KAG : ',num2str(gen),'/',num2str(param.maxgen)]);
    
    % Dzialanie operatorow genetycznych na biezacej populacji rodzicielskiej
    for i=1:2:param.K
        
        % Krzyrzowanie
        %---------------
        parent1 = pop(i,:);
        parent2 = pop(i+1,:);
        
        [child1, child2] = krzyzowanie(parent1, parent2, param);
        
        pop(i,:) = child1;
        pop(i+1,:) = child2;
        
        % Mutacja
        %---------------
        parent = pop(i,:);
        [child] = mutacja(parent, param);
        pop(i,:) = child;
        
        parent = pop(i+1,:);
        [child] = mutacja(parent, param);
        pop(i+1,:) = child;
        
    end
    
    % Wybor puli rodzicielskiej dla kolejnej generacji
    pop = selekcja_ruletka(pop, param);
    
    % Aktualizuj Rysunek
    xx = 0:0.1:31;       
    yy = ffun(xx);
    
    % Uwaga: przy kodowaniu binarnym liczby zmiennoprzecinkowej pojedynczej precyzji
    %        poszczegolne osobniki moga sie lokowac poza domyslnie obserwowanym
    %        obszarem <0,31> 
    plot(xx,yy,pop(:,end-1),pop(:,end),'ro'); xlim([0 31]);  grid on; 
    
    % Pauza by na rysunku zaobserwowac progres w rozwiazywaniu zadania
    pause(0.5)

end

% Wynik
[wynik, ktory] = max(pop(:,end));
plot(xx,yy,pop(ktory,end-1),pop(ktory,end),'ko','MarkerSize',10); xlim([0 31]); grid on;
disp(['MAX: x(fenotyp) = ',num2str(pop(ktory,end-1)),'; f(x) = ',num2str(wynik)]);
