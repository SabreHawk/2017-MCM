resourcePath = 'F:\!!!SabreHawk_PublicFolder\2017-MCM\workspace\worthless_str.txt';
txt = fopen([resourcePath] ,'r');
str = [];
while ~feof(txt)
    temp_line = fgetl(txt);
    str=[str,temp_line];
end
worthless_str_vector = string(regexp(str,',','split'));
save worthless_str_vector worthless_str_vector;