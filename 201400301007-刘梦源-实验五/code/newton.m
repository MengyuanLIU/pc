clc; clear;
x(:,:,1)=[ 1 0.1 1.1;
           1 6.8 7.1;
           1 -3.5 -4.1;
           1  2.0 2.7; 
           1   4.1 2.8; 
           1  3.1 5.0 ;
          1   -0.8 -1.3; 
           1  0.9 1.2; 
          1   5.0 6.4;
           1  3.9 4.0 ];
 x(:,:,2)=[1 -3.0 -2.9;
           1 0.5 8.7;
          1 2.9 2.1;
          1  -0.1 5.2;
          1  -4.0 2.2;
          1  -1.3 3.7;
          1  -3.4 6.2;
          1  -4.1 3.4;
          1  -5.1 1.6;
          1  1.9 5.1   ];
       for i=1:10
       plot (x(i,2,1),x(i,3,1),'r*');
       hold on;
        plot (x(i,2,2),x(i,3,2),'b*');
        hold on;
       end 
       figure (1);
   
       
     %¸ø³õÊ¼a
     
     w=[1 1 1];
     
     times=0;
     tu=zeros(1000000,1);
   while (1)
         
     c=[0 0 0];
     j_dao=[0 0 0];
     lost=0;
     h=0;
     ree=zeros(10,1,2);
     for i=1:10 
         re=x(i,:,1)*(w');
         ree(i,1,1)=re;
             if(re<0)
             c=(re-1)*x(i,:,1);
             j_dao=j_dao+c; 
             lost=lost+0.5*(re-1)^2;
             h=h+x(i,:,1)*x(i,:,1)';
             end
     end
     for i=1:10 
         re=x(i,:,2)*(w');
         ree(i,1,2)=re;
             if(re>0)
             c=(re+1)*x(i,:,1);
             j_dao=j_dao+c;
             lost=lost+0.5*(re-(-1))^2;
             h=h+x(i,:,2)*x(i,:,2)';
             end
     end
     
     w=w-h^(-1)*j_dao;
     times=times+1; 
     if (lost==0)||(lost<2)||times==100000
         
         break;
     end
   
     tu(times,1)=lost;
     
%      plot(times,lost,'.');
%      hold on;
    
   end
    figure (2);
     to=1:times;
     plot(to,tu(1:times,1));
   
     figure(3);
     for d=1:10
         if (ree(d,1,1)>0)
             plot (x(d,2,1),x(d,3,1),'ro');
             hold on;
         end
         if (ree(d,1,1)<0)
             plot (x(d,2,1),x(d,3,1),'r*');
             hold on;
         end
         if (ree(d,1,2)<0)
             plot (x(d,2,2),x(d,3,2),'bo');
             hold on;
         end
         if (ree(d,1,2)>0)
             plot (x(d,2,2),x(d,3,2),'b*');
             hold on;
         end
     end
     