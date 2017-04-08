clear;
data = importdata ('Data-Ass2.mat');
train_num=1500;
test_num=1500;
train = data(:,1:train_num);
test = data(:,train_num+1:train_num+test_num);
trdata=train(1:2,:)';
train_data_opt=train(3,:)';

tedata=test(1:2,:)';

test_data_opt=test(3,:)';

mytrain=ones(1500,3);
mytrain(:,2:3)=trdata;
mytest=ones(1500,3);
mytest(:,2:3)=tedata;
 
%初始化每个点的权重为1/1500
dd=zeros(1500,1);
dd(:,1)=1/1500;

[error_num1, error_phi1,a1,dd,h1] = gra_di(mytrain,dd,train_data_opt,1);

[error_num2, error_phi2,a2,dd,h2] = gra_di(mytrain,dd,train_data_opt,2);
   
[error_num3, error_phi3,a3,dd,h3] = gra_di(mytrain,dd,train_data_opt,3);
[error_num4, error_phi4,a4,dd,h4] = gra_di(mytrain,dd,train_data_opt,4);
[error_num5, error_phi5,a5,dd,h5] = gra_di(mytrain,dd,train_data_opt,5);


final=zeros(1500,1);
error_num=0;
for i=1:1500
    final(i)=h1(i)*a1+h2(i)*a2+h3(i)*a3+h4(i)*a4+h5(i)*a5;
end

 for d=1:1500
         if (final(d,1)*(train_data_opt(d))<0)
             
             error_num=error_num+1;
             
         end
          
        
 end
 
 figure(6);
 for d=1:1500
      if (final(d,1)>0)
         plot (mytrain(d,2),mytrain(d,3),'ro');    
           hold on;  
             
      end
       
         if (final(d,1)<0)
             
             
           plot (mytrain(d,2),mytrain(d,3),'bo');      
             hold on;
         end
          
        
 end
 error_phi_final=error_num/1500;
 
 figure(7);
 X_final=[1,2,3,4,5,6];
 Y_final=[error_num1,error_num2,error_num3,error_num4,error_num5,error_num];
 plot(X_final,Y_final,'k-o');
 
 
 figure(8);
 Xx_final=[1,2,3,4,5,6];
 Yy_final=[1-error_phi1,1-error_phi2,1-error_phi3,1-error_phi4,1-error_phi5,1-error_phi_final];
 plot(Xx_final,Yy_final,'k-o');
  

  
           
  
  
 
 
   