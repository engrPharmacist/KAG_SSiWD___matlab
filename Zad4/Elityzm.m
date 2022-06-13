function [pop] = Elityzm(pop, param, poprzednia_populacja)

chromlength = param.L;
[funkcja_najlepszego_obecnie_osobnika]=min(pop(:,chromlength+3));
[funkcja_najlepszego_poprzedniego_osobnika,index_najlepszego_poprzedniego_osobnika]=min(poprzednia_populacja(:,chromlength+3));

if funkcja_najlepszego_poprzedniego_osobnika<funkcja_najlepszego_obecnie_osobnika
    [funkcja_najgorszego_obecnie_osobnika,index_najgorszego_obecnie_osobnika]=max(pop(:,chromlength+3));
    pop(index_najgorszego_obecnie_osobnika,:)=poprzednia_populacja(index_najlepszego_poprzedniego_osobnika,:);
    
%     fprintf('Zamieniono osobnika %d o przystosowaniu %.2d na osobnika %d z poprzedniej populacji o przystosowaniu %d \n',...
%     index_najgorszego_obecnie_osobnika, funkcja_najgorszego_obecnie_osobnika,...
%     index_najlepszego_poprzedniego_osobnika, funkcja_najlepszego_poprzedniego_osobnika);

    disp(['Zamieniono osobnika o numerze ',num2str(index_najgorszego_obecnie_osobnika),' i przystosowaniu ',...
    num2str(funkcja_najgorszego_obecnie_osobnika),' na osobnika numer ',num2str( index_najlepszego_poprzedniego_osobnika),...
    ' z poprzedniej populacji o przystosowaniu ',num2str(funkcja_najlepszego_poprzedniego_osobnika)]);

end