function [u, x, t] = ECD_Wave(A, xf, T, it0, ilt0, bx0, bxf, M, N)
% 显示中心差分法求解双曲线型偏微分方程
% A * u_xx = u_tt   0 <= x <= xf, 0 <= t <= T
% A         为双曲线型偏微分方程系数
% xf        x取值下限
% T         t取值下限
% it0       为在边界t=0上的函数值
% ilt0      为在边界t=0上的函数导数值
% bx0       为在边界x=0上的函数值
% bxf       为在边界x=xf上的函数值
% M         为沿x轴的等分段数
% N         为沿t轴的等分段数
% [u,x,t]   为方程u(x, t)在(x, t)点的函数值
%% 构造内点数组
dx = xf/M; x = [0 : M]' * dx;
dt = T/N; t = [0 : N] * dt;
%% 初始边界条件
for i = 1 : M + 1
    u(i, 1) = it0(x(i));
end
for k = 1 : N + 1
    u([1, M + 1], k) = [bx0(t(k)); bxf(t(k))];
end
r = A * (dt/dx)^2; r1 = r / 2; r2 = 2 * (1 - r);
u(2 : M, 2) = r1*u(1 : M - 1, 1) + (1 - r)*u(2 : M, 1) + r1*u(3 : M + 1, 1) + dt*ilt0(x(2 : M));
%% 开始迭代求值
for k = 3 : N + 1
    u(2 : M, k) = r*u(1 : M - 1, k - 1) + r2*u(2 : M, k - 1) + r*u(3 : M + 1, k - 1) - u(2 : M, k - 2);
end
end