clear; clc;
M1=dlmread('case0901data.m');  % ���ļ�smokedata.m��������
for j=1:7
    M(:,j)=M1(j:7:8652);  % ������ת���ɾ�����ʽ
end
k0=0;k1=0; 
for i=1:1236
    if M(i,7)==0; % ����״��,0~������
        k0=k0+1;
        y0(k0)=M(i,1); % �������и�������������
        x0(k0)=M(i,2); % �������и��Ļ�����
    else  if M(i,7)==1; % ����״��,1~����
        k1=k1+1;
        y1(k1)=M(i,1); % �����и�������������
        x1(k1)=M(i,2); % �����и��Ļ�����
       end
    end
end
k0,k1
% �����и������������غͻ����ڵĻع�ģ��
n1=0; 
for i=1:k1
    if (y1(i)<999)&(x1(i)<999);% �����и������������غͻ��������ݲ�ȱʧ
        n1=n1+1;
        yn1(n1)=y1(i);
        xn1(n1)=x1(i); 
       end
    end
n1
X1=[ones(n1,1),xn1']; % ����1���Ա�����ɵľ���
[b1,bint1,r1,rint1,s1]=regress(yn1',X1); % ���Իع� 
b1,bint1,s1
figure(1);
rcoplot(r1,rint1) % �в����������ͼ��

b=polyfit(xn1,yn1,1) % ����ϼ���ϵ������b1�Ƚ�
x=220:340;
y=polyval(b,x);
figure(2);
plot(xn1,yn1,'+',x,y,'b')

% ȥ���쳣���ݣ��в��������䲻����㣩�����ع�
r0=0;
for n=1:n1
    if rint1(n,1)*rint1(n,2)>0 % �ж��쳣����
        r0=r0+1;
        rr(r0)=n; % �쳣���ݵı��
    end
end
k=1;
for i=1:n1
    if i==rr(k)
        xn1(i)=0; yn1(i)=0;% �쳣��������
        k=k+1;
    end 
if k>r0
break     
end
end
nn1=0; 
for i=1:n1
    if xn1(i)>0;% ���쳣����
        nn1=nn1+1;
        ynn1(nn1)=yn1(i);
        xnn1(nn1)=xn1(i); 
       end
    end
nn1
XX1=[ones(nn1,1),xnn1']; % ����1���Ա�����ɵľ���
[bb1,bbint1,rr1,rrint1,ss1]=regress(ynn1',XX1); % ���Իع� 
bb1,bbint1,ss1
