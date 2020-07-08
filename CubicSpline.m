clc;
clear all;

%retrieve data
fid = fopen('CubicSpline5.txt');
if(fid < 0)
        error("could not open file");
end
data = fscanf(fid, '%f');
fclose(fid);

% n number fo points
 n = data(1);
 N = n - 1;
 %fprintf('%f\n', n);
 %empty array for x and y portion points
 xi = [];
 yi = [];
 %fill each array with respective 
 for i= 2:length(data)
    if mod(i,2) == 0
        xi = [xi;data(i)];
    else
        yi = [yi; data(i)];
    end
end
 %fprintf('%f\n', xi);
 %fprintf('%f\n', yi);
 

 k = N - 1;
 %h array for the subtraction(width of interval)
 h = [];
 for i = 0:k
   h(i+1) = xi(i+2) - xi(i+1);
 end
 %r array for the cubic function
 r = [];
 for i = 1:k
   r(i+1) = 3.0*(yi(i+2)*h(i)-yi(i+1)*(-xi(i)+ xi(i+2))+yi(i)*h(i+1))/(h(i+1)*h(i));
 end

 x1 = [];
 x2 = [];
 x3 = [];
 %intialize the dummy poly
 x1(1) = 1;
 x2(1) = 0;
 x3(1) = 0;
%this will help get b,c,d values
 for i = 1:k
   x1(i+1) = (-xi(i) + xi(i+2))*2 - h(i)*x2(i);
   x2(i+1) = h(i+1)/x1(i+1);
   x3(i+1) = h(i)*((r(i+1))-x3(i))/x1(i+1);
 end

 x1(n+1) = 1;
 x3(n+1) = 0;
 b = [];
 c = [];
 d = [];
 c(n+1) = x3(n+1);
% solve for b,c,d
 for i = 0:k
   j = k-i;
   c(j+1) = x3(j+1)-c(j+2)*x2(j+1);
   b(j+1) = (yi(j+2)-yi(j+1))/h(j+1) - h(j+1) * (c(j+2) + 2.0 * c(j+1)) / 3.0;
   d(j+1) = (c(j+2) - c(j+1)) / (h(j+1)*3.0);
 end
 
 %loop to print values
 for i = 0:k
   fprintf('%f   %f   %f   %f \n',yi(i+1),b(i+1),c(i+1),d(i+1));
 end
 
 %loops to plot the graph
 p=xi;
for m=1:n-1
   func= @(xi)yi(m)+(b(m)*(xi-p(m)))+(c(m)*(-p(m) + xi).^2.0)+(d(m)*(-p(m)+ xi).^3.0);
   fplot(func,[p(m),p(m+1)])
   hold on;
end
plot(xi,yi,'ro');
