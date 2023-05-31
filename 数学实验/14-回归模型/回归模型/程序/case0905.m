% 9.5��
clc; clear all;

% ����  100�����۲���
%  100�����۲�������
x=[20,23,24,25,25,26,26,28,28,29,30,30,30,30,30,30,32,32,33,33,34,34,34,34,34,35,35,36,36,36,37,37,37,38,38,39,39,40,40,41,41,42,42,42,42,43,43,43,44,44,44,44,45,45,46,46,47,47,47,48,48,48,49,49,49,50,50,51,52,52,53,53,54,55,55,55,56,56,56,57,57,57,57,57,57,58,58,58,59,59,60,60,61,62,62,63,64,64,65,69]'; 
%  100�����۲��߹��Ĳ�״̬
y=[0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,1,0,0,1,1,0,1,0,1,0,0,1,0,1,1,0,0,1,0,1,0,0,1,1,1,1,0,1,1,1,1,1,0,0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,1]';

figure(1);% ��ͼ1
plot(x,y,'o'),xlabel('Age'),ylabel('CHD')  

figure(2);% ��ͼ2
Age= [24.5 32 37 42 47 52 57 64.5]';
Chd = [1 2 3 5 6 5 13 8]';
Total = [10 15 12 15 13 8 17 10]';  % ��2����
proportion = Chd ./ Total;
plot(Age,proportion,'o')      % ��ͼ2
xlabel('Age'); ylabel('Proportion of CHD')

figure(3);% ��ͼ3
linearCoef = polyfit(Age, proportion,1);
linearFit = polyval(linearCoef,Age);
plot(Age, proportion,'o',Age,linearFit,'r-',[20 70],[0 0],'k:',[20 70],[1 1],'k:');
xlabel('Age'); ylabel('Proportion of CHD')  % ��ͼ3

figure(4);% ��ͼ4
[cubicCoef,stats,ctr] = polyfit(Age,proportion,3);
cubicFit = polyval(cubicCoef,Age,[],ctr);
plot(Age,proportion,'o', Age,cubicFit,'r-', [20 70],[0 0],'k:', [20 70],[1 1],'k:'),
xlabel('Age'); ylabel('Proportion of CHD')  % ��ͼ4

figure(5);% ��ͼ5
[logitCoef,dev,stats] = glmfit(Age,[Chd Total],'binomial','logit');  % logit ģ�����
logitCoef 
stats.se               
logitFit = glmval(logitCoef,Age,'logit')
plot(Age,proportion,'o', Age,logitFit,'r-');
xlabel('Age'); ylabel('Proportion of CHD')   % ��ͼ5

figure(6);% ��ͼ6
[logitCoef,dev,stats] = glmfit(Age,[Chd Total],'binomial','logit');
[logFit,dylo,dyhi]=glmval(logitCoef,Age,'logit',stats);
logFit, D=[logFit-dylo,logFit+dyhi]   % ��3���    
[logitCoef2,dev2,stats2] = glmfit([Age Age.^2],[Chd Total],'binomial','logit');   
% logit ģ����⣨��x^2��
logitCoef2,  stats2.p
[probitCoef,devp,statsp] = glmfit(Age,[Chd Total],'binomial','probit');  % probit ģ�����
probitCoef,   statsp.se 
[probitFit,dylop,dyhip] = glmval(probitCoef,Age,'probit',statsp);
probitFit, Dp=[probitFit-dylop,probitFit+dyhip]    % ��3���  
plot(Age,proportion,'o', Age,logitFit,'r-', Age,probitFit,'g--*'), xlabel('Age'); ylabel('Proportion of CHD'),
legend('Data','Logit model','Probit model','Location','northwest')  % ��ͼ6

figure(7);% ��ͼ7
pred =20:10:80; 
[ChdPred,dl1,dh1] = glmval(logitCoef,pred,'logit',stats);
errorbar(pred,ChdPred,dl1,dh1,':')   % ��ͼ7
