
clear
M1=dlmread('case0901data.m');  % 从文件smokedata.m读出数据
for j=1:7
    M(:,j)=M1(j:7:8652);  % 将数据转换成矩阵形式
end
k=0;
for i=1:1236
    if (M(i,1)<999)&(M(i,2)<999)&(M(i,7)<9); 
        k=k+1;
        y(k)=M(i,1);  % 新生儿体重
        x1(k)=M(i,2); % 孕妇怀孕期
        x2(k)=M(i,7); % 孕妇吸烟状况
    end
end
k,
% 新生儿体重和孕妇怀孕期、吸烟状况的回归模型
X1=[ones(k,1),x1',x2']; % 构造1与自变量组成的矩阵
%X1=[ones(k,1),x1',x2',x1'.*x2']; % 增加x1*x2项
[b1,bint1,r1,rint1,s1]=regress(y',X1); % 线性回归 
b1,bint1,s1
pause
% 去除异常数据（残差置信区间不含零点）再做回归
n1=k;
r0=0;
for n=1:n1
    if rint1(n,1)*rint1(n,2)>0 % 判断异常数据
        r0=r0+1;
        rr(r0)=n; % 异常数据的编号
    end
end
k=1;
for i=1:n1
    if i==rr(k)
        x1(i)=0; x2(i)=0;y(i)=0;% 异常数据置零
        k=k+1;
    end 
if k>r0
break     
end
end
nn1=0; 
for i=1:n1
    if x1(i)>0;% 非异常数据
        nn1=nn1+1;
        yn1(nn1)=y(i);
        xn1(nn1)=x1(i); 
        xn2(nn1)=x2(i);  
       end
    end
nn1
XX1=[ones(nn1,1),xn1',xn2']; % 构造1与自变量组成的矩阵
%XX1=[ones(nn1,1),xn1',xn2',xn1'.*xn2']; % 增加x1*x2项
[bb1,bbint1,rr1,rrint1,ss1]=regress(yn1',XX1); % 线性回归 
bb1,bbint1,ss1

