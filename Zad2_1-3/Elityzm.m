function [Generacja_z_elita] = Elityzm(pop, param, funkcja_celu, )

chromlength = param.L
popsize = param.K
przystosowanie= zeros(param.maxgen, popsize);
 
j=1;

    for chrom = 1:1:popsize
        disp(['iteracja ', num2str(chrom)])
        przystosowanie(j, chrom) = pop(chrom, chromlength+2);


    
    end
disp(przystosowanie)   
j=j+1;   
chrom = 1;
Generacja_z_elita=1;
end