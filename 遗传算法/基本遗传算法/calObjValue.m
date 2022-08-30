function objValue = calObjValue(pop, geneticlength, varLimit)
% 计算目标函数值
% pop               初始种群二进制编码矩阵
% geneticLength     变量基因编码长度
% varLimit          变量范围矩阵
varLimit1 = varLimit(1, :);
varLimit2 = varLimit(2, :);
decVar1 = decodeChrom(pop, 1, geneticlength);   % 将pop每行转化为十进制数
decVar2 = decodeChrom(pop, 11, geneticlength);
x1 = varLimit1(1) + decVar1 * (varLimit1(2)-varLimit1(1)) / (2^geneticlength - 1);       % 将二值域中的数转化为变量域中的数
x2 = varLimit2(1) + decVar2 * (varLimit2(2)-varLimit2(1)) / (2^geneticlength - 1);
objValue = MyFunc(x1, x2);              % 计算目标函数值
end