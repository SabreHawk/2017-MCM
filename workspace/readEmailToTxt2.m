%read and arrange the attributes of each email

resourcePath = 'F:\!!!SabreHawk_PublicFolder\2017-MCM\workspace\';

subfolder_num = 8;
counter = 0;
for index = 1 : subfolder_num
    temp_catDir = dir([resourcePath,num2str(index),'\*.cats']);
    temp_txtDir = dir([resourcePath,num2str(index),'\*.txt']);
    resultContext = [];
    resultHead = [];
    outResult = [];
    temp_space = cell(1,1);
    for i = 1 : length(temp_catDir)
        temp_cats =fopen([resourcePath,num2str(index),'\',temp_catDir(i).name] ,'r');
        temp_txt = fopen([resourcePath,num2str(index),'\',temp_txtDir(i).name] ,'r');
        temp_context =[];
        temp_head = cell(1,3);
        %  temp_head(2) =   {'name'};
        %reaed author
        temp_head(1) = {temp_catDir(i).name};
        temp_head(2) = {''};
        temp_head(3) = {''};
        fclose(temp_txt);
        %read species .cats
        temp_context = [temp_head;temp_context];
        while ~feof(temp_cats)
            temp_line = fgetl(temp_cats);
            temp_vector = regexp(temp_line,',','split');
            temp_context = [temp_context;temp_vector];
        end
        temp_size = size(temp_context);
        temp_rownum = temp_size(1);
        for i = 1:temp_rownum-1
            %temp_head = [temp_head;temp_space];
        end
        
        %resultHead = [resultHead;temp_head];
        %resultContext = [temp_head;resultContext];
        resultContext = [resultContext;temp_context];
        fclose(temp_cats);
    end
 %   ['C:\Users\Zhiquan.Wang\Documents\!!!SabreHawk_PublicFolder\2017MCM\workspace\result',index,'.xls']
    %xlswrite(['F:\!!!SabreHawk_PublicFolder\2017MCM\workspace\result1.xls'],resultHead,num2str(index),'A3');
    xlswrite(['F:\!!!SabreHawk_PublicFolder\2017-MCM\workspace\result2.xls'],resultContext,num2str(index),'A1');
end
