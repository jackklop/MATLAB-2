%scan text file
clc;
clear all;
fid = fopen('Cramers1.txt');
if(fid < 0)
        error("could not open file");
end
data = fscanf(fid, '%f');
fclose(fid);
%n = dimensions
%Coeff = values in matrix
%Constant = the values on right of equal sign
n = data(1);
Coeff = zeros([n n]); %create empty matrics
Constant = zeros([n 1]);
counter = 1;
%fill matrix first
for i=1:n
    for j=1:n
        counter = counter + 1;
        Coeff(i,j) = data(counter);
        %fprintf('%f\n',Coeff(i,j));
    end
end
k = 0;
%fill constant matrix
for m = 1:n
    Constant(m,1)= data(length(data)-n + m);
    %fprintf('%f\n',data(length(data)-n + m));
    k = k+1;
end

%Cramers
%det of matrix
detA = det(Coeff);
fprintf('Determinant A = %f\n', detA);
 x = ones(n,1);
 %each indivisual det
for w = 1:n
    y = Coeff;
    y(:,w) = Constant;
    x(w,1) = det(y)/detA;
    fprintf('Determinant A%d = %f\n', w,det(y));
end
%answer
fprintf('xi = %f\n',x);

  
