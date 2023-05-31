%9.7�� ���Գɼ�ԭʼ����ע�ͣ�
clc; clear all

[CJ,textdata]=xlsread('case0907data.xlsx'); %��ȡExcel����
X=CJ(:,1:end);    %��ȡ�ɼ�����
M=mean(X);        %�����ֵ����
Co=cov(X);    %����Э�������
r=corrcoef(X);  %�������ϵ������
[COEFF,SCORE,latent,tsquare]=princomp(X)    %���ɷַ���
percent_explained = 100*latent/sum(latent)  %�������ɷֽ��ͱ���

figure(2);
pareto(percent_explained)     %��ͼ2
xlabel('���ɷ�')
ylabel('������� (%)')
result(1,:)={'����ֵ','������','�ۻ�������'};
result(2:7,1)=num2cell(latent)
result(2:7,2:3)=num2cell([percent_explained,cumsum(percent_explained)]); %�����2
stnum=textdata(2:end,1) %��ȡѧ�����
sumX=sum(X,2) %�����ܷ�
result1=cell(53,4)
result1(1,:)={'ѧ�����','�ܷ�','��һ���ɷֵ÷�y1','�ڶ����ɷֵ÷�y2'}
result1(2:end,1)=stnum
result1(2:end,2:end)=num2cell([sumX,SCORE(:,1:2)]) %�����3

figure(3); %ǰ2�����ɷֵĵ÷�ɢ��ͼ3
plot(SCORE(:,1),SCORE(:,2),'ko')
xlabel('��һ���ɷ�')
ylabel('�ڶ����ɷ�')
gname(stnum)   %����ʽ��עѧ�����

[v,e]=eig(r)   % ���ϵ�����������������������
[lambda,psi,T,stats,F] = factoran(X,2)  %���ӷ���m=2
result0=num2cell([lambda,psi])
head={'����','����f1','����f2','���ⷽ��'}
varname={'��ѧ����','�ߵȴ���','������','΢�ּ���','�������','��ֵ����'}' 
result2=[head;varname,result0]   %�����4
result3=cell(53,4)
result3(1,:)={'ѧ�����','�ܷ�','����f1�÷�','����f2�÷�'}
result3(2:end,1)=stnum
result1(2:end,2:end)=num2cell([sumX,F(:,1:2)])  %�����5

figure(4);%�����ӵ÷�ɢ��ͼ4
plot(F(:,1),F(:,2),'ro')  
xlabel('���������ӵ÷�')
ylabel('���վ����ӵ÷�')
gname(stnum)   %����ʽ��עѧ�����
Fy=(3.7099*F(:,1)+1.2604*F(:,2))/4.9703  %�����6�������ۺϵ÷�
