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

%% Problem 5
clear; close; clc;

E = 200*1000; % MPa
P = 5000; % N
Tx = 250; % N/mm
A1 = 50; A2 = 50; % mm^2
A3 = 150; A4 = 150; % mm^2
L1 = 100; L2 = 100; % mm
L3 = 100; L4 = 100; % mm

x1 = 0; x2 = x1 + L1; x3 = x2 + L2; x4 = x3 + L3; x5 = x4 + L4;

k1 = A1*E/L1;
k2 = A2*E/L2;
k3 = A3*E/L3;
k4 = A4*E/L4;

K1 = [k1 -k1; -k1 k1];
K2 = [k2 -k2; -k2 k2];
K3 = [k3 -k3; -k3 k3];
K4 = [k4 -k4; -k4 k4];

Ks = {K1, K2, K3, K4};

K = zeros(5,5);

for i=1:4
    K(i:i+1,i:i+1) = K(i:i+1,i:i+1) + Ks{i};
end

syms d2 d3 d4 F1 F5

F2 = Tx*L1 + P;
F3 = Tx*(L1+L2) + P;
F4 = P;

d1 = 0; d5 = 0;

d = [d1; d2; d3; d4; d5];
R = [F1; F2; F3; F4; F5];

Kd = K*d;

eq1 = Kd(1,:) == R(1);
eq2 = Kd(2,:) == R(2);
eq3 = Kd(3,:) == R(3);
eq4 = Kd(4,:) == R(4);
eq5 = Kd(5,:) == R(5);

eq = K*d == R;

sol = solve(eq);

F1 = double(sol.F1);
F5 = double(sol.F5);
d2 = double(sol.d2);
d3 = double(sol.d3);
d4 = double(sol.d4);

subs(R)
d = double(subs(d));

A = [1 x1 x1^2 x1^3 x1^4;
     1 x2 x2^2 x2^3 x2^4;
     1 x3 x3^2 x3^3 x3^4;
     1 x4 x4^2 x4^3 x5^4;
     1 x5 x5^2 x5^3 x5^4];

syms x

N = [1 x x^2 x^3 x^4]/(A);
u = N*d;

xs = 0:1:x5;
ds = subs(u,xs);
plot(xs,ds,x1,subs(u,x1),'r*',x2,subs(u,x2),'r*',x3,subs(u,x3),'r*',x4,subs(u,x4),'r*',x5,subs(u,x5),'r*')
xlabel('x-Location [mm]')
ylabel('Displacement [mm]')
title('Bar Element: Displacement vs. x-Location')
grid on 
