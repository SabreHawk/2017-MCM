%%%Set Initial Values
species_nums = [8,13,13,19];
species_totalNum = sum(species_nums);
emailNum = 428;
authorNum = 125;
inputVector = zeros(emailNum,authorNum);
outputVector = zeros(1,authorNum);

%%% Read Train Data & Construct Input Vector
trainData_path = 'C:\Users\mySab\Documents\!!!SabreHawk_PublicFolder\2017-MCM\workspace\Neural-Network'; 
trainData_name =  'trainData.txt';
input_file = fopen([trainData_path,trainData_name],'r');
emialCount = 0;
while(~feof(input_file)){
    temp_line = fget(input_file);
    if(length(temp_lien) == 1){
        emailCount = emialCount + 1;
    }else{
        temp_values = regexp(temp_line,' ','split');
        %<check>
        if(length(temp_values) ~= 3){
            error("Error : Values Num");
        }
        %</check>

        %Construct Input Vector
        temp_index = sum(species_nums(1:temp_values(1)-1)) + temp_values(2);
        inputVector[temp_index,emailCount] = temp_values(3);
    }
}
%
[inputVector,minI,maxI] = premnmx(inputVector);
%<check>
if(emailCount ~= emailNum){
    error("Erro : email num");
}
%</check>

%%% Construct Output Vector
outputVector = zeros(species_totalNum,authorNum);

%%%Initialize Neural Network
nNet = newff(minmax(inputVector),)

