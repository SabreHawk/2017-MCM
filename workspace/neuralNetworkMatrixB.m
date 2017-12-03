resourcePath = 'F:\!!!SabreHawk_PublicFolder\2017-MCM\workspace\result2.txt';
load str_vector_sort_total;
t = size(str_vector_sort_total);
col_num = t(2);
email_num = col_num/2;
str = [];
num_array = [0,8,21,34,53];
neuralNetworkMatrixsB = zeros(num_array(5),email_num);
for i = 1:email_num
    txt = fopen(resourcePath ,'r');
    flag = 0;
    while ~feof(txt)
        temp_line = fgetl(txt);
        if strfind(temp_line,str_vector_sort_total(1,2*i - 1))
            text_num(1,i) = str_vector_sort_total(1,2*i - 1);
            flag = 1;
        else
            if strfind(temp_line,'txt')
                flag = 0;
            end
            if flag == 1
                characteristic = str2double(string(regexp(temp_line,' ','split')));
                neuralNetworkMatrixsB(num_array(characteristic(1)) + characteristic(2),i) = characteristic(3);
            end
        end
    end
    fclose(txt);
end
save neuralNetworkMatrixsB neuralNetworkMatrixsB;