% 9.3�ڣ� ø�ٷ�Ӧ�������2��3��ͼ1-6
clc; clear all
format long;
x=[0.02 0.02 0.06 0.06 0.11 0.11 0.22 0.22 0.56 0.56 1.1 1.1]';
y=[76 47 97 107 123 139 159 152 191 201 207 200]'; % ������
x1=[0.02 0.02 0.06 0.06 0.11 0.11 0.22 0.22 0.56 0.56 1.1]';
y1=[67 51 84 86 98 115 131 124 144 158 160]';  % δ������

figure(1);
plot(x,y,'o')              % ��ͼ1��������
axis([0 1.4 40 220]);

figure(2);
plot(x1,y1,'+')           % ��ͼ2��δ������

figure(3);    
X=[ones(12,1) 1./x];
[b,bint,r,rint,stats]=regress(1./y,X);  % ����ģ�͵Ľ������2��
b,bint,stats
z=b(1)+b(2)*1./x;
plot(1./x,1./y,'o',1./x,z,'r-')
axis([0 60 0 0.025]);       % ��ͼ3

figure(4);  
a1=1/b(1);a2=b(2)/b(1);   %����beta1,beta2
xx=0:0.01:1.1;
z1=a1*xx./(a2+xx);
plot(xx,z1),hold on;
plot(x,y,'o'),hold off;    
axis([0 1.1 0 250])        % ��ͼ4

figure(5);
beta0=[a1,a2];         % ����ֵ
[beta,R,J]=nlinfit(x,y,'case0903a1',beta0);% ���������
betaci=nlparci(beta,R,J);
beta,betaci              % ������ģ��1�Ľ������3��
%r0=R                   % ����в�
yy=beta(1)*x./(beta(2)+x);
plot(x,y,'o',x,yy,'*'),  %��ͼ5

nlintool(x,y,'case0903a1',beta)  %��ͼ6
