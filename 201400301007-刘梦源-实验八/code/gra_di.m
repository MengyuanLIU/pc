function [error_num, error_phi,a,dd,h] = gra_di(mytrain,dd,train_data_opt,t)

     w=[2 2 2];
     
     times=0;
     tu=zeros(10000,1);
   while (1)
         
     c=[0 0 0];
     j_dao=[0 0 0];
     lost=0;
     ree=zeros(1500,1);
     for i=1:1500 
         if (train_data_opt(i)>0)
            re=mytrain(i,:)*(w');
              ree(i,1)=re;
             if(re<0)
             c=(re-1)*mytrain(i,:);
             j_dao=j_dao+c; 
             lost=lost+0.5*(re-1)^2*dd(i,1);
             end
         
         else
             re=mytrain(i,:)*(w');
             ree(i,1)=re;
             if(re>0)
             c=(re+1)*mytrain(i,:,1);
             j_dao=j_dao+c;
             lost=lost+0.5*(re-(-1))^2*dd(i,1);
             end
         end
     
     end
    
     
     w=w-0.000003*j_dao;
     times=times+1; 
     if (lost<10)||(times==5000)
         
         break;
     end
   
 tu(times,1)=lost;
     

    
   end
%      figure (1);
%      to=1:times-1;
%      plot(to,tu(1:times-1,1));
%      
     figure(t);
     for d=1:1500
         if (ree(d,1)>0)
             plot (mytrain(d,2),mytrain(d,3),'ro');
             hold on;
         end
        if (ree(d,1)<0)
             plot (mytrain(d,2),mytrain(d,3),'bo');
             hold on;
         end
      
         
     end
error_num=0;


%统计此弱分类器分类的错误个数
 for d=1:1500
         if (ree(d,1)*(train_data_opt(d))<0)
             
             error_num=error_num+1;
             
         end
          
        
 end
 
 %计算错误率、此弱分类器的权重
             error_phi=error_num/1500;
             a=0.5*log((1-error_phi)/error_phi);
 
        
 %更新此弱分类器分类之后的样本点的权重
   for d=1:1500           
          if (ree(d,1)*(train_data_opt(d))<0)
             
              dd(d,1)= dd(d,1)*((1-error_phi)/error_phi);
             
          end
          
        
   end
   
   h=sign(ree);
end           
