%x0 is intial val
%d is degree
%Coeff are the coeff of the poly
%eb Error Bound
%N max # of iteration
clc;
clear all;
fid = fopen('newtonHorner1.txt');
if(fid < 0)
        error("could not open file");
end
data = fscanf(fid, '%f');
fclose(fid);
d = data(1);
Coeff = data(2:end-3);
x0 = data(end-2);
eb = data(end-1);
N = data(end);
%fprintf('%f\n',eb);
%fprintf('%f\n',N);
    Coeff=Coeff(d+1:-1:1);
    %C will be the derevative
    C=polyder(Coeff);
    %Horners(synteic division) with each Netwon
    for i=1:N
        t=1;
        s=0;
        for j=1:length(Coeff)
            s=s*x0+Coeff(j);
        end
        t=t*s;
        s=0;
        for k=1:length(C)
            s=s*x0+C(k);
        end
        %Newtons
        t=t/s; 
        x1=x0-t;
        %Check error bound
        if(abs(x1-x0)<eb)
            break;
        end
        x0=x1;
    end
    %detects if anything is in the array
    if(i<N)
        fprintf('%f\n',x1);
        %elseif not found
    else
        fprintf('solution was not found\n');
    end