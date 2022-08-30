function [] = MyGeneticFunc(MyFunc, varLimit)
% 遗传算法求解一维函数的极值问题
% MyFunc    目标函数
% varLimit  变量上下边界

%% 初始化
popSize = 20;       % 群体大小
chromLength = 20;   % 字符串长度（与变量个数以及编码精度有关）
geneticLength = 10; % 每个变量的编码长度（编码精度）
pc = 0.7;           % 交叉概率
pm = 0.005;         % 变异概率
pop = initPop(popSize, chromLength);    % 随机产生初始种群个体
Time = 100;          % 迭代次数
plotFuncFigure(pop, 1);
%% 开始遗传迭代
for i = 1 : Time
    objValue = calObjValue(pop, geneticLength); % 计算目标函数
    fitValue = calFitValue(objValue);           % 计算群体中每个个体的适应度值
    newPop = selection(pop, fitValue);          % 种群复制
    newPop = crossOver(newPop, pc);             % 种群交叉
    newPop = mutation(newPop, pm);              % 种群变异
    % 这时的newPop是经过复制，交叉，变异产生的新一代子群个体
    % 下面是进行择优保留操作，即实现保底机制
    newObjValue = calObjValue(newPop, geneticLength);          % 计算新种群个体的目标函数
    newFitValue = calFitValue(newObjValue);     % 计算新种群个体的适应度值
    bestIndex = find(newFitValue > fitValue);   % 选择适应度更好的个体，择优保留
    pop(bestIndex, :) = newPop(bestIndex, :);   % 最优个体替换较差个体，以保证每次迭代后都会比之前更优
    fitValue(bestIndex) = newFitValue(bestIndex);
    plotFuncFigure(pop, i);
    [bestIndividual, bestFit] = bestFitValue(pop, fitValue);             % 求出群体中适应度值最大的个体及其适应值
    y(i) = bestFit;
    x(i) = varLimit(1) + decodeChrom(bestIndividual, 1, geneticLength) * (varLimit(2)-varLimit(1)) / (2^geneticLength - 1);
    plotGenFigure(1 : i, y);                    % 绘制最优值迭代进化曲线
end
[maxValue, maxIndex] = max(y);
disp(['找的最优解位置为：', num2str(x(maxIndex)) ]);
disp(['对应最优解为：', num2str(maxValue) ]);

%% **********************函数initPop********************************
function pop = initPop(popSize, chromLength)
% 初始化种群
% popSize       种群个体数目
% chromLength   染色体长度
pop = round(rand(popSize, chromLength));
% rand 随机产生行为popSize, 列为chromLength的服从(0, 1)均匀分布的二维矩阵
% round四舍五入函数，将随机数矩阵的元素映射为0，1元素，产生初始种群
end

%% **********************函数calObjValue****************************
function objValue = calObjValue(pop, geneticlength)
% 计算目标函数值
% pop               初始种群二进制编码矩阵
% geneticLength     变量基因编码长度
decVar = decodeChrom(pop, 1, geneticlength);   % 将pop每行转化为十进制数
x1 = varLimit(1) + decVar * (varLimit(2)-varLimit(1)) / (2^geneticlength - 1);       % 将二值域中的数转化为变量域中的数
objValue = MyFunc(x1);              % 计算目标函数值
end

%% **********************函数calFitValue****************************
function fitValue = calFitValue(objValue)
% 计算个体的适应值
% objValue      目标函数值
global Cmin;
Cmin = 0;
for i1 = 1 : popSize
    if objValue(i1) + Cmin > 0
        temp = Cmin + objValue(i1);
    else
        temp = 0.0;
    end
    fitValue(i1) = temp;
end
fitValue = fitValue';
end

%% **********************函数selection******************************
function newPop = selection(pop, fitValue)
% 选择复制个体
% pop       初始种群二进制矩阵
% fitValue  种群个体的适应度值
totalFit = sum(fitValue);   % 求适应度值之和
select = fitValue ./ totalFit;  % 计算单个个体被选中的概率
select = cumsum(select);    % 计算累积和概率
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

