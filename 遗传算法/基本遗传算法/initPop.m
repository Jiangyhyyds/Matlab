function pop = initPop(popSize, chromLength)
% 初始化种群
% popSize       种群个体数目
% chromLength   染色体长度
pop = round(rand(popSize, chromLength));
% rand 随机产生行为popSize, 列为chromLength的服从(0, 1)均匀分布的二维矩阵
% round四舍五入函数，将随机数矩阵的元素映射为0，1元素，产生初始种群
end