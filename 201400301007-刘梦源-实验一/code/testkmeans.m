clc;
clear;
load('2d-data.mat');
%load('3d-data.mat');
data=r;
[centor, re_data]=kmeans(data,5);  
[m, n]=size(re_data);

figure;
hold on;
for i=1:m 
    if re_data(i,3)==1   
         plot3(re_data(i,1),re_data(i,2),re_data(i,3),'ro'); 
    elseif re_data(i,3)==2
         plot3(re_data(i,1),re_data(i,2),re_data(i,3),'go'); 
    elseif re_data(i,3)==3
          plot3(re_data(i,1),re_data(i,2),re_data(i,3),'bo'); 
    elseif re_data(i,3)==4
         plot3(re_data(i,1),re_data(i,2),re_data(i,3),'co'); 
    %elseif re(i,4)==5
         %plot3(re(i,1),re(i,2),re(i,3),'r+'); 
    %elseif re(i,4)==6
        %plot3(re(i,1),re(i,2),re(i,3),'g+'); 
    else
        plot3(re_data(i,1),re_data(i,2),re_data(i,3),'mo');
    
    end

end
grid on;