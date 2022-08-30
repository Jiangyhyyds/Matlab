function [bestIndividual, bestFit] = bestFitValue(pop, fitValue)
% 求出群体中适应值最大的值
% pop       初始种群二进制编码矩阵
% fitValue  种群个体的适应度值
[popSize, ~] = size(pop);     % 获取种群个体数目
bestIndividual = pop(1, :);
bestFit = fitValue(1);
for i = 2 : popSize
    if fitValue(i) < bestFit
        bestIndividual = pop(i, :);
        bestFit = fitValue(i);
    end
end
end