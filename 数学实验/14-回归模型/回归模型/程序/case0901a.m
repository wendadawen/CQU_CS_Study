clear; clc;  % 不吸烟与吸烟孕妇的新生儿体重和怀孕期的参数估计和假设检验
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
        z0(k0)=M(i,6); % 不吸烟孕妇的体重
    else  if M(i,7)==1; % 吸烟状况,1~吸烟
        k1=k1+1;
        y1(k1)=M(i,1); % 吸烟孕妇的新生儿体重
        x1(k1)=M(i,2); % 吸烟孕妇的怀孕期
        z1(k1)=M(i,6); % 吸烟孕妇的体重
       end
    end
end 

% 估计、检验不吸烟与吸烟孕妇的新生儿体重
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
k0, % 不吸烟孕妇数量
k1, % 吸烟孕妇数量
[y0m,s0,y0c]=normfit(y0),  % 估计不吸烟孕妇新生儿体重的均值y0m，标准差s0和均值的置信区间y0c
[y1m,s1,y1c]=normfit(y1),  % 估计吸烟孕妇新生儿体重的均值y1m，标准差s1和均值的置信区间y1c
[yh,pyh]=ttest2(y0,y1), % 检验 H0:y0m=y1m
[yhh,pyhh]=ttest2(y0,y1,0.05,-1),% 检验 H0:y0m>y1m
pause
% 估计、检验不吸烟与吸烟孕妇的新生儿体重低（小于2500克=88.2盎司）的比例
n01=0;n02=0;
for i=1:k0
    if y0(i)<88.2; % 不吸烟孕妇的新生儿体重低
        n01=n01+1;
    else if y0(i)<999; % 不吸烟孕妇的新生儿体重数据不缺失
            n02=n02+1;
        end
    end
end
n0=n01+n02,
q0=n01/n0, % 估计不吸烟孕妇的新生儿体重低的比例
n11=0;n12=0;
for i=1:k1
    if y1(i)<88.2; % 吸烟孕妇的新生儿体重低
        n11=n11+1;
    else if y1(i)<999; % 吸烟孕妇的新生儿体重数据不缺失
          n12=n12+1;
      end
    end
end
n1=n11+n12,
q1=n11/n1, % 估计吸烟孕妇的新生儿体重低的比例
qs=[q0*(1-q0)*(n0-1)+q1*(1-q1)*(n1-1)]/(n1+n0-2)*(1/n1+1/n0);
qt=(q1-q0)/sqrt(qs), % 两个0-1分布总体均值的检验 H0:q0=q1
pause
% 估计、检验不吸烟与吸烟孕妇的怀孕期
j0=0;
for i=1:k0
    if x0(i)<999; % 不吸烟孕妇的怀孕期数据不缺失
        j0=j0+1;
        xx0(j0)=x0(i);
    end
end
j1=0;
for i=1:k1
    if x1(i)<999; % 吸烟孕妇的怀孕期数据不缺失
        j1=j1+1;
        xx1(j1)=x1(i);
    end
end
j0,j1,size(xx0)
[x0m,sx0,x0c]=normfit(xx0), % 估计不吸烟孕妇怀孕期的均值x0m,标准差sx0和均值的置信区间x0c
[x1m,sx1,x1c]=normfit(xx1), % 估计吸烟孕妇怀孕期的均值x1m,标准差sx1和均值的置信区间x1c
[xh,pxh]=ttest2(xx0,xx1), % 检验 H0:x0m=x1m
[xhh,pxhh]=ttest2(xx0,xx1,0.05,-1),% 检验 H0:x0m>x1m
pause
% 估计、检验不吸烟与吸烟孕妇早产（怀孕期小于37周）的比例
m01=0;
for i=1:j0
    if xx0(i)<259; % 不吸烟孕妇怀孕期小于37周
        m01=m01+1;
    end
end
r0=m01/j0, % 估计不吸烟孕妇怀孕期小于37周的比例
m11=0;
for i=1:j1
    if xx1(i)<259; % 吸烟孕妇怀孕期小于37周
        m11=m11+1;
    end
end
r1=m11/j1,  % 估计吸烟孕妇怀孕期小于37周的比例
rs=[r0*(1-r0)*(j0-1)+r1*(1-r1)*(j1-1)]/(j1+j0-2)*(1/j1+1/j0);
rt=(r1-r0)/sqrt(rs), % 两个0-1分布总体均值的检验 H0:r0=r1
