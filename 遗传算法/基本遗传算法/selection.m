function newPop = selection(pop, fitValue)
% 选择复制个体
% pop       初始种群二进制矩阵
% fitValue  种群个体的适应度值
totalFit = sum(fitValue);   % 求适应度值之和
select = fitValue ./ totalFit;  % 计算单个个体被选中的概率
select = cumsum(select);    % 计算累积和概率
[popSize, chromLength] = size(pop);     % 获取种群个体数目和染色体长度
ms = sort(rand(popSize, 1));    % 随机生成popSize个随机数，并从小到大排列
newPop = ones(popSize, chromLength);    % 复制后产生的新的种群个体
fitIn = 1;
newIn = 1;
while newIn < popSize
    if(ms(newIn)) < select(fitIn)
        newPop(newIn, :) = pop(fitIn, :);
        newIn = newIn + 1;
    else
        fitIn = fitIn + 1;
    end
end
end