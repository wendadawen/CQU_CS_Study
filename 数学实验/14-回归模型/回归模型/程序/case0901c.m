clear all; clc
M1=dlmread('case0901data.m');  % 从文件smokedata.m读出数据
for j=1:7
    M(:,j)=M1(j:7:8652);  % 将数据转换成矩阵形式
end
k0=0;k1=0; 
for i=1:1236
    if M(i,7)==0; % 吸烟状况,0~不吸烟
        k0=k0+1;
        y0(k0)=M(i,1); % 不吸烟孕妇的新生儿体重
        x0(k0)=M(i,2); % 不吸烟孕妇的怀孕期
    else  if M(i,7)==1; % 吸烟状况,1~吸烟
        k1=k1+1;
        y1(k1)=M(i,1); % 吸烟孕妇的新生儿体重
        x1(k1)=M(i,2); % 吸烟孕妇的怀孕期
       end
    end
end
k0,k1
% 不吸烟孕妇的新生儿体重和怀孕期的回归模型
n0=0; 
for i=1:k0
    if (y0(i)<999)&(x0(i)<999);% 不吸烟孕妇的新生儿体重和怀孕期数据不缺失
        n0=n0+1;
        yn0(n0)=y0(i);
        xn0(n0)=x0(i); 
       end
    end
n0
X0=[ones(n0,1),xn0']; % 构造1与自变量组成的矩阵
[b0,bint0,r0,rint0,s0]=regress(yn0',X0); % 线性回归 
b0,bint0,s0
rcoplot(r0,rint0) % 残差及其置信区间图形
pause
b=polyfit(xn0,yn0,1) % 用拟合计算系数，与b1比较
x=140:360;
y=polyval(b,x);
plot(xn0,yn0,'+',x,y,'b')
pause
% 去除异常数据（残差置信区间不含零点）再做回归
p0=0;
for n=1:n0
    if rint0(n,1)*rint0(n,2)>0 % 判断异常数据
        p0=p0+1;
        pp(p0)=n; % 异常数据的编号
    end
end
k=1;
for i=1:n0
    if i==pp(k)
        xn0(i)=0; yn0(i)=0;% 异常数据置零
        k=k+1;
    end 
if k>p0
break     
end
end
nn0=0; 
for i=1:n0
    if xn0(i)>0;% 非异常数据
        nn0=nn0+1;
        ynn0(nn0)=yn0(i);
        xnn0(nn0)=xn0(i); 
       end
    end
nn0
XX0=[ones(nn0,1),xnn0']; % 构造1与自变量组成的矩阵
[bb0,bbint0,rr0,rrint0,ss0]=regress(ynn0',XX0); % 线性回归 
bb0,bbint0,ss0
