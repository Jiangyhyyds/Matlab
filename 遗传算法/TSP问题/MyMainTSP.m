% 遗传算法解决TSP问题主函数
clear, clc;
Num = 6;        % 城市的个数
popSize = 20;   % 种群个数
Time = 10;      % 迭代次数
C_old = Time;
m = 2;          % 适应值归一化淘汰加速指数
pc = 0.4;       % 交叉概率
pm = 0.2;       % 变异概率
load TSPMatrix.mat;     % 两个城市间的距离矩阵
%% 生成初始群体
pop = zeros(popSize, Num);
for i = 1 : popSize
    pop(i, :) = randperm(Num);  % 实数整数编码
    % 生成1~N的随机排列
end
%% 初始化种群及其适应函数
fitness = zeros(popSize, 1);    % 种群适应度函数
len = zeros(popSize, 1);
for i = 1 : popSize
    len(i) = calRoad(Dist, pop(i, :));      % 计算每个种群个体的目标函数，即路径长度
end
maxLen = max(len);      % 寻找种群中的最长路径
minLen = min(len);      % 寻找种群中的最短路径
fitness = calFit(len, m, maxLen, minLen);   % 计算种群个体的适应度
minIndex = find(len == minLen);     % 寻找最优值对应的种群个体
R = pop(minIndex(1), :);            % 最优值对应的种群个体
fitness = fitness / sum(fitness);
distance_min = zeros(Time + 1, 1);  % 各次迭代的最小的种群的距离
while Time > 0
    bestIndex = 0;      % 筛选出的较优的种群个体数
    pop_sel = [];
    for i = 1 : size(pop, 1)
        len_1(i) = calRoad(Dist, pop(i, :));
        jc = rand * 0.3;    % 生成随机数，若适应度大于生成的随机数则选择出种群个体
        for j = 1 : popSize     % 每次循环至多筛选出一个种群个体，共筛选size(pop, 1)次
            if fitness(j, 1) >= jc
                bestIndex = bestIndex + 1;
                pop_sel(bestIndex, :) = pop(j, :);
                break;
            end
        end
    end
    % 每次选择都保存最优的种群
    pop_sel = pop_sel(1 : bestIndex, :);
    [len_m, len_index] = min(len_1);        % 每次择优都选上最优的个体
    pop_sel = [pop_sel; pop(len_index, :)];
    % 在以下操作的过程中，pop_sel种群个体实际上是bestIndex + 1个，但考虑到选择的可能有相同的个体，故后面不予考虑
    % 交叉操作
    nnper = randperm(bestIndex);    % 随机生成1~N的一个随机排列，并取排列的前两个数，执行相应操作
    A = pop_sel(nnper(1), :);
    B = pop_sel(nnper(2), :);
    for i = 1 : bestIndex * pc
        [A, B] = crossOver(A, B);
        pop_sel(nnper(1), :) = A;
        pop_sel(nnper(2), :) = B;
    end
    % 变异操作
    for i = 1 : bestIndex
        pick = rand;
        while pick == 0     % 保证pick不为0
            pick = rand;
        end
        if pick <= pm
            pop_sel(i, :) = Mutation(pop_sel(i, :));
        end
    end
    % 求适应度函数
    NN = size(pop_sel, 1);
    len = zeros(NN, 1);     % 给len数组重新分配空间，清除之前的数据
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