clc; clear ;
% 拟合高度（h）与冠幅(p)
% 拟合函数 p = a + bh
h = [5, 10, 15, 20, 25]'; % 高度(m)
p = [2.8, 5.5, 8.5, 11.9, 14.5]'; % 冠幅(m)

X = [ones(size(h)) h] ;
[b,bint,r,rint,stats] = regress(p,X) ;

hi = 0:0.1:25; % 拟合区间，这里设置为0到25，步长为0.1
pi = [ones(size(hi')) hi'] * b ;

figure ;
plot(h,p,'+',hi,pi); % 绘制原始数据散点图和拟合曲线
legend('原始数据','拟合数据');
title('拟合下的h-p曲线');
xlabel('h/m'),ylabel('p/m') ;