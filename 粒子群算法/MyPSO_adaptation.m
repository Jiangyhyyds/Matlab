function [xm, fv] = MyPSO_adaptation(fitness, N, c1, c2, wmax, wmin, M, D)
% MATLAB实现自适应权重的粒子群算法(权重根据全局最优点的距离进行调整)
% c1    学习因子1
% c2    学习因子2
% wmax  惯性权重最大值
% wmin  惯性权重最小值
% M     最大迭代次数
% D     搜索空间维数
% N     初始化种群个体数目
%% 初始化种群个体
format long;
x = zeros(N, D);
v = zeros(N, D);
for i = 1 : N
    x(i, :) = randn(1, D);    % 初始化位置
    v(i, :) = randn(1, D);    % 初始化速度
end
%% 计算每个粒子的适应度，并初始化Pi和Pg
% Pi 每个粒子的局部最优值
% Pg 整个种群的全局最优值
p = zeros(1, N);
y = zeros(N, D);
for i = 1 : N
    p(i) = fitness(x(i, :));    % 计算每个个体的Pi
    y(i, :) = x(i, :);
end
pg = x(N, :);       % pg为全局最优
% 初始化全局最优
for i = 1 : N - 1
    if fitness(x(i, :)) < fitness(pg)
        pg = x(i, :);
    end
end
%% 进入主要循环，按照公式依次迭代，并计算自适应权重，直到满足精度要求
Pbest = zeros(M, 1);    % 每次迭代过程中的全局最优值
fv = zeros(N, 1);       % 计算每次迭代过程中的每个个体的适应度
for t = 1 : M
    % 迭代 t 次
    for j = 1 : N
        fv(j) = fitness(x(j, :));
    end
    fvag = sum(fv) / N;     % 适应度平均值
    fmin = min(fv);         % 适应度最小值
    for i = 1 : N
        if fv(i) < fvag
            w = wmin + (fv(i) - fmin) * (wmax - wmin) ./ (fvag - fmin);
        else
            w = wmax;
        end
        v(i, :) = w * v(i, :) + c1 * rand * (y(i, :) - x(i, :)) + c2 * rand * (pg - x(i, :));
        x(i, :) = x(i, :) + v(i, :);
        if fitness(x(i, :)) < p(i)
            p(i) = fitness(x(i, :));
            y(i, :) = x(i, :);
        end
        if fitness(x(i, :)) < fitness(pg)
            pg = y(i, :);
        end
    end
    Pbest(t) = fitness(pg);
end
%% 打印计算结果
disp("目标函数取最小值时的自变量");
xm = pg'
disp("目标函数最小值");
fv = fitness(pg)
end