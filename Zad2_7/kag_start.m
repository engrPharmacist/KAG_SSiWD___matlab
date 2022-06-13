%-------------------------------------------------------------------------
% Klasyczny Algorytm Genetyczny
% - prosta implementacja algorytmu genetycznego - SSiWD
%-------------------------------------------------------------------------
clc
clear

%% Parametry algorytmu SGA
%-------------------------------------------------------------------------
param.K = 8 * 2 ;            % liczba chromosomow K w popoulacji (ze wzgledu na przyjeta strategie powinna byc parzysta)

%param.L = 5;            % dlugosc wektora binarnego L
%param.L = 16;            % dlugosc wektora binarnego L - odwzorowanie liniowe, np. L = 16
param.L = 32;            % dlugosc wektora binarnego L - kodowanie binarne liczby zmiennoprzecinkowej pojedynczej precyzji, L = 32

param.fenotyp_max = 0;   % minmalna wartosc fenotupu, zdeokdowanego wektora binarnego
param.fenotyp_min = 31;  % maksymalna wartosc fenotupu, zdeokdowanego wektora binarnego

param.maxgen = 25;      % maksymalna liczba generacji algorytmu
param.pc = 0.95;        % prawdopodobienstwo krzyzowania
param.pm = 0.1;        % prawdopodobienstwo mutacji

Warunek_stopu = 5;     % definicja ilości generacji bez poprawy najlepszego do zatrzymania algorytmu

liczba_symulacji = 5;  % Definicja ilości prób do obróbki statystcznej 

%% Inicjalizacja populacji poczatkowej
%-------------------------------------------------------------------------
%pop = [chromosom, fenotyp, wartosc funkcji przystosowania]
pop_startowa = inicjalizacja(param);



% Ryunek - aktualna populacja na tle optymalizowanej funkcji
figure
najlepszy_osobnik = zeros(param.maxgen+1,liczba_symulacji);
sredni_osobnik = zeros(param.maxgen+1,liczba_symulacji);
najgorszy_osobnik = zeros(param.maxgen+1,liczba_symulacji);
stat_plot = 0:1:param.maxgen;


%% pętla odpowiadająca za powtarzanie prób przy 
for symulacja = 1:liczba_symulacji

    licznik_warunku_stopu = 0;
    pop = pop_startowa;
    %pierwsze obliczenia przed operacjami genetycznymi (identyczne wyniki)
    najlepszy_osobnik(1,symulacja)=max(pop(:,end));
    sredni_osobnik(1,symulacja)=mean(pop(:,end));
    najgorszy_osobnik(1,symulacja)=min(pop(:,end));
    
    % Realizacja warunku zatrzymania
    for gen = 1:1:param.maxgen

        disp(['Generacja KAG : ',num2str(gen),'/',num2str(param.maxgen)]);
        
        poprzednia_populacja=pop;

        %% Dzialanie operatorow genetycznych na biezacej populacji rodzicielskiej
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

        %% Wybor puli rodzicielskiej dla kolejnej generacji
        pop = selekcja_ruletka(pop, param);
        
        
        pop = Elityzm(pop, param, poprzednia_populacja);
        % Aktualizuj Rysunek
        xx = 0:0.1:31;       
        yy = ffun(xx);

        % Uwaga: przy kodowaniu binarnym liczby zmiennoprzecinkowej pojedynczej precyzji
        %        poszczegolne osobniki moga sie lokowac poza domyslnie obserwowanym
        %        obszarem <0,31> 
        plot(xx,yy,pop(:,end-1),pop(:,end),'ro'); xlim([0 31]);  grid on; 

        % Pauza by na rysunku zaobserwowac progres w rozwiazywaniu zadania
        pause(0.2)
        najlepszy_osobnik(gen+1,symulacja)=max(pop(:,end));
        sredni_osobnik(gen+1,symulacja)=mean(pop(:,end))
        najgorszy_osobnik(gen+1,symulacja)=min(pop(:,end));
        
        %% Algorytm zatrzymania symulacji
        if najlepszy_osobnik(gen+1,symulacja) == najlepszy_osobnik(gen,symulacja)
            licznik_warunku_stopu=licznik_warunku_stopu+1 
        else
            licznik_warunku_stopu=0;
        end
        if Warunek_stopu == licznik_warunku_stopu
            break;
        end
        

    end

    
    
end