%% **********************函数crossOver******************************
function newPop = crossOver(pop, pc)
% 交叉
% pop       初始种群二进制编码矩阵
% pc        种群交叉概率
newPop = ones(size(pop));               % 交叉后的新种群个体
for i2 = 1 : 2 : popSize - 1
    if rand < pc    % 均匀分布产生的随机数小于pc，代表此时发生交叉
        cross_point = round(rand * chromLength);    % 随机产生染色体上的交叉点
        newPop(i2, :) = [pop(i2, 1 : cross_point), pop(i2 + 1, cross_point + 1 : end)];
        newPop(i2 + 1, :) = [pop(i2 + 1, 1 : cross_point), pop(i2, cross_point + 1 : end)];
    else            % 随机数大于pc，代表此时不发生交叉，原来的个体不变
        newPop(i2, :) = pop(i2, :);
        newPop(i2 + 1, :) = pop(i2 + 1, :);
    end
end
end

%% **********************函数mutation*******************************
function newPop = mutation(pop, pm)
% 变异
% pop       初始种群二进制编码矩阵
% pm        种群变异概率
newPop = ones(size(pop));               % 变异后产生的新种群个体
for i3 = 1 : popSize
    if rand < pm        % 均匀分布产生的随机数小于pm，代表此时发生变异
        muta_point = round(rand * chromLength);     % 随机产生染色体上的变异点
        if muta_point <= 0
            muta_point = 1;
        end
        newPop(i3, :) = pop(i3, :);
        if newPop(i3, muta_point) == 0       % 染色体对应位置上的基因序列翻转
            newPop(i3, muta_point) = 1;
        else
            newPop(i3, muta_point) = 0;
        end
    else                % 随机数大于pm，代表此时不发生变异，原来的个体不变
        newPop(i3, :) = pop(i3, :);
    end
end
end

%% **********************函数bestFitValue***************************
function [bestIndividual, bestFit] = bestFitValue(pop, fitValue)
% 求出群体中适应值最大的值
% pop       初始种群二进制编码矩阵
% fitValue  种群个体的适应度值
bestIndividual = pop(1, :);
bestFit = fitValue(1);
for i4 = 2 : popSize
    if fitValue(i4) > bestFit
        bestIndividual = pop(i4, :);
        bestFit = fitValue(i4);
    end
end
end

%% **********************函数decodeChrom****************************
function decVar = decodeChrom(pop, spoint, length)
% 将染色体（二进制编码）转化为十进制数（可编码多个变量）
% pop       初始种群矩阵
% spoint    待解码变量的二进制串起始位置
% length    每个变量的长度
binaryVar = pop(:, spoint : spoint + length - 1);
decVar = decodeBinary(binaryVar);
end

%% **********************函数decodeBinary***************************
function dec = decodeBinary(pop)
% 二进制转化为十进制数
% pop   初始种群二进制编码矩阵
[row, col] = size(pop);     % 求矩阵的行和列
Weight = zeros(row, col);   % 二进制转十进制的权值矩阵
for i5 = 1 : col
    Weight(:, i5) = pop(:, i5) .* 2 .^ (col - i5);
end
dec = sum(Weight, 2);       % 二进制转换后的十进制数
% 求Weight的每行之和，即为转化后的十进制数
end

%% **********************函数plotGenFigure**************************
function [] = plotGenFigure(Time, y)
% 绘制最优值迭代进化曲线
% Time      迭代次数
% y         每次迭代的最优值
subplot(1, 2, 2);
plot(Time, y);
title("最优值迭代进化曲线");
set(gca, "FontSize", 22);
pause(0.1);
end

%% **********************函数plotFuncFigure*************************
function [] = plotFuncFigure(pop, k)
% 绘制目标函数曲线与遗传因子迭代进化点
xi = varLimit(1) : 0.01 : varLimit(2);
yi = MyFunc(xi);
dec = varLimit(1) + decodeChrom(pop, 1, geneticLength) * (varLimit(2) - varLimit(1)) ./ (2^geneticLength - 1);
fx = MyFunc(dec);
subplot(1, 2, 1);
plot(xi, yi, "b", dec, fx, "*");
title(['第',num2str(k),'次迭代进化']);
set(gca, "FontSize", 22);
end
end