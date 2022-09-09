clear, clc;
close all;
%建模前的准备工作
n1 = size(92,1);    %节点的数量
G = xlsread("A区各点间的最短距离.xlsx", "Sheet1", "A1 : CN92");  % A区城市各点间的最短路径对应的距离
%遗传算法
global w;
w=[0.5,0.5];
varnum = 5;%设置新增平台的个数
n = 60;%种群大小
lb = 21*ones(1,varnum);%变量的上限
ub = 92*ones(1,varnum);%变量的下限
eps = 1;%精度
pc = 0.9;%交叉概率
pm = 0.01;%变异概率
maxgen = 100;%遗传代数
% 初始化种群
for i = 1:varnum
    L(i) = ceil(log2((ub(i) - lb(i)) / eps + 1));
end
LS = sum(L);%总位长
pop = randi([0 1],n,LS);
spoint = cumsum([0 L]);
for iter = 1:maxgen
    % 将二进制转化为十进制
    for i = 1:n
        for j = 1:varnum
            startpoint = spoint(j) + 1;
            endpoint = spoint(j+1);
            real(i,j) = decode(pop(i,startpoint:endpoint),lb(j),ub(j));
        end
    end
    % 计算适应度值
    fitvalue = fitnessfun(real,n1,G);
    % 选择
    [dad,mom] = selection (pop,fitvalue);
    % 交叉
    newpop = crossover(dad,mom,pc);
    % 变异
    newpop = mutation(newpop,pm);
    pop = newpop;
end
% 将二进制转化为十进制
for i = 1:n
    for j = 1:varnum
        startpoint = spoint(j) + 1;
        endpoint = spoint(j+1);
        real(i,j) = decode(pop(i,startpoint:endpoint),lb(j),ub(j));
    end
end
%找出适应度最大的个体
fitvalue = fitnessfun(real,n1,G);
[bestfitness, bestindex] = max(fitvalue);
bestindividual = real(bestindex,:);
fval = objfun(bestindividual,n1,G);