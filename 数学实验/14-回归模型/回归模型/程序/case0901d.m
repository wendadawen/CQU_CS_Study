
clear
M1=dlmread('case0901data.m');  % ���ļ�smokedata.m��������
for j=1:7
    M(:,j)=M1(j:7:8652);  % ������ת���ɾ�����ʽ
end
k=0;
for i=1:1236
    if (M(i,1)<999)&(M(i,2)<999)&(M(i,7)<9); 
        k=k+1;
        y(k)=M(i,1);  % ����������
        x1(k)=M(i,2); % �и�������
        x2(k)=M(i,7); % �и�����״��
    end
end
k,
% ���������غ��и������ڡ�����״���Ļع�ģ��
X1=[ones(k,1),x1',x2']; % ����1���Ա�����ɵľ���
%X1=[ones(k,1),x1',x2',x1'.*x2']; % ����x1*x2��
[b1,bint1,r1,rint1,s1]=regress(y',X1); % ���Իع� 
b1,bint1,s1
pause
% ȥ���쳣���ݣ��в��������䲻����㣩�����ع�
n1=k;
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
        x1(i)=0; x2(i)=0;y(i)=0;% �쳣��������
        k=k+1;
    end 
if k>r0
break     
end
end
nn1=0; 
for i=1:n1
    if x1(i)>0;% ���쳣����
        nn1=nn1+1;
        yn1(nn1)=y(i);
        xn1(nn1)=x1(i); 
        xn2(nn1)=x2(i);  
       end
    end
nn1
XX1=[ones(nn1,1),xn1',xn2']; % ����1���Ա�����ɵľ���
%XX1=[ones(nn1,1),xn1',xn2',xn1'.*xn2']; % ����x1*x2��
[bb1,bbint1,rr1,rrint1,ss1]=regress(yn1',XX1); % ���Իع� 
bb1,bbint1,ss1

