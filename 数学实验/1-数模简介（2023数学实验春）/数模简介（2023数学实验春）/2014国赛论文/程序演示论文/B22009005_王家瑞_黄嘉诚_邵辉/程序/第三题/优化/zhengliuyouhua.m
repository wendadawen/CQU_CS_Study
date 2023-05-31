clear all
clc
%%%%%%%%%%%%%%%%%   末端曲线
h=70;   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%     待定
r=40; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%     待定

n0=15;%%%%%%%%%%%%%根数
np=30;

ki0=0.3;%%%%%%%%%%%%%%%%钢条所占比例
kip=0.8;

b0=50;%%%%%%%%%%%%%%%%%木板长度的一半
bp=150;

m=1; 
for nnn=n0:np  
p=1; 
for ki=ki0:0.01:kip  
q=1;
for b=b0:bp
e=ki*b;
a=2*r/nnn;
for i=1:nnn/2%%%%%%%%%%%  求x、y表达式
        x(i)=r/nnn*i+r/2;
    
    y(i)=a/2+(10-i)*a;
end
aa=acos(h/(b-x(1)));  %%%%%%%%%%%%%%%%%%%%%%%%%%%%  aa赋值
l=b-x(1);
for n=1:nnn/2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   求bb
        bb(n)=-atan(tan(aa)-(x(n)-x(1))/(l/2*cos(aa)));
end




for ii=1:nnn/2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   求xx，yy，zz
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

zs=4*r*b;
sum=0;

for n=1:nnn/2
    if n==1
    s(n)=(r^2-(r-a*n)^2)^.5/2;
    else
        s(n)=(r^2-(r-a*n)^2)^.5/2+s(n-1)/2;
    end
end 
r2=e-s(1);
pan=0;
for i=1:nnn/2
    if bb(i)<0  
        bbb=0;
    else
        bbb=bb(i);
    end
r1=e-s(i);
ss(i)=(cos(bbb)*(r2-r1)/r2*cos(pi/2-bbb)+(1-(cos(bbb)*(r2-r1)/r2)^2)^.5*sin(pi/2-bbb))*r2/cos(bbb)-r1;

if ss(i)>b-e
  pan=1;
end
end

for i=1:nnn/2
sum=sum+ss(i);
end

d=2*(l*sin(aa)+1/2*(r^2-(r-a)^2)^.5);

kk=(d-2*r)^2;
%%%%m,p,q=n,ki,b

if s>0&a>0&b>0&e>0&b>r&b>e&e>r&0<=aa&aa<=pi/2&l>=h&-pi/2<=bb&bb<=pi/2& n>=2&d<l&pan==0&mod(nnn,2)==0
zong(m,p,q)=kk/20.4787+d/54.5253+sum/108+nnn/20+zs/6000;

else
    zong(m,p,q)=inf;
end

q=q+1;
end
p=p+1;
end
m=m+1;
end


for iii=1:m-1
    for jjj=1:p-1
        for ooo=1:q-1
            if zong(iii,jjj,ooo)==0
                zong(iii,jjj,ooo)=inf;
            end
        end
    end
end

ix=0;
iy=0;
iz=0;
zn=inf;
for iii=1:m-1
    for jjj=1:p-1
        for ooo=1:q-1
            if zong(iii,jjj,ooo)<zn
                zn=zong(iii,jjj,ooo);
                ix=iii;
                iy=jjj;
                iz=ooo;
            end
        end
    end
end
if ix==0|iy==0|iz==0
   disp('this is an error')  
else
nz=ix+n0-1
kz=0.01*(iy-1)+ki0
bz=iz+b0-1
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
xp