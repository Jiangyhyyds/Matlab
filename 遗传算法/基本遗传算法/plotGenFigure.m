function [] = plotGenFigure(Time, y)
% 绘制最优值迭代进化曲线
% Time      迭代次数
% y         每次迭代的最优值
% plot(1, 2, 2);
plot(Time, y);
xlabel("迭代次数/次");
ylabel("目标函数最优值");
title("最优值迭代进化曲线");
set(gca, "FontSize", 22);
pause(0.1);
end