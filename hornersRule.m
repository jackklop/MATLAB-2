%x0 is intial value
%d is degree
%Coeff are the coeff of the poly
clc;
clear all;
fid = fopen('hornersRule1.txt');
if(fid < 0)
        error("could not open file");
end
data = fscanf(fid, '%f');
fclose(fid);
d = data(1);
Coeff = data(2:end-1);
x0 = data(end);
%fprintf('%f\n',Coeff(1));
%fprintf('%f\n',Coeff(2));
%fprintf('%f\n',Coeff(3));
%fprintf('%f\n',Coeff(4));
    Coeff=Coeff(end:-1:1);
    %loop the to the max degree times
    for i=0:d
        s=0;
        %nested loops for each indivisual coeff
        for j=1:length(Coeff)
            s=s*x0+Coeff(j);
        end
        %print each level
        fprintf('P%d(%f)=%f\n',i,x0,s);
        %this returns the derivative of the polynomial each time
        Coeff=polyder(Coeff);
    end
