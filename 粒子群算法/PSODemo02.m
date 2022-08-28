x = zeros(1, 30);
% 迭代步数与解的精度间的关系
[xm1, fv1] = MyPSO(@Fitness, 10, 1.5, 2.5, 0.5, 100, 30);
[xm2, fv2] = MyPSO(@Fitness, 100, 1.5, 2.5, 0.5, 100, 30);
[xm3, fv3] = MyPSO(@Fitness, 500, 1.5, 2.5, 0.5, 100, 30);
% xlswrite("Demo01.xlsx", [[xm1; fv1], [xm2; fv2], [xm3; fv3]], "Sheet2", "B2 : D32");