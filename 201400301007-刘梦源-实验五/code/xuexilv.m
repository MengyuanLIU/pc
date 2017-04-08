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
       
     
   
       
     %¸ø³õÊ¼a
     
    
    for xuexi_lv=0.0001:0.00001:0.004
        w=[1 1 1];
     
     times=0;
   while (1)
       times=times+1;   
     c=[0 0 0];
     j_dao=[0 0 0];
     lost=0;
     ree=zeros(10,1,2);
     for i=1:10 
         re=x(i,:,1)*(w');
         ree(i,1,1)=re;
             if(re<0)
             c=(re-1)*x(i,:,1);
             j_dao=j_dao+c; 
             lost=lost+0.5*(re-1)^2;
             end
     end
     for i=1:10 
         re=x(i,:,2)*(w');
         ree(i,1,2)=re;
             if(re>0)
             c=(re+1)*x(i,:,1);
             j_dao=j_dao+c;
             lost=lost+0.5*(re-(-1))^2;
             end
     end
     
     w=w-xuexi_lv*j_dao;
     
     if (lost==0)||(lost<1)
         break;
     end
   
   end
    plot (xuexi_lv,times,'.r');
     hold on;
    end
     