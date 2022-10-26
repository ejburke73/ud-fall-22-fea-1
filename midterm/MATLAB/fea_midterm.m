% FEA Midterm
% Evan Burke

%% Problem 1
clear; close; clc;
syms x d1 d2 E A

N1 = -x*(1-x)/2;
N2 = x*(1+x)/2;
N = [N1 N2];
B = diff(N,x);

d = [d1;d2];
eps = B*d;
pretty(expand(B.'*B))
btb = expand(B.'*B)

K = int(btb)
pretty(expand(K))

% You get a different answer depending on if you expand first or not

%% Problem 2
clear; close; clc;
x1 = 2; d1 = 0.15;
x2 = 4; d2 = 0.05;
x3 = 6; d3 = -0.10;

A = [1 x1 x1^2; 1 x2 x2^2; 1 x3 x3^2];

syms x
N = [1 x x^2]/(A);
u = N*[d1;d2;d3];
zero = vpasolve(u,x);
xs = 2:0.05:6;
ds = subs(u,xs);
plot(xs,ds,zero(2),0,'*')
xlabel('X-Location [in.]')
ylabel('Displacement [in.]')
title('Second Order 1D Element: Displacement vs. X-Location')
grid on 
fprintf('Zero deflection at x = %f',zero(2))

%% Problem 3
clear; close; clc;

syms x y yp ypp H E I W C D

f = E*I/2*yp^2 + (W*x*(H-x)/2)*y
dfdy = diff(f,y)
dfdyp = diff(f,yp)
ddxdfdyp = diff(dfdyp,x) + diff(dfdyp,y)*yp + diff(dfdyp,yp)*ypp

euler = dfdy - ddxdfdyp == 0
RHS = solve(euler,ypp)
yp = int(RHS)
yp = yp + C
y = int(yp) 

coeff = solve(y,C)
coeff = subs(coeff,x=H)
y = y- C*x + coeff*x
simplify(y)
%C = -(H^3*W)/(24*E*I)
%subs(y,C)