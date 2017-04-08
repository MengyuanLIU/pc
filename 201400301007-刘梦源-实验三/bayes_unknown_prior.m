clc; 
clear;
 syms u sigma;
%样本
D=[0.58 0.27 0.055 0.53 0.47 0.69 0.55 0.61 0.49 0.054];



   sum2=0;
  for ii=1:100
    u =0.01*ii;
    p_u=0.01;
   %p_u=mvnpdf(u,0.3,0.2);
   for iii=1:100
    sigma = 0.01*ii;
    p_sigma=0.01;
   %p_sigma=mvnpdf(sigma,0.5,0.2);


 pD_canshu=1;
 for i=1:10
   if (abs(D(i)-u)>sigma) 
      pD_canshu=0;
     
   else pD_canshu=((sigma-abs(D(i)-u))/sigma.^2)*pD_canshu;
   end
 end
 
 
%  j6=pD_canshu*p_u*p_sigma;
%  j1=int (j6,u,0.3,0.5);
%  j2=int (j1,sigma,0,0.5);
%  
%  pcanshu_D=pD_canshu*p_u*p_sigma/j2;
%  
 
 t2=pD_canshu*p_u*p_sigma;
 
 sum2=sum2+t2;
   end
  end
  
  

for x=0:0.001:1
  sum1=0;  
  for ii=1:100
    u =0.01*ii;
    p_u=0.01;
   %p_u=mvnpdf(u,0.3,0.2);
   for iii=1:100
    sigma = 0.01*ii;
    p_sigma=0.01;
    
    
    pD_canshu=1;
 for i=1:10
   if (abs(D(i)-u)>sigma) 
      pD_canshu=0;
     
   else pD_canshu=((sigma-abs(D(i)-u))/sigma.^2)*pD_canshu;
   end
 end
 
 if  (abs(x-u)>sigma) 
      px_canshu=0;
   else px_canshu=(sigma-abs(x-u))/sigma.^2;
 end
 
 t1= pD_canshu*p_u*p_sigma*px_canshu/sum2;
    sum1=sum1+t1;  
   end
  end
  
  plot(x,sum1,'.');
  hold on;
  
end
  
  
  
% %设p(u)的方差为
% 
% t=[0.05;0.05]; 
% 
% %样本均值
% xx1=sum(X(1,:))/60;
% xx2=sum(X(2,:))/60;
% xx=[xx1;xx2]
% 
% %求出样本方差，设总体方差等于样本方差
% xy1=sum((X(1,:)-xx1.*ones(1,60)).^2)/59;
% xy2=sum((X(2,:)-xx2.*ones(1,60)).^2)/59;
% xy=[xy1;xy2]
% 
% %u的先验估计值
% u0=[0.93;0.94];
% 
% %用贝叶斯估计公式求得u的估计值
% u1=60*t(1)*xx1/(60*t(1)+xy1)+xy1*u0(1)/(60*t(1)+xy1);
% u2=60*t(2)*xx2/(60*t(2)+xy2)+xy2*u0(2)/(60*t(2)+xy2);
% u=[u1;u2]
% 
