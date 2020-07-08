clc;
clear all;

%retrieve data
fid = fopen('Simpson5.txt');
if(fid < 0)
        error("could not open file");
end
func = fscanf(fid, '%s' ,[1 1]);
data = fscanf(fid, '%f', [2 Inf]);
fclose(fid);
%fprintf('%s\n', func);
%fprintf('%f\n', data(1));
%fprintf('%f\n', data(2));
%fprintf('%f\n', data(3));
%set the lower upper bound and # of interval
a = data(1);
b = data(2);
n = data(3);

%make the string into function
f = inline(func,'x') ;

%find h
 h=(b-a)/n;
 x0=f(a)+f(b);
 x1=0;
 x2=0;
 
 %loop to find function values
 for i=1:(n-1)
   x=i*h + a;
   %check divisible by 2
   if mod(i,2)==0  
      x2=f(x)+x2;
   else
      x1=f(x)+x1;      
   end
 end
 
 %Composite Simpson
 r=(h/3)*(x0 + 2*x2 + 4*x1);
 fprintf('%f\n',r);