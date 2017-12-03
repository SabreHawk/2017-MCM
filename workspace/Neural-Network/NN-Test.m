%%%Set Initial Values
species_nums = [8,13,13,19];
species_totalNum = sum(species_nums);

emailNum = 428;
authorNum = 125;

trainNum = 400;
testNum = email - trainNum;

{%%% Read Train/test Data
trainData_path = 'C:\Users\mySab\Documents\!!!SabreHawk_PublicFolder\2017-MCM\workspace\Neural-Network'; 
trainData_name =  'trainData.txt';
input_file = fopen([trainData_path,trainData_name],'r');
emailCount = 0;
input_data_matrix = zeros(emialNum,species_nums+1);//input features and tags
while ~feof(input_file)
    temp_line = fget(input_file);
    if length(temp_line) == 1
        emailCount = emialCount + 1;
        input_data_matrix(emailCount,end) = temp_line;
    elseif temp_values == 3
        temp_values = regexp(temp_line,' ','split');
        %Construct Input Vector
        temp_index = sum(species_nums(1:temp_values(1)-1)) + temp_values(2);
        input_data_matrix[emailCount,temp_index] = temp_values(3);
    else
        %<check>
            error('Error : Values Num');
        %</check>
    end
end
%<check>
if emailCount ~= emailNum
    error('Erro : email num');
end
%</check>
}
%%%Construt Input/Output Train/Test Data Matrix
input_train_matrix = input_data_matrix(1:trainNum,1:species_totalNum);
output_train_matrix = input_data_matrix(1:trainNum,end);
intpu_test_matrix = input_data_matrix(trainNum+1:end,species_totalNum);

%%%Data Normailization
[input_train_matrix,input_train_setting] = mapminmax(input_)

%%%Initialize Neural Network
layerNum = 128;
nNet = newff(input_matrix,output_matrix,[layerNum],{'tansig','purelin'},'traingdx');
%Set Train Values
nNet = init(nNet);
nNet.trainParam.show = 50;
nNet.trainParam.epochs = 10000;
nNet.trainParam.lr = 0.05;
nNet.trainParam.goal = 0.001;


%Train Neural Network

nNet = train(net,)


