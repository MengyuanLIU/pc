function [subSet] = splitData(data,j,value)
% data: training data
% j: the jth feature
% value: the specific value of the jth feature
% subset: subset Dv to calculate entropy
k=1;
for i=1:size(data,1)
    if data(i,j)==value
        subSet(k,:)=data(i,:);
        k=k+1;
    end
end
end

