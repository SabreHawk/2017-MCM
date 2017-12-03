resourcePath = 'F:\!!!SabreHawk_PublicFolder\2017-MCM\workspace\result3.txt';
load str_vector_sort_total;
t = size(str_vector_sort_total);
col_num = t(2);
email_num = col_num/2;
for i = 1:email_num
    txt = fopen(resourcePath ,'r');
    while ~feof(txt)
        temp_line = fgetl(txt);
        if strfind(temp_line,text_num(1,i))
            str = string(regexp(temp_line,' ','split'));
            text_num(2,i) = str(2);
        end
    end
    fclose(txt);
end