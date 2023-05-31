% 9.3�ڣ� ø�ٷ�Ӧ�������4-6��ͼ7-10
clear all; clc;  % ø�ٻ�Ϸ�Ӧ
x11=[0.02 0.02 0.06 0.06 0.11 0.11 0.22 0.22 0.56 0.56 1.1];
x12=[0.02 0.02 0.06 0.06 0.11 0.11 0.22 0.22 0.56 0.56 1.1 1.1];
y1=[67 51 84 86 98 115 131 124 144 158 160];
y2=[76 47 97 107 123 139 159 152 191 201 207 200];
xx1=[x11 x12];
xx2=[zeros(1,11) ones(1,12)];
x=[xx1' xx2'];
y=[y1 y2]';
beta0=[170 0.05 60 0.01]'; 
[beta,R,J]=nlinfit(x,y,'case0903b1',beta0);
betaci=nlparci(beta,R,J);
beta,betaci               % ������ģ��4�Ľ������4��
r1=R;
%xx=0:0.01:1.1;
xx=xx1;
yhat=beta(1)*xx./(beta(2)+xx);
yhat1=((beta(1)+beta(3))*xx)./((beta(2)+beta(4))+xx);

figure(7); %��ͼ7
plot(xx1,y,'o',xx,yhat,'+',xx,yhat1,'+')
%gtext('����'),gtext('δ����')
axis([0 1.2 40 220]),

  
nlintool(x,y,'case0903b1',beta)   %��ͼ8
[ypre1,delta1]=nlpredci('case0903b1',x,beta,R,J);    %��������  
beta0=[170,0.05,60]';
[beta,R,J]=nlinfit(x,y,'case0903b2',beta0);
betaci=nlparci(beta,R,J);
beta,betaci           % ������ģ��5�Ľ������5��
r2=R;
yhat=beta(1)*xx./(beta(2)+xx);
yhat2=((beta(1)+beta(3))*xx)./(beta(2)+xx);

figure(9);
plot(xx1,y,'o',xx,yhat,'+',xx,yhat2,'+')
%gtext('����'),gtext('δ����')
axis([0 1.2 40 220])         %��ͼ9

nlintool(x,y,'case0903b2',beta)   %��ͼ10
[ypre2,delta2]=nlpredci('case0903b2',x,beta,R,J); 
[y1,y2;ypre1';delta1';ypre2';delta2']'  % ��6
