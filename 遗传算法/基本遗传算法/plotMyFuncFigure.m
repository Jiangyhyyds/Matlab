xii = 0 : 0.01 : 5;
yii = 0 : 0.01 : 5;
[xi, yi] = meshgrid(xii, yii);
zi = zeros(length(yii), length(xii));
for i = 1 : length(yii)
    for j = 1 : length(xii)
        zi(i, j) = MyFunc(xi(i, j), yi(i, j));
    end
end
mesh(xi, yi, zi);
hold on;