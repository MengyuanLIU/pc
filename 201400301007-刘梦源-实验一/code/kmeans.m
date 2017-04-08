
function [centor, re_data]=KMeans(data,k)   
    [num, dimension]=size(data);   
    maxn=zeros(dimension);        
    minn=zeros(dimension);      
    centor=zeros(k,dimension);       
    for i=1:dimension
       maxn(i)=max(data(:,i));   
       minn(i)=min(data(:,i));    
       for j=1:k
            centor(j,i)=maxn(i)+(minn(i)-maxn(i))*rand();  
       end      
    end
   
    t=1;
    while (t>0)
        pre_centor=centor;            
        for i=1:k
            dis{i}=[];     
            for j=1:num
                dis{i}=[dis{i};data(j,:)-centor(i,:)];
            end
        end
        
        whole=zeros(num,k);
        for i=1:num        
            abs_dis=[];
            for j=1:k
                abs_dis=[abs_dis norm(dis{j}(i,:))];
            end
            [~, index]=min(abs_dis);
            whole(i,index)=norm(dis{index}(i,:));           
        end
        
        for i=1:k            
           for j=1:dimension
                centor(i,j)=sum(whole(:,i).*data(:,j))/sum(whole(:,i));
           end           
        end
        
        if norm(pre_centor-centor)<0.1
            break;
        end
    end
    
    re_data=[];
    for i=1:num
        dis=[];
        for j=1:k
            dis=[dis norm(data(i,:)-centor(j,:))];
        end
        [~, index]=min(dis);
        re_data=[re_data;data(i,:) index];
    end
    
end