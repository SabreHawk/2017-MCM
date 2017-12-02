%%%Set Initial Values
species_nums = [8,13,13,19];
species_totalNum = sum(species_nums);
emailNum = 428;
authorNum = 125;
trainNum = 400;
testNum = email - trainNum;
input_train_matrix = zeros(species_nums,trainNum);
output_train_matrix = zeros(trainNum,species_totalNum);
intout_test_matrix = zeros(species_nums,testNum);
out_put_train_matrix = zeros(testNum,species_totalNum);
resultVector = zeros(1,testNum);

{%%% Read Train Data & Construct Input Train Matrix
trainData_path = 'C:\Users\mySab\Documents\!!!SabreHawk_PublicFolder\2017-MCM\workspace\Neural-Network'; 
trainData_name =  'trainData.txt';
input_file = fopen([trainData_path,trainData_name],'r');
emailCount = 0;
while ~feof(input_file)
    temp_line = fget(input_file);
    if length(temp_lien) == 1
        emailCount = emialCount + 1;
        resultVector[emailCount] = temp_lien
    elseif temp_values == 3
        temp_values = regexp(temp_line,' ','split');
        %Construct Input Vector
        temp_index = sum(species_nums(1:temp_values(1)-1)) + temp_values(2);
        input_train_matrix[temp_index,emailCount] = temp_values(3);
    else
        %<check>
            error('Error : Values Num');
        %</check>
    end
end
%
[input_train_matrix,minI,maxI] = premnmx(input_train_matrix);
%<check>
if emailCount ~= emailNum
    error('Erro : email num');
end
%</check>
}
%%% Construct Output Vector
output_train_matrix = zeros(emailNum,species_totalNum);
for i = 1:emailNum
    output_train_matrix(i,resultVector(i)) = 1;
    if resultVector(i) > species_totalNum
        error('Error : Species Value');
    end
end
%%%Initialize Neural Network
layerNum = 128;
nNet = newff(input_train_matrix,output_train_matrix,[layerNum],{'tansig','purelin'},'traingdx');
%Set Train Values
nNet = init(nNet);
nNet.trainParam.show = 50;
nNet.trainParam.epochs = 10000;
nNet.trainParam.lr = 0.05;
nNet.trainParam.goal = 0.001;


%Train Neural Network

nNet = train(net,)


