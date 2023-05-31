% 9.4�ڣ�Ͷ�ʶ���������ֵ�����ָ����ģ��
clear all; clc;  
y=[90.9 97.4 113.5 125.7 122.8 133.3 149.3 144.2 166.4 195.0 229.8 228.7 206.1 257.9 324.1 386.6 423.0 401.9 474.9 424.5]';
x1=[596.7 637.7 691.1 756.0 799.0 873.4 944.0 992.7 1077.6 1185.9 1326.4 1434.2 1549.2 1718.0 1918.3 2163.9 2417.8 2631.7 2954.7 3073.0]';
x2=[0.7167 0.7277 0.7436 0.7676 0.7906 0.8254 0.8679 0.9145 0.9601 1.0000 1.0575 1.1508 1.2579 1.3234 1.4005 1.5042 1.6342 1.7842 1.9514 2.0688]';
figure(1); %��ͼ1
plot(x1,y,'o')

figure(2); %��ͼ2
plot(x2,y,'o')
X=[ones(20,1),x1,x2];
[b1,bint,r,rint,stats]=regress(y,X);    
b1,bint,stats                           %ģ�ͣ�1���Ľ������2��
[1:20;r']'                              %ģ�ͣ�2���Ĳв��3��
x=[x1 x2];
rstool(x,y)    %��ͼ3

figure(4);       %��ͼ4              
e1=r(1:19);
e2=r(2:20);
fplot(@(x)(0*x),[-30,20]),hold on;
plot(zeros(51,1),-30:20),hold on;
plot(e1,e2,'+'),hold off
axis([-30 20 -30 20])

          
D=(diff(r)'*diff(r))./(e2'*e2)            %����ʽ��4��
rho=1-D./2
ym=y(2:20);
yn=y(1:19);
x1m=x1(2:20);
x1n=x1(1:19);
x2m=x2(2:20);
x2n=x2(1:19);
ystar=ym-rho*yn;
x1star=x1m-rho*x1n;
x2star=x2m-rho*x2n;
Xstar=[ones(19,1),x1star,x2star];
[b2,bint,r,rint,stats]=regress(ystar,Xstar);  
b2,bint,stats                       % ģ�ͣ�9���Ľ������4��
yh=b1(1)+b1(2)*x1+b1(3)*x2;
yh10=b2(1)+rho*yn+b2(2)*x1m-b2(2)*rho*x1n+b2(3)*x2m-b2(3)*rho*x2n;
yh2=yh(2:20);

figure(6);     %��ͼ6
plot(ym,'o') 
hold on
plot(yh2,'+')
hold on
plot(yh10,'*')
hold off,
          
figure(7);     %��ͼ7
eh2=ym-yh2;
eh10=ym-yh10;
fplot(@(x)(0*x),[0,20]),hold on;
plot(eh2,'+'),hold on
plot(eh10,'*'),hold off             
[2:20;yh10';yh2';eh10';eh2']'          % ģ�ͣ�2��,(10���Ľ������5��
