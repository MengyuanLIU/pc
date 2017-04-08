%SVM (supported by LibSVM)
%Initialization
clear;
data = importdata ('Data-Ass2.mat');
trnum=2500;
tenum=500;
trdata = data(:,1:trnum);
tedata = data(:,trnum+1:trnum+tenum);
trdatasrc=trdata(1:2,:)';
trdataopt=trdata(3,:)';
tedatasrc=tedata(1:2,:)';
teopt=zeros(1,tenum)';
tedataopt=tedata(3,:);

tic;% Timer Start

%SVM Kernel Phase
model = svmtrain(trdataopt ,trdatasrc);

[predicted_label] = svmpredict(teopt, tedatasrc, model);
teopt=predicted_label';

toc;% Timer End

hold on;

%Drawing test cases and samples
for i=1:trnum+tenum
    if (data(3,i)==1)
        plot(data(1,i),data(2,i),'ro');
    else
        plot(data(1,i),data(2,i),'bo');
    end
end

for i=1:tenum
    if (teopt(i)==1)
        plot(data(1,trnum+i),data(2,trnum+i),'y+');
    else
        plot(data(1,trnum+i),data(2,trnum+i),'g+');
    end
end

%Error rate calculation
del=0;
for i=1:tenum
    if (teopt(i)*tedataopt(i)<0)
        del=del+1;
    end
end

fprintf('The error rate of this estimation is %d/500 = %.2f %%.\n',del,del/5);
