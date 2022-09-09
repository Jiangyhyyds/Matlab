function fitvalue = fitnessfun(x,n1,G)
[row,~] = size(x);%返回 x 的行数
for i = 1:row
    fval = objfun(x(i,:),n1,G);%计算目标函数的值
    a = 0.5;%适应度常数
    fitvalue = exp(-a*fval);%计算种群中个体的适应度（指数变化）
end
end