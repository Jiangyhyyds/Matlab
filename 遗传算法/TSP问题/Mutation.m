function a = Mutation(A)
% 变异操作函数
% A     变异操作的个体
index1 = 0; index2 = 0;
nnper = randperm(size(A, 2));   % 随机生成1~N的一个随机排列，并取前两个作为交换
index1 = nnper(1);
index2 = nnper(2);
temp = 0;
temp = A(index1);
A(index1) = A(index2);
A(index2) = temp;
a = A;
end