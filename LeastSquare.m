clc;
clear all;

%retrieve data
fid = fopen('LeastSquare5.txt');
if(fid < 0)
        error("could not open file");
end
data = fscanf(fid, '%f');
fclose(fid);

%intialize arrays and set inputs
x = [];
y = [];
n = data(2);
N = data(1);
%loop to fill x and y arrays
for k= 3:length(data)
    if mod(k,2) == 0
        y = [y;data(k)];
    else
        x = [x; data(k)];
    end
end
%fprintf('%d\n', x);
%fprintf('%d\n',y);


% matrix construct
x = x(:);
Vector = ones(length(x), n + 1.0);
for j = n:-1:1
   Vector(:, j) = Vector(:, j + 1.0) .* x;
end

% Use least square
[W, R] = qr(Vector, 0);
py = (R \ ((W)' * y(:)))';
fprintf("The coefficients are:\n");
fprintf('%.4f  ', flip(py));

% reverse looping through the length of py
% plotting the poly, combining the py to form a poly to graph
f=0;
indx = 1;
s = size(py);
for k=s(2):-1:1
f = py(indx).*x.^(-1 + k) + f;
indx = indx + 1;
plot(x,y,'o',x,f);
end

