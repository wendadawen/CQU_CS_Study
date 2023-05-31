clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%—∞’“◊Ó÷’aa
r=25;
ki=0.5;
b=60;
h=50;
nnn=20;
a=2*r/nnn;
e=ki*b;
for n=1:10
    if n==1
    s(n)=(r^2-(r-a*n)^2)^.5/2;
    else
        s(n)=(r^2-(r-a*n)^2)^.5/2+s(n-1)/2;
    end
end 

aa=acos(h/(b-s(1)));
l=b-s(1);
for n=1:10
        bb(n)=-atan(tan(aa)-(s(n)-s(1))/(l/2*cos(aa)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
r2=e-s(1);

for n=1:nnn/2
    if bb(n)<0
        bbb=0;
    else
        bbb=bb(n);
    end
r1=e-s(n);
x(n)=(cos(bbb)*(r2-r1)/r2*cos(pi/2-bbb)+(1-(cos(bbb)*(r2-r1)/r2)^2)^.5*sin(pi/2-bbb))*r2/cos(bbb)-r1;
end
x