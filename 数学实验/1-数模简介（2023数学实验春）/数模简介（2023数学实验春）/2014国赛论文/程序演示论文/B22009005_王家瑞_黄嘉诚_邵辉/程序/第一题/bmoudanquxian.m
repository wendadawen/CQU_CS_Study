
%%%%%%%%%%%%%%%%%Ä©¶ËÇúÏß
r=25;
ki=0.5;
b=60;
h=50;
nnn=20;
a=2*r/nnn;
e=ki*b;
for n=1:nnn/2
    if n==1
    x(n)=(r^2-(r-a*n)^2)^.5/2;
    else
        x(n)=(r^2-(r-a*n)^2)^.5/2+x(n-1)/2;
    end
    y(n)=a/2+(nnn/2-n)*a;
end

 aa=      acos(h/(b-x(1))) ;  %pi/2:-0.01:acos(50/(60-x(1)))%%%%%%
l=60-x(1);
for n=1:nnn/2
        bb(n)=-atan(tan(aa)-(x(n)-x(1))/(l/2*cos(aa)));
end
for ii=1:nnn/2
    yy(ii)=y(ii);
    
    if bb(ii)>0
        xx(ii)=abs((60-x(ii))*sin(bb(ii)))-x(ii);
        xxx=-xx(ii);
        xx(ii)=-xx(ii);
    else
        xx(ii)=abs((60-x(ii))*sin(bb(ii)))+x(ii);
        xxx=xx(ii);
    end
    
    zz(ii)=-(-2*b*(r^2-yy(ii)^2)^(1/2)-xxx^2+2*xxx*(r^2-yy(ii)^2)^(1/2)+b^2)^(1/2);
end
for ii=nnn/2+1:nnn
    yy(ii)=-yy(nnn+1-ii);
    zz(ii)=zz(nnn+1-ii);
    xx(ii)=xx(nnn+1-ii);
    x(ii)=x(nnn+1-ii);
     y(ii)=-y(nnn+1-ii);
end

for jj=1:nnn
    plot3(xx(jj),yy(jj),zz(jj),'r*')
        plot3(-1.*xx(jj),yy(jj),zz(jj),'r*')
    hold on
end
hold on