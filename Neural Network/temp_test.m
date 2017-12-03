MATLAB程序代码--bp神经网络应用举例
1 BP神经网络的设计实例  
例1 采用动量梯度下降算法训练 BP 网络。  
训练样本定义如下：  
输入矢量为      
 p =[-1 -2 3  1   
     -1  1 5 -3]  
目标矢量为   t = [-1 -1 1 1]  
解：本例的 MATLAB 程序如下：   

close all   
clear   
echo on   
clc   
% NEWFF——生成一个新的前向神经网络   
% TRAIN——对 BP 神经网络进行训练   
% SIM——对 BP 神经网络进行仿真   
pause          
%  敲任意键开始   
clc   
%  定义训练样本   
% P 为输入矢量   
P=[-1,  -2,    3,    1;       -1,    1,    5,  -3];  
% T 为目标矢量   
T=[-1, -1, 1, 1];   
pause;   
clc   
%  创建一个新的前向神经网络   
net=newff(minmax(P),[3,1],{'tansig','purelin'},'traingdm')  
%  当前输入层权值和阈值   
inputWeights=net.IW{1,1}   
inputbias=net.b{1}   
%  当前网络层权值和阈值   
layerWeights=net.LW{2,1}   
layerbias=net.b{2}   
pause   
clc   
%  设置训练参数   
net.trainParam.show = 50; %两次显示之间的训练次数,缺省值为25  
net.trainParam.lr = 0.05;%学习速率   
net.trainParam.mc = 0.9; %动量常数设置,缺省就是0.9  
net.trainParam.epochs = 1000; %训练次数,缺省值为100  
net.trainParam.goal = 1e-3; %网络性能目标,缺省值为0  
pause   
clc   
%  调用 TRAINGDM 算法训练 BP 网络   
[net,tr]=train(net,P,T);   
pause   
clc   
%  对 BP 网络进行仿真   
A = sim(net,P)   
%  计算仿真误差   
E = T - A   
MSE=mse(E)   
pause   
clc   
echo off   
例2 采用贝叶斯正则化算法提高 BP 网络的推广能力。在本例中，我们采用两种训练方法，即 L-M 优化算法（trainlm）和贝叶斯正则化算法（trainbr），用以训练 BP 网络，使其能够拟合某一附加有白噪声的正弦样本数据。其中，样本数据可以采用如下MATLAB 语句生成：   
输入矢量：P = [-1:0.05:1]；   
目标矢量：randn(’seed’,78341223)；   
T = sin(2*pi*P)+0.1*randn(size(P))；   
解：本例的 MATLAB 程序如下：   
close all   
clear   
echo on   
clc   
% NEWFF——生成一个新的前向神经网络   
% TRAIN——对 BP 神经网络进行训练  
% SIM——对 BP 神经网络进行仿真   
pause          
%  敲任意键开始   
clc   
%  定义训练样本矢量   
% P 为输入矢量   
P = [-1:0.05:1];   
% T 为目标矢量   
randn('seed',78341223); T = sin(2*pi*P)+0.1*randn(size(P));   
%  绘制样本数据点   
plot(P,T,'+');   
echo off   
hold on;   
plot(P,sin(2*pi*P),':');          
%  绘制不含噪声的正弦曲线   
echo on   
clc   
pause   
clc   
%  创建一个新的前向神经网络   
net=newff(minmax(P),[20,1],{'tansig','purelin'});   
pause   
clc   
echo off   
clc  
disp('1.  L-M 优化算法 TRAINLM'); disp('2.  贝叶斯正则化算法 TRAINBR');   
choice=input('请选择训练算法(1,2):');   
figure(gcf);   
if(choice==1)                   
    echo on           
    clc           
    %  采用 L-M 优化算法 TRAINLM   
    net.trainFcn='trainlm';           
    pause           
    clc           
    %  设置训练参数           
    net.trainParam.epochs = 500;           
    net.trainParam.goal = 1e-6;           
    net=init(net);          
    %  重新初始化             
    pause           
    clc  
elseif(choice==2)           
    echo on           
    clc           
    %  采用贝叶斯正则化算法 TRAINBR           
    net.trainFcn='trainbr';           
    pause           
    clc           
    %  设置训练参数           
    net.trainParam.epochs = 500;           
    randn('seed',192736547);           
    net = init(net);          
    %  重新初始化             
    pause           
    clc           
end   
  
 % 调用相应算法训练 BP 网络  
[net,tr]=train(net,P,T);  
pause  
clc  
% 对 BP 网络进行仿真  
A = sim(net,P);  
% 计算仿真误差  
E = T - A;  
MSE=mse(E)  
pause  
clc  
% 绘制匹配结果曲线  
close all;  
plot(P,A,P,T,'+',P,sin(2*pi*P),':');  
pause;  
clc  
echo off  

