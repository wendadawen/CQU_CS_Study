function yhat1=case0903b1(beta,x)
xx1=x(:,1);
xx2=x(:,2);
yhat1=((beta(1)+beta(3).*xx2).*xx1)./((beta(2)+beta(4).*xx2)+xx1);
