clc; clear;
x(:,:,1) = [-5.01 -8.12 -3.68;
            -5.43 -3.48 -3.54;
             1.08 -5.52  1.66;
             0.86 -3.78 -4.11;
            -2.67  0.63  7.39;
             4.94  3.29  2.08;
            -2.51  2.09 -2.59;
            -2.25 -2.13 -6.94;
             5.56  2.86 -2.26;
             1.03 -3.33  4.33];
x(:,:,2) = [-0.91 -0.18 -0.05;
             1.30 -2.06 -3.53;
            -7.75 -4.54 -0.95;
            -5.47  0.50  3.92;
             6.14  5.72 -4.85;
             3.60  1.26  4.36;
             5.37 -4.63 -3.65;
             7.18  1.46 -6.66;
            -7.39  1.17  6.30;
            -7.50 -6.32 -0.31];

x(:,:,3) = [ 5.35  2.26  8.13;
             5.12  3.22 -2.66;
            -1.34 -5.31 -9.87;
             4.48  3.42  5.19;
             7.11  2.39  9.21;
             7.17  4.33 -0.98;
             5.75  3.97  6.65;
             0.77  0.27  2.41;
             0.90 -0.43 -8.71;
             3.52 -0.36  6.43];
mu(:,:,1) = sum(x(:,:,1)) ./ 10;
mu(:,:,2) = sum(x(:,:,2)) ./ 10;
mu(:,:,3) = sum(x(:,:,3)) ./ 10;
sigma(:,:,1) = cov(x(:,:,1));
sigma(:,:,2) = cov(x(:,:,2));
sigma(:,:,3) = cov(x(:,:,3));  
p(1)=0.5;
p(2)=0.5;
p(3)=0;

% 
% 一维散点图
%      for X1=-10:0.01:10
%       g1=mvnpdf(X1, mu(1,1,1), sigma(1,1,1))*p(1); 
%       plot(X1,g1,'.r','markersize',2);
%       hold on;
%       g2=mvnpdf(X1, mu(1,1,2), sigma(1,1,2))*p(2);
%       plot(X1,g2,'.b','markersize',2)
%       hold on;
%      
%       if(g1-g2)<0.0001&&(g1-g2)>0
%           plot (X1,g2,'*b','markersize',10);
%           text(-5,0.025,'x= -5.07');
%           text(4.5,0.025,'x= 4.33');
%          end
%      end
%        legend('第一类','第二类');
% 二维散点图   
%  for X1=-10:0.1:10
%    for  X2=-10:0.1:10
%         g1=mvnpdf([X1,X2], mu(1,1:2,1), sigma(1:2,1:2,1))*p(1); 
%        g2=mvnpdf([X1,X2], mu(1,1:2,2), sigma(1:2,1:2,2))*p(2);  
%        if (g1>g2)
%        plot3(X1,X2,g1,'.r','markersize',2);
%       hold on;
%        else 
%       plot3(X1,X2,g2,'.y','markersize',2);
%       hold on;
%        end
%       
%      
%     end
%  end
%二维高程图
% 
% [xx,yy]=meshgrid (linspace(-12,12,80));
% OP=[xx(:) yy(:)];
%  g1=mvnpdf(OP, mu(1,1:2,1), sigma(1:2,1:2,1))*p(1); 
%  g2=mvnpdf(OP, mu(1,1:2,2), sigma(1:2,1:2,2))*p(2); 
% hold on;
% surf(xx,yy,reshape(g1,80,80));
% surf(xx,yy,reshape(g2,80,80));
% 两个特征值
    for i=1:10
        for ii=1:2
         g1=mvnpdf([x(i,1,ii),x(i,2,ii)], mu(1,1:2,1), sigma(1:2,1:2,1))*p(1);
          g2=mvnpdf([x(i,1,ii),x(i,2,ii)], mu(1,1:2,2), sigma(1:2,1:2,2))*p(2);
        
         
        
              
          if((g1>g2)&&(ii==1))||((g1<g2)&&(ii==2))
           plot(x(i,1,ii),x(i,2,ii),'.b')  ;
           hold on;
           
          else plot(x(i,1,ii),x(i,2,ii),'*r')  ;
              hold on;
           
          end
          grid on;
          legend('分类正确','分类错误');
        end
   end
%三个特征值
%   for i=1:10
%         for ii=1:2
%          g1=mvnpdf([x(i,1,ii),x(i,2,ii),x(i,3,ii)], mu(1,1:3,1), sigma(1:3,1:3,1))*p(1);
%           g2=mvnpdf([x(i,1,ii),x(i,2,ii),x(i,3,ii)], mu(1,1:3,2), sigma(1:3,1:3,2))*p(2);  
%           if((g1>g2)&&(ii==1))||((g1<g2)&&(ii==2))
%            plot3(x(i,1,ii),x(i,2,ii),x(i,3,ii),'.b')  ;
%            hold on;
%           else plot3(x(i,1,ii),x(i,2,ii),x(i,3,ii),'*r')  ;
%               hold on;
%           end
%           
%         end
%    end
%    grid on; 
     
      
 
 

         