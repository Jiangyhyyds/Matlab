function newPop = crossOver(pop, pc)
% 交叉
% pop       初始种群二进制编码矩阵
% pc        种群交叉概率
[popSize, chromLength] = size(pop);     % 获取种群个体数目和染色体长度
newPop = ones(size(pop));               % 交叉后的新种群个体
for i = 1 : 2 : popSize - 1
    if rand < pc    % 均匀分布产生的随机数小于pc，代表此时发生交叉
        cross_point = round(rand * chromLength);    % 随机产生染色体上的交叉点
        newPop(i, :) = [pop(i, 1 : cross_point), pop(i + 1, cross_point + 1 : end)];
        newPop(i + 1, :) = [pop(i + 1, 1 : cross_point), pop(i, cross_point + 1 : end)];
    else            % 随机数大于pc，代表此时不发生交叉，原来的个体不变
        newPop(i, :) = pop(i, :);
        newPop(i + 1, :) = pop(i + 1, :);
    end
end
end