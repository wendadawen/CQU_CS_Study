%9.7节 考试成绩原始程序（注释）
clc; clear all

[CJ,textdata]=xlsread('case0907data.xlsx'); %读取Excel数据
X=CJ(:,1:end);    %读取成绩数据
M=mean(X);        %计算均值向量
Co=cov(X);    %计算协方差矩阵
r=corrcoef(X);  %计算相关系数矩阵
[COEFF,SCORE,latent,tsquare]=princomp(X)    %主成分分析
percent_explained = 100*latent/sum(latent)  %计算主成分解释比例

figure(2);
pareto(percent_explained)     %画图2
xlabel('主成分')
ylabel('方差解释 (%)')
result(1,:)={'特征值','贡献率','累积贡献率'};
result(2:7,1)=num2cell(latent)
result(2:7,2:3)=num2cell([percent_explained,cumsum(percent_explained)]); %输出表2
stnum=textdata(2:end,1) %提取学生编号
sumX=sum(X,2) %计算总分
result1=cell(53,4)
result1(1,:)={'学生序号','总分','第一主成分得分y1','第二主成分得分y2'}
result1(2:end,1)=stnum
result1(2:end,2:end)=num2cell([sumX,SCORE(:,1:2)]) %输出表3

figure(3); %前2个主成分的得分散点图3
plot(SCORE(:,1),SCORE(:,2),'ko')
xlabel('第一主成分')
ylabel('第二主成分')
gname(stnum)   %交互式标注学生序号

[v,e]=eig(r)   % 相关系数矩阵的特征根与特征向量
[lambda,psi,T,stats,F] = factoran(X,2)  %因子分析m=2
result0=num2cell([lambda,psi])
head={'变量','因子f1','因子f2','特殊方差'}
varname={'数学分析','高等代数','概率论','微分几何','抽象代数','数值分析'}' 
result2=[head;varname,result0]   %输出表4
result3=cell(53,4)
result3(1,:)={'学生序号','总分','因子f1得分','因子f2得分'}
result3(2:end,1)=stnum
result1(2:end,2:end)=num2cell([sumX,F(:,1:2)])  %输出表5

figure(4);%画因子得分散点图4
plot(F(:,1),F(:,2),'ro')  
xlabel('基础课因子得分')
ylabel('开闭卷因子得分')
gname(stnum)   %交互式标注学生序号
Fy=(3.7099*F(:,1)+1.2604*F(:,2))/4.9703  %计算表6中因子综合得分
