load str_vector_sort_total;
t = size(str_vector_sort_total);
col_num = t(2);
email_num = col_num/2;
str_vector = [];
for j = 1:2:col_num
    for i = 2:10
        str_vector = [str_vector,str_vector_sort_total(i,j)];
    end
end
str_vector = unique(str_vector);
str_vector_len = length(str_vector);
neuralNetworkMatrixsA = zeros(str_vector_len,email_num);
for j = 1:email_num
    for i = 1:str_vector_len
        if ismember(str_vector(i),str_vector_sort_total(2:10,2*j - 1))
            neuralNetworkMatrixsA(i,j) = 1;
        end
    end
end
save neuralNetworkMatrixsA neuralNetworkMatrixsA;
