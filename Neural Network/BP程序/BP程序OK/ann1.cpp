#include<iostream.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define n 2  //输入维数
#define p 12  //隐层单元数
#define q 3   //输出维数 
#define m 60   //样本数k循环
struct annbp{
double x[n],       hi[p],       ho[p],          yi[q],         yo[q],         d[q];
//  输入向量 隐含层输入向量 隐含层输出向量  输出层输入向量   输出层输出向量  期望输出向量
double wih[n][p],              who[p][q],                     bh[p],         b[q];
//输入层与隐间层的连接权值  隐含层与输出层的连接权值  隐含层各神经元的阈值  输出层各神经元的阈值
int loopmax;//最大循环次数
double a;  //学习率
double e;//误差上限
};
double f(double x)
{
   return 1.0/(1.0+exp(-x));
} 
void InitBp(annbp *bp) { //初始化bp网络
   bp->loopmax=1000000;
   bp->a=0.2;
   bp->e=0.5;
   int i, j;
    srand((unsigned)time(NULL));
	rand();
    for (i = 0; i < n; i++) 
        for (j = 0; j < p; j++)
            bp->wih[i][j] = rand()/(double)(RAND_MAX);    
    for (i = 0; i < p; i++) 
        for (j = 0; j < q; j++)
            bp->who[i][j] = rand()/(double)(RAND_MAX);    
}

int TrainBp(annbp *bp, float x[m][n], int y[m][q]) 
{
//训练bp网络，样本为x，理想输出为y
    double f1 = bp->e;                      //精度参数
    double a = bp->a;                      //学习率
    double v[n][p], w[p][q]; //权矩阵
    double ChgH[p], ChgO[q];         //修改量
    double O1[p], O2[q];             //隐层和输出层输出量
    int LoopCout = bp->loopmax;           //最大循环次数
    int i, j, k, nn;
    double temp;
    for (i = 0; i < n; i++)            // 复制结构体中的权矩阵 
        for (j = 0; j < p; j++)
            v[i][j] = bp->wih[i][j];
    for (i = 0; i < p; i++)
        for (j = 0; j < q; j++)
            w[i][j] = bp->who[i][j];
    
    double e = f1 + 1;
    for (nn = 0; e > f1 && nn < LoopCout; nn++) //对每个样本训练网络
    {  
		e = 0;
        for(i=0;i<m;i++){ 
            for(k=0;k<p;k++)
			{          //计算隐层输出向量
                temp = 0;
                for (j=0;j<n;j++)
                    temp+=x[i][j]*v[j][k];    
                O1[k]=f(temp);//隐层输出向量
            }
            for (k = 0; k < q; k++) { //计算输出层输出向量
                temp = 0;
                for (j = 0; j < p; j++)
                    temp = temp + O1[j] * w[j][k];
                O2[k] = f(temp);//输出层输出向量
            }
			for (j = 0; j < q ; j++)   //计算输出误差
                e += (y[i][j] - O2[j]) * (y[i][j] - O2[j]);

            for (j = 0; j < q; j++)    //计算输出层的权修改量    
                ChgO[j] = O2[j] * (1 - O2[j]) * (y[i][j] - O2[j]);
            
            for (j = 0; j < p; j++) {         //计算隐层权修改量
                temp = 0;
                for (k = 0; k < q; k++)
                    temp = temp + w[j][k] * ChgO[k];
                ChgH[j] = temp * O1[j] * (1 - O1[j]);
            }
            for (j = 0; j < p; j++)           //修改输出层权矩阵
                for (k = 0; k < q; k++)
                    w[j][k] = w[j][k] + a * O1[j] * ChgO[k]; 
            for (j = 0; j < n; j++)
                for (k = 0; k < p; k++)
                    v[j][k] = v[j][k] + a * x[i][j] * ChgH[k]; 
        }
        if (nn % 10000 == 0)
           cout<<"误差 : "<<e<<endl;
    }
    cout<<"总共循环次数："<<nn<<endl;
    cout<<"调整后的隐层权矩阵"<<endl;
    for (i = 0; i < n; i++) {    
        for (j = 0; j < p; j++)
            cout<<v[i][j]<<"\t";    
        cout<<endl;
    }
    cout<<"调整后的输出层权矩阵："<<endl;
    for (i = 0; i < p; i++) {
        for (j = 0; j < q; j++)
            cout<< w[i][j]<<"\t";    
        cout<<endl;
    }
    for (i = 0; i < n; i++)             //把结果复制回结构体 
        for (j = 0; j < p; j++)
            bp->wih[i][j] = v[i][j];
    for (i = 0; i < p; i++)
        for (j = 0; j < q; j++)
            bp->who[i][j] = w[i][j];
    cout<<"bp网络训练结束！"<<endl;
    return 1;
}

int UseBp(annbp *bp) {    //使用bp网络
    float Input[n];
    double O1[p]; 
    double O2[q]; //O1为隐层输出,O2为输出层输出
    while (1) {           //持续执行，除非中断程序
        cout<<"请输入2个数："<<endl;
        int i, j;
        for (i = 0; i < n; i++)
            cin>>Input[i];
        double temp;
        for (i = 0; i < p; i++) {
            temp = 0;
            for (j = 0; j < n; j++)
                temp += Input[j] * bp->wih[j][i];
            O1[i] = f(temp);
        }
        for (i = 0; i < q; i++) {
            temp = 0;
            for (j = 0; j < p; j++)
                temp += O1[j] * bp->who[j][i];
            O2[i] = f(temp);
        }
        cout<<"结果："<<endl;
        for (i = 0; i < q; i++)
           cout<< O2[i]<<"\t";
        cout<<endl;
    }
    return 1;
}
void main()
{
   float x[m][n] = {
					{0.5,3.5}, 
					{1,3.5},
					{1.5,3.5},
					{2,3.5},
					{2.5,3.5},
					{0,3.5},
					{0,4},
					{0.5,4},
					{1,4},
					{1.5,4},
					{2,4},
					{0.3,5.5},
					{0,5},
					{0.5,5},
					{1,5},
					{0,6},
					{1,3.2},
					{2,3.2},
					{0.5,3.2},
					{2.5,3.4},
					{0,0},
					{1,0},
					{2,0},
					{3,0},
					{0.5,1},
					{1,1},
					{1.5,1},
					{2,1},
					{2.3,1},
					{0.5,2},
					{1,2},
					{1.5,2},
					{2,2},
					{2.5,2},
					{0.5,2.8},
					{2.6,1.5},
					{1,2.7},
					{1.5,2.6},
					{2.5,2.8},
					{0,2},
					{3.6,1},					
					{3.3,2},								
					{3.2,2.5},								
					{3.5,0.4},									
					{3.5,0.7},									
					{3.5,1.5},
					{3.5,2.1},
					{3.5,2.6},
					{3.5,1.2},
					{4,0.6},
					{4,0.9},
					{4,1.3},
					{4,2.1},
					{4,2.4},
					{3.7,1},
					{3.7,2},
					{4.3,1},
					{4.3,2},
					{4.3,1.5},
					{4.3,1.4}
 
   
   }; //训练样本
    int y[m][q] = {
					    {1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
						{1,0,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,1,0},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1},
					{0,0,1}
	
	};          //理想输出
    annbp *bp=new annbp;
    InitBp(bp);                    //初始化bp网络结构
    TrainBp(bp,x,y);             //训练bp神经网络
    UseBp(bp);                     //测试bp神经网络

}