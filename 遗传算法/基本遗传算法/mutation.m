function newPop = mutation(pop, pm)
% 变异
% pop       初始种群二进制编码矩阵
% pm        种群变异概率
[popSize, chromLength] = size(pop);     % 获取种群个体数目和染色体长度
newPop = ones(size(pop));               % 变异后产生的新种群个体
for i = 1 : popSize
    if rand < pm        % 均匀分布产生的随机数小于pm，代表此时发生变异
        muta_point = round(rand * chromLength);     % 随机产生染色体上的变异点
        if muta_point <= 0
            muta_point = 1;
        end
        newPop(i, :) = pop(i, :);
        if newPop(i, muta_point) == 0       % 染色体对应位置上的基因序列翻转
            newPop(i, muta_point) = 1;
        else
            newPop(i, muta_point) = 0;
        end
    else                % 随机数大于pm，代表此时不发生变异，原来的个体不变
        newPop(i, :) = pop(i, :);
    end
end
end