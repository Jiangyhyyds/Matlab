clear, clc;
it0 = inline("cos(pi*x)*sin(pi*y)", "x", "y");
ilt0 = inline("0", "x", "y"); bxyt = inline("0", "x", "y", "t");
A = 0.5; D = [0, 2, 0, 2]; T = 2; Mx = 40; My = 40; N = 40;
[u, x, y, t] = Wave2(A, D, T, it0, ilt0, bxyt, Mx, My, N);
surf(x, y, u);
xlabel("x");
ylabel("y");
zlabel("U");