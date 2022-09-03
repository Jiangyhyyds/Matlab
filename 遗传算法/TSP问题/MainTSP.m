% 遗传算法解决TSP问题主函数
clear, clc;
Num = 10;       % 城市的个数
popSize = 20;   % 种群个数
Time = 10;      % 迭代次数
C_old = Time;
m = 2;          % 适应值归一化淘汰加速指数
pc = 0.4;       % 交叉概率
pm = 0.2;       % 变异概率
pos = randn(Num, 2);    % 生成城市坐标
%% 计算两个城市间的距离矩阵
Dist = zeros(Num, Num);
for i = 1 : Num
    for j = i + 1 : Num
        dist = (pos(i, 1) - pos(j, 1)).^2 + (pos(i, 2) - pos(j, 2)).^2;
        Dist(i, j) = sqrt(dist);
        Dist(j, i) = Dist(i, j);
    end
end
%% 生成初始群体
pop = zeros(popSize, Num);
for i = 1 : popSize
    pop(i, :) = randperm(Num);
    % 生成1~N的随机排列
end
%% 随机选择一个种群
R = pop(1, :);
figure(1);
scatter(pos(:, 1), pos(:, 2), "k.");
xlabel("横轴");
ylabel("纵轴");
title("随机产生的种群图");
axis([-3, 3, -3, 3]);
set(gca, "FontSize", 22);
figure(2);
plot_route(pos, R);
xlabel("横轴");
ylabel("纵轴");
title("随机生成的种群中城市路径情况");
axis([-3, 3, -3, 3]);
set(gca, "FontSize", 22);
%% 初始化种群及其适应函数
fitness = zeros(popSize, 1);
len = zeros(popSize, 1);
for i = 1 : popSize
    len(i) = calRoad(Dist, pop(i, :));
end
maxLen = max(len);
minLen = min(len);
fitness = calFit(len, m, maxLen, minLen);
minIndex = find(len == minLen);     % 寻找最优值对应的种群个体
R = pop(minIndex(1), :);            % 最优值对应的种群个体
fitness = fitness / sum(fitness);
distance_min = zeros(Time + 1, 1);  % 各次迭代的最小的种群的距离
while Time > 0
    nn = 0;
    for i = 1 : size(pop, 1)
        len_1(i) = calRoad(Dist, pop(i, :));
        jc = rand * 0.3;
        for j = 1 : popSize
            if fitness(j, 1) >= jc
                nn = nn + 1;
                pop_sel(nn, :) = pop(j, :);
                break;
            end
        end
    end
    % 每次选择都保存最优的种群
    pop_sel = pop_sel(1 : nn, :);
    [len_m, len_index] = min(len_1);
    pop_sel = [pop_sel; pop(len_index, :)];
    % 交叉操作
    nnper = randperm(nn);
    A = pop_sel(nnper(1), :);
    B = pop_sel(nnper(2), :);
    for i = 1 : nn * pc
        [A, B] = crossOver(A, B);
        pop_sel(nnper(1), :) = A;
        pop_sel(nnper(2), :) = B;
    end
    % 变异操作
    for i = 1 : nn
        pick = rand;
        while pick == 0
            pick = rand;
        end
        if pick <= pm
            pop_sel(i, :) = Mutation(pop_sel(i, :));
        end
    end
    % 求适应度函数
    NN = size(pop_sel, 1);
    len = zeros(NN, 1);
    for i = 1 : NN
        len(i) = calRoad(Dist, pop_sel(i, :));
    end
    maxLen = max(len);
    minLen = min(len);
    distance_min(Time + 1, 1) = minLen;
    fitness = calFit(len, m, maxLen, minLen);
    minIndex = find(len == minLen);     % 寻找最优值对应的种群个体
    R = pop_sel(minIndex(1), :);            % 最优值对应的种群个体
    pop = [];
    pop = pop_sel;
    Time = Time - 1;
end
%% 绘制最优曲线
figure(3);
plot_route(pos, R);
xlabel("横轴");
ylabel("纵轴");
title("优化后的种群中城市路径情况");
axis([-3, 3, -3, 3]);
set(gca, "FontSize", 22);