function newpop = crossover(dad,mom,pc)
[row,col] = size(dad);
for i = 1:row
    if rand < pc                        %如果随机数小于交叉概率
        cpoint = randi([1 col-1]);      %那么随机生成一个交叉点
        newpop(i,:) = [dad(i,1:cpoint) mom(i,cpoint+1:end)];
    else
        newpop(i,:) = dad(i,:);
    end
end
end