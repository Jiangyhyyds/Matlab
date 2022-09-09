function newpop = mutation(pop,pm)
[row,col] = size(pop);
newpop = zeros(row,col);
for i = 1:row
    mpoint = randi([1 col]);            %随机生成一个变异点
    if rand < pm                        %如果随机数小于变异概率
        newpop(i,:) = ~pop(i,mpoint);
    else
        newpop(i,:) = pop(i,:);
    end
end
end