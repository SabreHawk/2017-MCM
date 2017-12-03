%%%Set Initial Values
wordsNum = 1492;
emailNum = 427;
tagNum = 53;

trainNum = emailNum;
testNum = emailNum;

%%% Read Train/test Data
%{
trainData_path = 'C:\Users\mySab\Documents\!!!SabreHawk_PublicFolder\2017-MCM\workspace\Neural-Network'; 
trainData_name = 'trainData.txt';
input_file = fopen([trainData_path,trainData_name],'r');
%}
emailCount = 0;
%input_data_matrix = zeros(emialNum,species_nums+1);%%input features and tags
load neuralNetworkMatrixsA;
load neuralNetworkMatrixsB;
input_data_matrix = neuralNetworkMatrixsA;
%input_data_matrix = cellfun(@(x)sscanf(x,'%f'),input_data_matrix);
output_data_matrix= neuralNetworkMatrixsB;
output_data_matrix = cellfun(@(x)sscanf(x,'%f'),output_data_matrix);

%%%Construt Input/Output Train/Test Data Matrix
input_train_matrix = input_data_matrix';
output_train_matrix = output_data_matrix(:,1:end-1)';


input_test_matrix = input_train_matrix;
output_test_matrix = output_train_matrix;
%%%Data Normailization
%size(input_train_matrix)

[input_train_matrix,input_train_setting] = mapminmax(input_train_matrix);
%size(input_train_matrix)
[output_train_matrix,output_train_setting] = mapminmax(output_train_matrix);
[output_test_matrix_view,output_test_view_setting] =  mapminmax(output_test_matrix);
%%%Initialize Neural Network
layerNum = 16;
nNet = newff(input_train_matrix,output_train_matrix,[64,32],{'tansig','purelin'},'traingdx');
%nNet = newff(input_train_matrix,output_train_matrix,[128,64]);

%Set Train Values
nNet.trainParam.show = 50;
%nNet.trainParam.epochs = 10000;
nNet.trainParam.lr = 0.00001;
nNet.trainParam.goal = 0.000000000001;
%Train Neural Network
%size(input_train_matrix)
%size(output_train_matrix)
nNet = train(nNet,input_train_matrix,output_train_matrix);

input_test_matrix = mapminmax('apply',input_test_matrix,input_train_setting);
answer_matrix = sim(nNet,input_test_matrix);
BP_output_matrix = mapminmax('reverse',answer_matrix,output_test_view_setting);

[rate,cmpMatrix,offset_vector] = validationNetwork(BP_output_matrix,output_test_matrix);
%[answer_matrix',output_test_matrix_view']

rate
