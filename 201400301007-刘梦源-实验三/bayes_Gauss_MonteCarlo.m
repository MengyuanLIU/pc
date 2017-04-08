clc; 
clear;
 syms u sigma;
%样本
D=[0.58 0.27 0.055 0.53 0.47 0.69 0.55 0.61 0.49 0.054];

for x=0:0.001:1
sumpx_D=0;
  for ii=1:5000
    u = 0.43 + sqrt(0.1) * randn(1);
    p_u=mvnpdf(u,0.43,0.1);
    sigma = 0.5 + sqrt(0.2) * randn(1);
    p_sigma=mvnpdf(sigma,0.5,0.2);

% 
% pD_canshu=1;
%  for i=1:10
%    if (abs(D(i)-u)>sigma) 
%       pD_canshu=0;
%      
%     else pD_canshu=((sigma-abs(D(i)-u))/sigma.^2)*pD_canshu;
%    end
%  end
  if  (abs(x-u)>sigma) 
      px_canshu=0;
   else px_canshu=(sigma-abs(x-u))/sigma.^2;
  end
%  j6=pD_canshu*p_u*p_sigma;
%  j1=int (j6,u,0.3,0.5);
%  j2=int (j1,sigma,0,0.5);
%  
%  pcanshu_D=pD_canshu*p_u*p_sigma/j2;
%  

 px_D=p_u*p_sigma*px_canshu;
 sumpx_D=sumpx_D+px_D;
 
  end
   sumpx_D=sumpx_D/5000;
  plot(x,sumpx_D,'.');
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
