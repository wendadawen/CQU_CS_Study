clear all; clc
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
% �������и������������غͻ����ڵĻع�ģ��
n0=0; 
for i=1:k0
    if (y0(i)<999)&(x0(i)<999);% �������и������������غͻ��������ݲ�ȱʧ
        n0=n0+1;
        yn0(n0)=y0(i);
        xn0(n0)=x0(i); 
       end
    end
n0
X0=[ones(n0,1),xn0']; % ����1���Ա�����ɵľ���
[b0,bint0,r0,rint0,s0]=regress(yn0',X0); % ���Իع� 
b0,bint0,s0
rcoplot(r0,rint0) % �в����������ͼ��
pause
b=polyfit(xn0,yn0,1) % ����ϼ���ϵ������b1�Ƚ�
x=140:360;
y=polyval(b,x);
plot(xn0,yn0,'+',x,y,'b')
pause
% ȥ���쳣���ݣ��в��������䲻����㣩�����ع�
p0=0;
for n=1:n0
    if rint0(n,1)*rint0(n,2)>0 % �ж��쳣����
        p0=p0+1;
        pp(p0)=n; % �쳣���ݵı��
    end
end
k=1;
for i=1:n0
    if i==pp(k)
        xn0(i)=0; yn0(i)=0;% �쳣��������
        k=k+1;
    end 
if k>p0
break     
end
end
nn0=0; 
for i=1:n0
    if xn0(i)>0;% ���쳣����
        nn0=nn0+1;
        ynn0(nn0)=yn0(i);
        xnn0(nn0)=xn0(i); 
       end
    end
nn0
XX0=[ones(nn0,1),xnn0']; % ����1���Ա�����ɵľ���
[bb0,bbint0,rr0,rrint0,ss0]=regress(ynn0',XX0); % ���Իع� 
bb0,bbint0,ss0
