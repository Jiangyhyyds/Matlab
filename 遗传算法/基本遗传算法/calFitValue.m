function fitValue = calFitValue(objValue)
% 计算个体的适应值
% objValue      目标函数值
global Cmin;
Cmin = 0;
[popSize, ~] = size(objValue);
for i = 1 : popSize
    if objValue(i) + Cmin > 0
        temp = Cmin + objValue(i);
    else
        temp = 0.0;
    end
    fitValue(i) = temp;
end
fitValue = fitValue';
end