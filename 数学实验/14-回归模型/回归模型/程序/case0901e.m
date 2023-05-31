clear all; clc
M1=dlmread('case0901data.m');  % 从文件smokedata.m读出数据
for j=1:7
    M(:,j)=M1(j:7:8652);  % 将数据转换成矩阵形式
end
k=0;
for i=1:1236
    if (M(i,1)<999)&(M(i,2)<999)&(M(i,3)<9)&(M(i,4)<99)&(M(i,5)<99)&(M(i,6)<999)&(M(i,7)<9); 
        k=k+1;
        y(k)=M(i,1);  % 新生儿体重
        x1(k)=M(i,2); % 孕妇怀孕期
        x2(k)=M(i,3); % 孕妇胎次状况
        x3(k)=M(i,4); % 孕妇年龄
        x4(k)=M(i,5); % 孕妇身高
        x5(k)=M(i,6); % 孕妇体重
        x6(k)=M(i,7); % 孕妇吸烟状况
    end
end
k,
x=[x1;x2;x3;x4;x5;x6]';
stepwise(x,y',[1,6]) % 逐步回归（以x1，x6为初始子集）
R=corrcoef([y',x]) % y与x的相关系数矩阵