通过采用两种不同的训练算法，我们可以得到如图 1和图 2所示的两种拟合结果。图中的实线表示拟合曲线，虚线代表不含白噪声的正弦曲线，“＋”点为含有白噪声的正弦样本数据点。显然，经 trainlm 函数训练后的神经网络对样本数据点实现了“过度匹配”，而经 trainbr 函数训练的神经网络对噪声不敏感，具有较好的推广能力。  

值得指出的是，在利用 trainbr 函数训练 BP 网络时，若训练结果收敛，通常会给出提示信息“Maximum MU reached”。此外，用户还可以根据 SSE 和 SSW 的大小变化情况来判断训练是否收敛：当 SSE 和 SSW 的值在经过若干步迭代后处于恒值时，则通常说明网络训练收敛，此时可以停止训练。观察trainbr 函数训练 BP 网络的误差变化曲线,可见，当训练迭代至 320 步时，网络训练收敛，此时 SSE 和 SSW 均为恒值，当前有效网络的参数（有效权值和阈值）个数为 11.7973。  
例3 采用“提前停止”方法提高 BP 网络的推广能力。对于和例 2相同的问题，在本例中我们将采用训练函数 traingdx 和“提前停止”相结合的方法来训练 BP 网络，以提高 BP 网络的推广能力。  
解：在利用“提前停止”方法时，首先应分别定义训练样本、验证样本或测试样本，其中，验证样本是必不可少的。在本例中，我们只定义并使用验证样本，即有  
验证样本输入矢量：val.P = [-0.975:.05:0.975]  
验证样本目标矢量：val.T = sin(2*pi*val.P)+0.1*randn(size(val.P))  
值得注意的是，尽管“提前停止”方法可以和任何一种 BP 网络训练函数一起使用，但是不适合同训练速度过快的算法联合使用，比如 trainlm 函数，所以本例中我们采用训练速度相对较慢的变学习速率算法 traingdx 函数作为训练函数。  
本例的 MATLAB 程序如下：  
close all  
clear  
echo on  
clc  
% NEWFF——生成一个新的前向神经网络  
% TRAIN——对 BP 神经网络进行训练  
% SIM——对 BP 神经网络进行仿真  
pause  
% 敲任意键开始  
clc  
% 定义训练样本矢量  
% P 为输入矢量  
P = [-1:0.05:1];  
% T 为目标矢量  
randn('seed',78341223);  
T = sin(2*pi*P)+0.1*randn(size(P));  
% 绘制训练样本数据点  
plot(P,T,'+');  
echo off  
hold on;  
plot(P,sin(2*pi*P),':'); % 绘制不含噪声的正弦曲线  
echo on  
clc  
pause  
clc  
% 定义验证样本  
val.P = [-0.975:0.05:0.975]; % 验证样本的输入矢量  
val.T = sin(2*pi*val.P)+0.1*randn(size(val.P)); % 验证样本的目标矢量  
pause  
clc  
% 创建一个新的前向神经网络  
net=newff(minmax(P),[5,1],{'tansig','purelin'},'traingdx');  
pause  
clc  
% 设置训练参数  
net.trainParam.epochs = 500;  
net = init(net);  
pause  
clc  
% 训练 BP 网络  
[net,tr]=train(net,P,T,[],[],val);  
pause  
clc  
% 对 BP 网络进行仿真  
A = sim(net,P);  
% 计算仿真误差  
E = T - A;  
MSE=mse(E)  
pause  
clc  
% 绘制仿真拟合结果曲线  
close all;  
plot(P,A,P,T,'+',P,sin(2*pi*P),':');  
pause;  
clc  
echo off  
下面给出了网络的某次训练结果，可见，当训练至第 136 步时，训练提前停止，此时的网络误差为 0.0102565。给出了训练后的仿真数据拟合曲线，效果是相当满意的。  
[net,tr]=train(net,P,T,[],[],val);  
TRAINGDX, Epoch 0/500, MSE 0.504647/0, Gradient 2.1201/1e-006  
TRAINGDX, Epoch 25/500, MSE 0.163593/0, Gradient 0.384793/1e-006  
TRAINGDX, Epoch 50/500, MSE 0.130259/0, Gradient 0.158209/1e-006  
TRAINGDX, Epoch 75/500, MSE 0.086869/0, Gradient 0.0883479/1e-006  
TRAINGDX, Epoch 100/500, MSE 0.0492511/0, Gradient 0.0387894/1e-006  
TRAINGDX, Epoch 125/500, MSE 0.0110016/0, Gradient 0.017242/1e-006  
TRAINGDX, Epoch 136/500, MSE 0.0102565/0, Gradient 0.01203/1e-006  
TRAINGDX, Validation stop.  

