#include<iostream.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define n 2  //����ά��
#define p 12  //���㵥Ԫ��
#define q 3   //���ά�� 
#define m 60   //������kѭ��
struct annbp{
double x[n],       hi[p],       ho[p],          yi[q],         yo[q],         d[q];
//  �������� �������������� �������������  �������������   ������������  �����������
double wih[n][p],              who[p][q],                     bh[p],         b[q];
//�����������������Ȩֵ  ������������������Ȩֵ  ���������Ԫ����ֵ  ��������Ԫ����ֵ
int loopmax;//���ѭ������
double a;  //ѧϰ��
double e;//�������
};
double f(double x)
{
   return 1.0/(1.0+exp(-x));
} 
void InitBp(annbp *bp) { //��ʼ��bp����
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
//ѵ��bp���磬����Ϊx���������Ϊy
    double f1 = bp->e;                      //���Ȳ���
    double a = bp->a;                      //ѧϰ��
    double v[n][p], w[p][q]; //Ȩ����
    double ChgH[p], ChgO[q];         //�޸���
    double O1[p], O2[q];             //���������������
    int LoopCout = bp->loopmax;           //���ѭ������
    int i, j, k, nn;
    double temp;
    for (i = 0; i < n; i++)            // ���ƽṹ���е�Ȩ���� 
        for (j = 0; j < p; j++)
            v[i][j] = bp->wih[i][j];
    for (i = 0; i < p; i++)
        for (j = 0; j < q; j++)
            w[i][j] = bp->who[i][j];
    
    double e = f1 + 1;
    for (nn = 0; e > f1 && nn < LoopCout; nn++) //��ÿ������ѵ������
    {  
		e = 0;
        for(i=0;i<m;i++){ 
            for(k=0;k<p;k++)
			{          //���������������
                temp = 0;
                for (j=0;j<n;j++)
                    temp+=x[i][j]*v[j][k];    
                O1[k]=f(temp);//�����������
            }
            for (k = 0; k < q; k++) { //����������������
                temp = 0;
                for (j = 0; j < p; j++)
                    temp = temp + O1[j] * w[j][k];
                O2[k] = f(temp);//������������
            }
			for (j = 0; j < q ; j++)   //����������
                e += (y[i][j] - O2[j]) * (y[i][j] - O2[j]);

            for (j = 0; j < q; j++)    //����������Ȩ�޸���    
                ChgO[j] = O2[j] * (1 - O2[j]) * (y[i][j] - O2[j]);
            
            for (j = 0; j < p; j++) {         //��������Ȩ�޸���
                temp = 0;
                for (k = 0; k < q; k++)
                    temp = temp + w[j][k] * ChgO[k];
                ChgH[j] = temp * O1[j] * (1 - O1[j]);
            }
            for (j = 0; j < p; j++)           //�޸������Ȩ����
                for (k = 0; k < q; k++)
                    w[j][k] = w[j][k] + a * O1[j] * ChgO[k]; 
            for (j = 0; j < n; j++)
                for (k = 0; k < p; k++)
                    v[j][k] = v[j][k] + a * x[i][j] * ChgH[k]; 
        }
        if (nn % 10000 == 0)
           cout<<"��� : "<<e<<endl;
    }
    cout<<"�ܹ�ѭ��������"<<nn<<endl;
    cout<<"�����������Ȩ����"<<endl;
    for (i = 0; i < n; i++) {    
        for (j = 0; j < p; j++)
            cout<<v[i][j]<<"\t";    
        cout<<endl;
    }
    cout<<"������������Ȩ����"<<endl;
    for (i = 0; i < p; i++) {
        for (j = 0; j < q; j++)
            cout<< w[i][j]<<"\t";    
        cout<<endl;
    }
    for (i = 0; i < n; i++)             //�ѽ�����ƻؽṹ�� 
        for (j = 0; j < p; j++)
            bp->wih[i][j] = v[i][j];
    for (i = 0; i < p; i++)
        for (j = 0; j < q; j++)
            bp->who[i][j] = w[i][j];
    cout<<"bp����ѵ��������"<<endl;
    return 1;
}

int UseBp(annbp *bp) {    //ʹ��bp����
    float Input[n];
    double O1[p]; 
    double O2[q]; //O1Ϊ�������,O2Ϊ��������
    while (1) {           //����ִ�У������жϳ���
        cout<<"������2������"<<endl;
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
        cout<<"�����"<<endl;
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
 
   
   }; //ѵ������
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
	
	};          //�������
    annbp *bp=new annbp;
    InitBp(bp);                    //��ʼ��bp����ṹ
    TrainBp(bp,x,y);             //ѵ��bp������
    UseBp(bp);                     //����bp������

}