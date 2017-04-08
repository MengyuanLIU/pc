function [tree bestlist]=id3(train_data,bestlist)
tree=struct('value', 'null', 'll', 'null', 'l', 'null', 'r', 'null', 'rr', 'null');
[m,n]=size(train_data);
classlist=train_data(:,n);
classtype=unique(classlist);

%When to exit:
%There are no samples in the node
%the feature set is empty
%the samples belong to the same class
if length(classtype)==1
    disp(train_data);
    return;
end

if m==0||n==1
    disp(train_data);
    return;
end

%find the best feature for further divide
bestfeat=best_feat(train_data);
disp(['bestfeature:',num2str(bestfeat)]);
bestlist=[bestlist bestfeat];
tree.value=bestfeat;


%remove duplicate value of the best feature
featvalue=unique(train_data(:,bestfeat));
% the number of value of the best feature
featvalue_num=length(featvalue);

%store the tree structure
for i=1:featvalue_num
    if i==1
       [bool1 class]=test(splitData(train_data,bestfeat,featvalue(i,:)));
       if bool1==1
           tree.ll=struct('value',class,'ll', 'null', 'l', 'null', 'r', 'null', 'rr', 'null');
       else
        [tree.ll bestlist]=id3(splitData(train_data,bestfeat,featvalue(i,:)),bestlist);
       end
    else if i==2
            [bool2 class]=test(splitData(train_data,bestfeat,featvalue(i,:)));
          if bool2==1
               tree.l=struct('value',class,'ll', 'null', 'l', 'null', 'r', 'null', 'rr', 'null');
          else
               [tree.l bestlist]=id3(splitData(train_data,bestfeat,featvalue(i,:)),bestlist);
          end
        else if i==3
              [bool3 class]=test(splitData(train_data,bestfeat,featvalue(i,:)));
              if bool3==1
                   tree.r=struct('value',class,'ll', 'null', 'l', 'null', 'r', 'null', 'rr', 'null');
              else
                   [tree.r bestlist]=id3(splitData(train_data,bestfeat,featvalue(i,:)),bestlist);
              end
            else if i==4
                  [bool4 class]=test(splitData(train_data,bestfeat,featvalue(i,:)));
                  if bool4==1
                       tree.rr=struct('value',class,'ll', 'null', 'l', 'null', 'r', 'null', 'rr', 'null');
                  else
                       [tree.rr bestlist]=id3(splitData(train_data,bestfeat,featvalue(i,:)),bestlist);
                  end
                end
            end
        end
    end
end
end
