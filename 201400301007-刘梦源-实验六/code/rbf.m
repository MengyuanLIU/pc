
clear;

%Initialization
tic;% ��ʼ��ʱ
data = importdata ('Data-Ass2.mat');
train_num=2500;%ѵ�����ݵ�����
test_num=500;%�������ݵ�����
train_data = data(:,1:train_num);%ѵ������
test_data = data(:,train_num+1:train_num+test_num);%��������

%���Լ���ѵ��������ֵ�ͷ����ǩ�Ļ���
train_datasrc=train_data(1:2,:);
train_dataopt=train_data(3,:);
test_datasrc=test_data(1:2,:);
test_opt=zeros(1,test_num);
test_dataopt=test_data(3,:);

%RBF���������������������
iterlimit=200;%��������
alpha=0.2;%ѧϰ��
innum=2;%������Ĳ�����RBFȨ������������
hidnum=12;%������ڵ����Ŀ
outnum=1;%�����ڵ����Ŀ
err=zeros(1,iterlimit+1);%��¼ÿ�ε����µ����
errt=zeros(1,train_num);%//ÿ�������µ�����ʱ���
w=rand(hidnum,outnum);%���Ȩ��

%Get the center and get their indices
[idx,cen]=kmeans(train_datasrc',hidnum);%����kmeans�õ������������ĵ�

%Calculate the extended constant and Green function
excon=zeros(1,hidnum);
green=zeros(train_num+test_num,hidnum);
for i=1:hidnum
    cmin=1e15;
    for j=1:hidnum
        tmpc=(cen(i,1)-cen(j,1)).^2+(cen(i,2)-cen(j,2)).^2;
        if (i~=j&&tmpc<cmin)
            cmin=tmpc;
        end
    end
    excon(i)=cmin;
end
for i=1:train_num
    for j=1:hidnum
        green(i,j)=exp(-((train_datasrc(1,i)-cen(j,1)).^2+(train_datasrc(2,i)-cen(j,2)).^2)/(2.*excon(j)));
    end
end

%ÿ�ε������޸�Ȩ��
iter=1;
while (iter<=iterlimit)
    trcnt=1;
    while (trcnt<=train_num)%�������
        
         %���㵱ǰ���
        out=0.0;
        for i=1:hidnum
            out=out+w(i,1)*green(trcnt,i);
        end
        
        %��������ֵ
        errtmp=(train_dataopt(trcnt)-out).^2;
        errt(trcnt)=0.5.*errtmp;
        
        %���error_numta(k) error_numta(j)
        for i=1:hidnum
            w(i,1)=w(i,1)+alpha*(train_dataopt(trcnt)-out)*green(trcnt,i);
        end
        trcnt=trcnt+1;
    end
    
     %��¼���洢�ܵ����
    tmp=0.0;
    for i=1:train_num
        tmp=tmp+errt(i).^2;
    end
    tmp=tmp/train_num;
    err(iter)=tmp.^(1/2);
    if (err(iter)<0.001)
        break;
    end
    
    iter=iter+1;
end

for i=1:test_num
    for j=1:hidnum
        green(i+train_num,j)=exp(-((test_datasrc(1,i)-cen(j,1)).^2+(test_datasrc(2,i)-cen(j,2)).^2)/(2.*excon(j)));
    end
end

%���Խ�����
tecnt=1;
while (tecnt<=test_num)
    
    net=0.0;
    for j=1:hidnum
        net=net+green(tecnt+train_num,j)*w(j,1);
    end
   
    if net>0
        test_opt(tecnt)=2;
    else
        test_opt(tecnt)=-2;
    end
    
    tecnt=tecnt+1;
end

toc;%��ʱ����

hold on;

%�������Լ�
for i=train_num:test_num+train_num
    if (data(3,i)==1)
        plot(data(1,i),data(2,i),'bo');
    else
        plot(data(1,i),data(2,i),'ro');
    end
end
%�������Լ���Ԥ�������ԡ�X����ʾ
for i=1:test_num
    if (test_opt(i)==2)
        plot(data(1,i+train_num),data(2,i+train_num),'bX');
    else
        plot(data(1,i+train_num),data(2,i+train_num),'rX');
    end
end


%���������
error_num=0;
for i=1:test_num
    if (test_opt(i)*test_dataopt(i)<0)
        error_num=error_num+1;
    end
end
fprintf('The error rate of this prediction is %d/500 = %.2f %%.\n',error_num,error_num/5);