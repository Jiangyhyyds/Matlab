function [u, x, t] = EF_Euler(A, xf, T, it0, bx0, bxf, M, N)
% 显式前向欧拉法求解一维抛物线方程：A * u_xx = u_t，0 <= x <= xf，0 <= t <= T
% A         抛物线偏微分方程系数
% xf        x取值下限(0~xf)
% T         t取值下限(0~T)
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
r = A * dt / dx / dx; r1 = 1 - 2 * r;
if (r > 0.5)
    disp("r > 0.5, unstability");
end
for k = 1 : N
    for i = 2 : M
        u(i, k + 1) = r * (u(i + 1, k) + u(i - 1, k)) + r1 * u(i, k);
    end
end
end