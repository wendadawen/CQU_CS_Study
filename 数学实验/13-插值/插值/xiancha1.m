hours=1:12;
temps=[5 8 9 15 25 29 31 30 22 25 27 24];
h=1:.1:12;
t=interp1(hours,temps,h)
plot(hours,temps,'+',h,t)
title('线性插值下的温度曲线'),
xlabel('Hour'),ylabel('Degrees Celsius')
