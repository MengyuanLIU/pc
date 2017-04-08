function [best_feature] = best_feat(data)
[m,n]=size(data);
%the number of  feature is columns -1(there is one dimension  for class)
feature_num=n-1;
%calculate entropy for the whole data
baseE=entropy(data);
disp('Entropy£º');
disp(baseE);

%best_gain=0;
best_ratio=0;
best_feature=0;

%choose a specific feature
for j=1:feature_num
   %remove duplicate value for feature j.
    feature_temp=unique(data(:,j));
    num_f=length(feature_temp);
    
    if(num_f==1)%all of node have the same value of this feature
        gain_ratio=0;
        disp('Gain_ratio:');
        disp(gain_ratio);
        continue;
    end
    
    new_entropy=0;
    IV=0;
    %choose a specific value of the feature
    for i=1:num_f
        %The subset of the data which have the specific value of the feature 
        subSet=splitData(data,j,feature_temp(i,:));
        [m_s,n_s]=size(subSet);
        %|Dv|./|D|
        prob=m_s./m;
        new_entropy=new_entropy+prob*entropy(subSet);
        IV=IV+prob*log2(prob);
    end
    %Information gain
    inf_gain=baseE-new_entropy;
    %Gain_ratio
    gain_ratio=inf_gain/(-IV);
    disp('Gain_ratio:');
    disp(gain_ratio);

    if gain_ratio>best_ratio
        best_ratio=gain_ratio;
        best_feature=j;
    end
end

end


