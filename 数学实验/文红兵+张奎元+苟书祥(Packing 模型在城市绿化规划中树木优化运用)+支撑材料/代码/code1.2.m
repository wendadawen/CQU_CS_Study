clc; clear ;
% 拟合高度（h）与冠幅(p)
% 拟合函数 p = a + bh
h = [5, 10, 15, 20, 25]'; % 高度(m)
p = [2.8, 5.5, 8.5, 11.9, 14.5]'; % 冠幅(m)

X = [ones(size(h)) h] ;
[b,bint,r,rint,stats] = regress(p,X) ;

figure ;
rcoplot(r,rint) ; % 残差图