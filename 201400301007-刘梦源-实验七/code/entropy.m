function [e] = entropy(train_data)
[m,n]=size(train_data);

%pick out the class 
label_value=train_data(:,n);
%remove the duplicate class
label=unique(label_value);
%record the number of appearance of each label.
label_number=zeros(length(label),2);
label_number(:,1)=label';
for i=1:length(label)
    label_number(i,2)=sum(label_value==label(i));
end

%º∆À„Ïÿ÷µ
label_number(:,2)=label_number(:,2)./m;
e=0;
e=sum(-label_number(:,2).*log2(label_number(:,2)));

end

