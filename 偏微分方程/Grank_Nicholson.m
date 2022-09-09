function [u, x, t] = Grank_Nicholson(A, xf, T, it0, bx0, bxf, M, N)
% Grank_Nicholson法求解一维抛物线方程 A * u_xx = u_t, 0 <= x <= xf, 0 <= t <= T
% A         抛物线偏微分方程系数
% xf        x取值下限
% T         t取值下限
% it0       为边界t=0上的函数值
% bx0       为边界x=x0上的函数值
% bxf       为边界x=xf上的函数值
% M         为沿x轴的等分段数
% N         为沿t轴的等分段数
% [u,x,t]   方程u(x, t)在(x, t)点的函数值
%% 构造内点数组
dx = xf/M; x = [0 : M]' * dx;
dt = T/N; t = [0 : N] * dt;
%% 边界条件
for i = 1 : M + 1
    u(i, 1) = it0(x(i));
end
for n = 1 : N + 1
    u([1, M + 1], n) = [bx0(t(n)); bxf(t(n))];
end
r = A * dt / dx / dx;
r1 = 2 * (1 - r); r2 = 2 * (1 + r);
%% 开始迭代求值
for i = 1 : M - 1
    P(i, i) = r1;
    Q(i, i) = r2;
    if i > 1
        P(i - 1, i) = -r; P(i, i - 1) = -r;
        Q(i - 1, i) = r; Q(i, i - 1) = r;
    end
end
for k = 2 : N + 1
    b = Q*u(2 : M, k - 1) + [r*(u(1, k) + u(1, k - 1)); zeros(M - 2, 1)];
    u(2 : M, k) = linsolve(P, b);
end
end