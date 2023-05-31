% 9.2½Ú£»Êä³ö±í5¡¢Í¼5¡¢Í¼6
clc; clear all
M=dlmread('case0902data.m');
M=[M(1:32,:);M(34:46,:)];
y=M(:,2);
x1=M(:,3);
x2=M(:,4);
x3=M(:,6);
x4=M(:,7);
x5=x2.*x3;
x6=x2.*x4;
n=length(y);
x=[ones(n,1) x1 x2 x3 x4 x5 x6];
[b,bi,r,ri,s]=regress(y,x);
s2=sum(r.^2)/(n-7);
b,bi,s,s2
figure(1)
plot(x1,r,'+'),
figure(2)
xx=M(:,8);
plot(xx,r,'+')