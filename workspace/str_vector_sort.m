load str_vector_sort_total;
str_vector_sort1 = [];
for i = 1:427
str_vector_sort1 = [str_vector_sort1,str_vector_sort_total(:,i*2 - 1)];
end
str_vector_sort1 = str_vector_sort1';