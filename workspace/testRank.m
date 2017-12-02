resourcePath = 'F:\!!!SabreHawk_PublicFolder\2017MCM\workspace\';
subfolder_num = 8;
str_vector_sort_total=[];
load worthless_str_vector;
for index_folder = 1 : subfolder_num
    temp_txtDir = dir([resourcePath,num2str(index_folder),'\*.txt']);
    for q = 1 : length(temp_txtDir)
        temp_txt = fopen([resourcePath,num2str(index_folder),'\',temp_txtDir(q).name] ,'r');
        flag=0;
        str=[];
        while ~feof(temp_txt)
            temp_line = fgetl(temp_txt);
            if flag==2
                str=[str,temp_line];
            end
            if flag==1
                flag=2;
            end
            if strfind(temp_line,'X-FileName: ')
                flag=flag+1;
            end
        end
        %str是正文内容
        str_vector = string(regexp(str,' ','split'));
        p = size(str_vector);
        str_len = p(2);
        %删除非字母
        for i=1:str_len
            temp_vector = char(str_vector(i));
            id = isletter(temp_vector);
            str_vector(i) = lower(temp_vector(id));
        end
        %str_vector是正文单词组
        str_vector_unique = unique(str_vector);
        t = size(str_vector_unique);
        str_vector_unique_len = t(2);
        
        M = zeros(str_vector_unique_len,str_vector_unique_len);
        for i = 1:str_len - 1
            temp_index = str_vector(i);
            temp_index_next = str_vector(i+1);
            for j = 1:str_vector_unique_len
                if strcmp(str_vector_unique(j),temp_index)
                    M_x=j;
                end
            end
            for k = 1:str_vector_unique_len
                if strcmp(str_vector_unique(k),temp_index_next)
                    M_y=k;
                end
            end
            M(M_y,M_x) = 1;
        end
        for j=1:str_vector_unique_len
            M(:,j) = M(:,j)/sum(M(:,j));
        end
        PR = ones(str_vector_unique_len,1);
        for iter = 1:100
            PR = 0.15 + 0.85*M*PR;
            if max(PR)<1
                disp(PR);
                break;
            end
            if iter == 100
                disp(PR);
            end
        end
        worthless_str = worthless_str_vector;
        worthless_str_len = length(worthless_str_vector);
        %删除无用词汇
        for i = 1:str_vector_unique_len
            for j = 1:worthless_str_len
                if(strcmp(str_vector_unique(i),worthless_str(j)))
                    str_vector_unique(i) = -1;
                end
            end
        end
        index = find(strcmp(str_vector_unique,'-1'));
        str_vector_unique(index) = [];
        PR(index) = [];
        str_vector_unique = [str_vector_unique;PR'];
        str_vector_unique = sortrows(str_vector_unique',-2);
        str_vector_sort = str_vector_unique(1:10,:);
        %[string([temp_txtDir(p).name]),string([temp_txtDir(p).name])]
        str_vector_sort = [[string([temp_txtDir(q).name]),string([temp_txtDir(q).name])];str_vector_sort];
        str_vector_sort_total = [str_vector_sort_total str_vector_sort];
    end
end