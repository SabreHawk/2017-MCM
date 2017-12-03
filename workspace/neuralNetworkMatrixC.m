load text_num;
writer = text_num(2,:);
writer = unique(writer);
writer_len = length(writer);
email_num = 427;
neuralNetworkMatrixsC = zeros(writer_len,email_num);
for j = 1:email_num
    for i = 1:writer_len
        if text_num(2,j) == writer(i)
            neuralNetworkMatrixsC(i,j) = 1;
        end
    end
end
save neuralNetworkMatrixsC neuralNetworkMatrixsC;