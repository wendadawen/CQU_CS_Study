function yhat2=case0903b2(beta,x)
xx1=x(:,1);
xx2=x(:,2);
yhat2=((beta(1)+beta(3).*xx2).*xx1)./(beta(2)+xx1);
