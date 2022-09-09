clear, clc;
f = inline("x^2 + y^2", 'x', 'y');
g = inline("sqrt(x)", 'x', 'y');
x0 = 0; xf = 4; y0 = 0; yf = 4;     % 自变量取值范围
Mx = 30; My = 30;                   % 等分段数
bx0 = inline("y^2", 'y');           % 边界条件
bxf = inline("16*cos(y)", 'y');
by0 = inline("x^2", 'x');
byf = inline("16*cos(x)", 'x');
D = [x0, xf, y0, yf];
MaxIter = 400;
MinErr = 1e-4;
[U, x, y] = Helmholtz(f, g, bx0, bxf, by0, byf, D, Mx, My, MinErr, MaxIter);
clf, surf(x, y, U);
xlabel('x');
ylabel('y');
zlabel('U');