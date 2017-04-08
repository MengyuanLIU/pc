function [bool class] = test(train_data)
[m,n]=size(train_data);
classlist=train_data(:,n);
classtype=unique(classlist);
bool=0;
class=-1;

%When to exit:
%There are no samples in the node
%the feature set is empty
%the samples belong to the same class
if length(classtype)==1
    disp(train_data);
    bool=1;
    class=classtype;
    return;
end

if m==0||n==1
    disp(train_data);
    bool=1;
    return;
end
return;
end

