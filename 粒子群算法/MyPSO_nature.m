function [xm, fv] = MyPSO_nature(fitness, N, c1, c2, w, M, D)
% MATLAB实现基于自然选择的粒子群算法
% fitness   适应度函数
% c1    学习因子1
% c2    学习因子2
% w     惯性权重
% M     最大迭代次数
% D     搜索空间维数（未知数个数）
% N     初始化种群个体数目
%% 初始化种群个体(可以在这里限制位置和速度的范围)
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
%% 进入主要循环，按照公式依次迭代，直到满足精度要求
Pbest = zeros(M, 1);    % 每次迭代过程中的全局最优值
fx = zeros(N, 1);       % 每个粒子在每次迭代过程中的适应度
for t = 1 : M
    % 迭代 t 次
    for i = 1 : N
        v(i, :) = w * v(i, :) + c1 * rand * (y(i, :) - x(i, :)) + c2 * rand * (pg - x(i, :));
        x(i, :) = x(i, :) + v(i, :);
        fx(i) = fitness(x(i, :));
        if fx(i) < p(i)
            p(i) = fx(i);
            y(i, :) = x(i, :);
        end
        if fx(i) < fitness(pg)
            pg = y(i, :);
        end
    end
    Pbest(t) = fitness(pg);
    [sort_value, sort_index] = sort(fx);    % 根据适应度进行排序
    % sort_index表示排序后的元素在原来向量中的索引排序
    endIndex = round((N - 1) / 2);
    x(sort_index(N - endIndex + 1 : N)) = x(sort_index(1 : endIndex));      % 替换位置
    v(sort_index(N - endIndex + 1 : N)) = v(sort_index(1 : endIndex));      % 替换速度
%     % 绘图每次的迭代适应曲线
%     plot(1 : t, Pbest(1 : t));
%     xlabel("迭代次数/次");
%     ylabel("每次迭代后的目标函数值");
%     set(gca, "FontSize", 22);
%     pause(0.1);
end
%% 打印计算结果
disp("目标函数取最小值时的自变量");
xm = pg'
disp("目标函数最小值");
fv = fitness(pg)
end