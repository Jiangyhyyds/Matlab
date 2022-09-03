function fitness = calFit(len, m, maxLen, minLen)
% 计算适应度函数
% len       种群中每个个体对应的路径长度
% m         适应值归一化淘汰加速指数
% maxLen    种群中最长路径长度
% minLen    种群中最短路径长度
fitness = len;
for i = 1 : length(len)
    fitness(i) = (1 - (len(i) - minLen) / (maxLen - minLen + 0.0001)).^m;
end
end