%% Wynik
[wynik, ktory] = max(pop(:,end));
plot(xx,yy,pop(ktory,end-1),pop(ktory,end),'ko','MarkerSize',10); xlim([0 31]); grid on;
disp(['MAX: x(fenotyp) = ',num2str(pop(ktory,end-1)),'; f(x) = ',num2str(wynik)]);


%% Tworzenie przebiegów przystosowania populacji

figure('Name','Tworzenie przebiegów przystosowania populacji');
Przebiegi_Przystosowania=tiledlayout(3,1);
plot_1 = nexttile(Przebiegi_Przystosowania);
for i=1:liczba_symulacji
    plot(stat_plot,najlepszy_osobnik(:,i))
    hold on;
end
title(plot_1,'Najlepszy osobnik')
ylabel(plot_1,'funkcja celu')
xlabel(plot_1,'numer generacji')
hold off;

plot_2 = nexttile(Przebiegi_Przystosowania);
for i=1:liczba_symulacji
    plot(stat_plot,sredni_osobnik(:,i))
    hold on;
end
title(plot_2,'Średni osobnik')
ylabel(plot_2,'funkcja celu')
xlabel(plot_2,'numer generacji')
hold off;

plot_3 = nexttile(Przebiegi_Przystosowania);
for i=1:liczba_symulacji
    plot(stat_plot,najgorszy_osobnik(:,i))
    hold on;
end
title(plot_3,'Najgorszy osobnik')
ylabel(plot_3,'funkcja celu')
xlabel(plot_3,'numer generacji')
hold off;
%% Opracowywanie statystyczne                                      
for i=1:param.maxgen+1
    Statystyka_najlepszego(1,i) = mean(najlepszy_osobnik(i,:));
    Statystyka_najlepszego(2,i) = median(najlepszy_osobnik(i,:));
    Statystyka_najlepszego(3,i) = std(najlepszy_osobnik(i,:));
end
for i=1:param.maxgen+1
    Statystyka_sredniego(1,i) = mean(sredni_osobnik(i,:));
    Statystyka_sredniego(2,i) = median(sredni_osobnik(i,:));
    Statystyka_sredniego(3,i) = std(sredni_osobnik(i,:));
end
for i=1:param.maxgen+1
    Statystyka_najgorszego(1,i) = mean(najgorszy_osobnik(i,:));
    Statystyka_najgorszego(2,i) = median(najgorszy_osobnik(i,:));
    Statystyka_najgorszego(3,i) = std(najgorszy_osobnik(i,:));
end

%plotowanie statystyk najgorszych
figure('Name','Plotowanie statystyk osobników w każdej generacji');
tiledlayout(3,1)
plot_najgorszy_1 = nexttile;
plot(0:1:param.maxgen,Statystyka_najlepszego(1,:))
hold on;
plot(0:1:param.maxgen,Statystyka_sredniego(1,:))
hold on;
plot(0:1:param.maxgen,Statystyka_najgorszego(1,:))
hold off;
legend(plot_najgorszy_1,{'Najlepszy','Średni','Najgorszy'})
title(plot_najgorszy_1,'Średnie przystosowanie osobników w każdej generacji')
ylabel(plot_najgorszy_1,'wartość funkcji celu')
xlabel(plot_najgorszy_1,'numer generacji')

plot_najgorszy_2 = nexttile;
plot(0:1:param.maxgen,Statystyka_najlepszego(2,:))
hold on;
plot(0:1:param.maxgen,Statystyka_sredniego(2,:))
hold on;
plot(0:1:param.maxgen,Statystyka_najgorszego(2,:))
hold off;
legend(plot_najgorszy_2,{'Najlepszy','Średni','Najgorszy'})
title(plot_najgorszy_2,'Mediana przystosowania osobników w każdej generacji')
ylabel(plot_najgorszy_2,'wartość funkcji celu')
xlabel(plot_najgorszy_2,'numer generacji')

plot_najgorszy_3 = nexttile;
plot(0:1:param.maxgen,Statystyka_najlepszego(3,:))
hold on;
plot(0:1:param.maxgen,Statystyka_sredniego(3,:))
hold on;
plot(0:1:param.maxgen,Statystyka_najgorszego(3,:))
hold off;
legend(plot_najgorszy_3,{'Najlepszy','Średni','Najgorszy'})
title(plot_najgorszy_3,'Odchylenie standardowe przystosowania osobników w każdej generacji')
ylabel(plot_najgorszy_3,'wartość funkcji celu')
xlabel(plot_najgorszy_3,'numer generacji')
