% FEA Homework 1
% Evan Burke
% 31 August 2022
% Problem 1a
clear; close; clc;
syms a b p1 p2 p3 x y
A = [1 0 0; 1 a 0; 1 0 b];
p = [p1;p2;p3];
inv(A)
as = inv(A)*p;
simplify(A*as);
p_xy = as(1) + as(2)*x + as(3)*y;
p_f = collect(p_xy,[p1,p2,p3]);
x = 0; y = 0;
simplify(subs(p_f));
x = a; y = 0;
simplify(subs(p_f));
x = 0; y = b;
simplify(subs(p_f));
%%
% FEA Homework 1
% Evan Burke
% 31 August 2022
% Problem 1b
clear; close; clc;
syms a b p1 p2 p3 x y
% Problem 1b
A = [1 0 0 ; 1 2*a 0; 1 a b];
p = [p1;p2;p3];
inv(A);
as = inv(A)*p;
simplify(A*as);
p_xy = as(1) + as(2)*x + as(3)*y;
p_f = collect(p_xy,[p1,p2,p3]);
x = 0; y = 0;
simplify(subs(p_f));
x = 2*a; y = 0;
simplify(subs(p_f));
x = a; y = b;
simplify(subs(p_f));
%%
% FEA Homework 1
% Evan Burke
% 31 August 2022
% Problem 2
clear; close; clc;
syms a b p1 p2 p3 p4 L1 L2 L3 x y
A = [1 0 0 0; 1 L1 0 0 ; 1 L1 L2 L1*L2; 1 (L1-L3) L2 (L1-L3)*L2];
p = [p1; p2; p3; p4];
inv(A);
as = inv(A)*p;
simplify(A*as);
p = as(1) + as(2)*x + as(3)*y + as(4)*x*y;