function [xm, fv] = MyPSO_breed(fitness, N, c1, c2, w, bc, bs, M, D)
% MATLAB实现基于遗传算法的杂交概念的粒子群算法
% fitness   适应度函数
% c1    学习因子1
% c2    学习因子2
% w     惯性权重
% bc    杂交概率
% bs    杂交池的大小比例
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
%% 进入主要循环，按照公式依次迭代，直到满足精度要求
Pbest = zeros(M, 1);    % 每次迭代过程中的全局最优值
for t = 1 : M
    % 迭代 t 次
    for i = 1 : N
        v(i, :) = w * v(i, :) + c1 * rand * (y(i, :) - x(i, :)) + c2 * rand * (pg - x(i, :));
        x(i, :) = x(i, :) + v(i, :);
        if fitness(x(i, :)) < p(i)
            p(i) = fitness(x(i, :));
            y(i, :) = x(i, :);
        end
        if fitness(x(i, :)) < fitness(pg)
            pg = y(i, :);
        end
        r1 = rand();    % 产生0~1间均匀分布的随机数
        if r1 < bc
            numPool = round(bs * N);
            Pool_x = x(1 : numPool, :);
            Pool_v = v(1 : numPool, :);
            % 选取前numPool个粒子的位置和速度进行杂交
            child_x = zeros(numPool, D);
            child_v = zeros(numPool, D);
            for j = 1 : numPool
                seed1 = floor(rand() * (numPool - 1)) + 1;
                seed2 = floor(rand() * (numPool - 1)) + 1;
                pb = rand();    % pb对应子代位置公式中的随机数i
                child_x(j, :) = pb * Pool_x(seed1, :) + (1 - pb) * Pool_x(seed2, :);
                % 杂交过程中子代位置的更新公式
                child_v(j, :) = (Pool_v(seed1, :)+Pool_v(seed2, :))*norm(Pool_v(seed1, :))./norm(Pool_v(seed1, :)+Pool_v(seed2, :));
                % 杂交过程中子代速度的更新公式
            end
            x(1 : numPool, :) = child_x(:, :);
            v(1 : numPool, :) = child_v(:, :);
            % 将父代粒子的位置和速度替换为子代粒子的
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