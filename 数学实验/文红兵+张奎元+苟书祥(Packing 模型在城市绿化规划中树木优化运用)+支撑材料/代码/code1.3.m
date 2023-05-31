%寻找最小树木占地半径的图像代码，求出的最小半径是2.5
clc ; clear all ;
L = 500 ;
W = 500 ;
figure ;
h = 1:0.1:10 ;
r = fun(h) ;
line = repmat(2.5,size(h,2), 1) ;
plt = plot(h,r, h, line, 'r') ;
axis([1 10 1 min(min(4,W/2),L/2)]) ;
xlabel("h/m") ;
ylabel("r/m") ;
title("r-h曲线") ;
set(plt(2),'Color',[1 0 0]);
datatip(plt(2),'DataIndex',80,'Location','northwest');

function r = fun(h)
    p = 0.596*h-0.3 ;
    A = pi * (p / 2).^2 ;
    S = max(10, A) ;
    r = sqrt(S / pi) ;
end