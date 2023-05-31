

clear all
clc
clf

h=45;
r=30;
nnn=18;
ki=0.55;
b=55;
a=2*r/nnn;
e=ki*b;
%%%%%%%%%%%%%%%%%Ä©¶ËÇúÏß

for n=1:nnn/2
    if n==1
    x(n)=(r^2-(r-a*n)^2)^.5/2;
    else
        x(n)=(r^2-(r-a*n)^2)^.5/2+x(n-1)/2;
    end
    y(n)=a/2+(nnn/2-n)*a;
end
for aa=pi/2:(acos(h/(b-x(1)))-pi/2)/7:acos(h/(b-x(1)))  %%%%%%
    clf
    
l=b-x(1);
for n=1:nnn/2
        bb(n)=-atan(tan(aa)-(x(n)-x(1))/(l/2*cos(aa)));
        bb
end
for ii=1:nnn/2
    yy(ii)=y(ii);
    
     if bb(ii)>0
        xx(ii)=abs((b-x(ii))*sin(bb(ii)))-x(ii);
        xxx=-xx(ii);
        xx(ii)=-xx(ii);
    else
        xx(ii)=abs((b-x(ii))*sin(bb(ii)))+x(ii);
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
    
axis([-b-10 b+10 -b-10 b+10 -h-10 10])

for sita=0:pi/30:2*pi
    plot3(r*cos(sita),r*sin(sita),0,'m*')
    hold on
    end
    plot3(xx(jj),yy(jj),zz(jj),'r*')
    line([xx(jj),x(jj)],[yy(jj),y(jj)],[zz(jj),0],'color','b')
    hold on
    plot3(-1.*xx(jj),yy(jj),zz(jj),'r*')
    line([-1.*xx(jj),-1.*x(jj)],[yy(jj),y(jj)],[zz(jj),0],'color','g')
    hold on
 line([-1*(b-abs(x(1)))*sin(bb(1))*ki+x(1),-1*(b-abs(x(1)))*sin(bb(1))*ki+x(1)],[r,-r],[-(b-abs(x(1)))*cos(bb(1))*ki,-(b-abs(x(1)))*cos(bb(1))*ki],'color','r')
    hold on
    line([(b-abs(x(1)))*sin(bb(1))*ki-x(1),(b-abs(x(1)))*sin(bb(1))*ki-x(1)],[r,-r],[-(b-abs(x(1)))*cos(bb(1))*ki,-(b-abs(x(1)))*cos(bb(1))*ki],'color','r')

     hold on
    line([-1.*x(jj),1.*x(jj)],[y(jj),y(jj)],[0,0],'color','m')
     hold on
end
pause(0.08)%keyboard
end




r2=e-x(1);
for n=1:nnn/2
    if bb(n)<0
        bbb=0;
    else
        bbb=bb(n);
    end
r1=e-x(n);
xp(n)=(cos(bbb)*(r2-r1)/r2*cos(pi/2-bbb)+(1-(cos(bbb)*(r2-r1)/r2)^2)^.5*sin(pi/2-bbb))*r2/cos(bbb)-r1;
end
x
xp
