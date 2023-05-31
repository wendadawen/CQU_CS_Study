% 9.3节； 酶促反应：输出表2表3；图1-6
clc; clear all
format long;
x=[0.02 0.02 0.06 0.06 0.11 0.11 0.22 0.22 0.56 0.56 1.1 1.1]';
y=[76 47 97 107 123 139 159 152 191 201 207 200]'; % 经处理
x1=[0.02 0.02 0.06 0.06 0.11 0.11 0.22 0.22 0.56 0.56 1.1]';
y1=[67 51 84 86 98 115 131 124 144 158 160]';  % 未经处理

figure(1);
plot(x,y,'o')              % 画图1（经处理）
axis([0 1.4 40 220]);

figure(2);
plot(x1,y1,'+')           % 画图2（未经处理）

figure(3);    
X=[ones(12,1) 1./x];
[b,bint,r,rint,stats]=regress(1./y,X);  % 线性模型的结果（表2）
b,bint,stats
z=b(1)+b(2)*1./x;
plot(1./x,1./y,'o',1./x,z,'r-')
axis([0 60 0 0.025]);       % 画图3

figure(4);  
a1=1/b(1);a2=b(2)/b(1);   %计算beta1,beta2
xx=0:0.01:1.1;
z1=a1*xx./(a2+xx);
plot(xx,z1),hold on;
plot(x,y,'o'),hold off;    
axis([0 1.1 0 250])        % 画图4

figure(5);
beta0=[a1,a2];         % 赋初值
[beta,R,J]=nlinfit(x,y,'case0903a1',beta0);% 非线性拟合
betaci=nlparci(beta,R,J);
beta,betaci              % 非线性模型1的结果（表3）
%r0=R                   % 输出残差
yy=beta(1)*x./(beta(2)+x);
plot(x,y,'o',x,yy,'*'),  %画图5

nlintool(x,y,'case0903a1',beta)  %画图6
