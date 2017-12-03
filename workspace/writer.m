%load writer;
for i = 1:427
    for j = 1:59
        isFlag = strcmp(text_num(2,i),writer(j));
        if isFlag
            text_num(3,i) = j;
        end
    end
end