function [u, x, t] = IB_Euler(A, xf, T, it0, bx0, bxf, M, N)
% 显式前向欧拉法求解一维抛物线方程：A * u_xx = u_t，0 <= x <= xf，0 <= t <= T
% A         抛物线偏微分方程系数
% xf        x取值下限
% T         t取值下限
% it0       边界t=0上的函数值
% bx0       边界x=0上的函数值
% bxf       边界x=xf上的函数值
% M         沿X轴的等分段数
% N         沿t轴的等分段数
% [u, x, t] 方程u(x, t)在(x, t)点的函数值

dx = xf / M; x = [0 : M]' * dx;
dt = T / N;  t = [0 : N] * dt;
for i = 1 : M + 1
    u(i, 1) = it0(x(i));
end
for n = 1 : N + 1
    u([1, M + 1], n) = [bx0(t(n)); bxf(t(n))];
end
r = A * dt / dx / dx; r2 = 1 + 2 * r;
for i = 1 : M - 1
    P(i, i) = r2;
    if i > 1
        P(i - 1, i) = -r;
        P(i, i - 1) = -r;   
    end
end
for k = 2 : N + 1
    b = [r*u(1, k); zeros(M - 3, 1); r*u(M + 1, k)];
    u(2 : M, k) = linsolve(P, b);
end
end