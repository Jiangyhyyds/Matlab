% 遗传算法MATLAB主程序
% 实际问题中要注意修改相关参数：
% 群体大小，迭代次数
% 染色体长度以及每个变量的编码精度，以及每个变量的编码起始位置
% 求最大值还是求最小值
% 变量的左边界范围和变量区间与编码长度之间的映射，变量区间长度
% 目标函数值
clear, clc;
%% 设置初始种群参数
popSize = 20;       % 群体大小
chromLength = 20;   % 字符串长度（与变量个数以及编码精度有关）
geneticLength = 10; % 每个变量的编码长度（编码精度）
pc = 0.7;           % 交叉概率
pm = 0.005;         % 变异概率
pop = initPop(popSize, chromLength);    % 随机产生初始种群个体
Time = 100;          % 迭代次数
varLimit1 = [0, 5];
varLimit2 = [0, 5];
%% 开始遗传迭代
for i = 1 : Time
    objValue = calObjValue(pop, geneticLength, [varLimit1; varLimit2]); % 计算目标函数
    fitValue = calFitValue(objValue);           % 计算群体中每个个体的适应度值
    newPop = selection(pop, fitValue);          % 种群复制
    newPop = crossOver(newPop, pc);             % 种群交叉
    newPop = mutation(newPop, pm);              % 种群变异
    % 这时的newPop是经过复制，交叉，变异产生的新一代子群个体
    % 下面是进行择优保留操作，即实现保底机制
    newObjValue = calObjValue(newPop, geneticLength, [varLimit1; varLimit2]);          % 计算新种群个体的目标函数
    newFitValue = calFitValue(newObjValue);     % 计算新种群个体的适应度值
    bestIndex = find(newFitValue < fitValue);   % 选择适应度更好的个体，择优保留
    pop(bestIndex, :) = newPop(bestIndex, :);   % 最优个体替换较差个体，以保证每次迭代后都会比之前更优
    fitValue(bestIndex) = newFitValue(bestIndex);
    [bestIndividual, bestFit] = bestFitValue(pop, fitValue);             % 求出群体中适应度值最大的个体及其适应值
    y(i) = bestFit;
    x1(i) = varLimit1(1) + decodeChrom(bestIndividual, 1, geneticLength) * (varLimit1(2)-varLimit1(1)) / (2^geneticLength - 1);
    x2(i) = varLimit2(1) + decodeChrom(bestIndividual, 11, geneticLength) * (varLimit2(2)-varLimit2(1)) / (2^geneticLength - 1);
    plotGenFigure(1 : i, y);                    % 绘制最优值迭代进化曲线
end
%% 画图，显示迭代图像
% xi = 0 : 0.01 : 15;
% yi = xi.*sin(10*pi*xi) + 2;
% plot(xi, yi);
% hold on;
% plot(x, y, "r*");
% hold off;