clc;
clear all;
fid = fopen('Neville1.txt');
if(fid < 0)
        error("could not open file");
end
data = fscanf(fid, '%f');
fclose(fid);

%n = order of interpolation
%xi = x values
%yi = y values
%x0 = eval point
xi = [];
yi = [];
n = data(1);
x0 = data(end);
%transer txt file to array
for i= 2:length(data)-1
    if mod(i,2) == 0
        xi = [xi;data(i)];
    else
        yi = [yi; data(i)];
    end
end
%fprintf('%d\n', xi);
%fprintf('%d\n',yi);

%Neville function
    %create matric first
    m = zeros(n+1,n+1);
    %loop 1 to n+1
    for i = 1:n+1
        m(i,i) = yi(i);
    end
    %nested loops to use Neville Algo
    for j = 1:n+1
        for i = 1:n+1-j
            % using Neville's Algorithm/FOrumla
            m(i,i+j) = ((xi(i+j)-x0)*m(i,i+j-1) + (x0-xi(i))*m(i+1,i+j))/(xi(i+j)-xi(i));
        end
    end
%print out the answer
    m = m(1,n+1);
    fprintf('Pn(x0) = %f', m);

