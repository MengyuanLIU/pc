
clear;

%Initialization
tic;% 开始计时
data = importdata ('Data-Ass2.mat');
train_num=2500;%训练数据的数量
test_num=500;%测试数据的力量
train_data = data(:,1:train_num);%训练数据
test_data = data(:,train_num+1:train_num+test_num);%测试数据

%测试集合训练集特征值和分类标签的划分
train_datasrc=train_data(1:2,:);
train_dataopt=train_data(3,:);
test_datasrc=test_data(1:2,:);
test_opt=zeros(1,test_num);
test_dataopt=test_data(3,:);

%RBF神经网络参数的声明和设置
iterlimit=200;%迭代次数
alpha=0.2;%学习率
innum=2;%神经网络的层数，RBF权相连得有两层
hidnum=12;%隐含层节点的数目
outnum=1;%输出层节点的数目
err=zeros(1,iterlimit+1);%记录每次迭代下的误差
errt=zeros(1,train_num);%//每个样本下的误差，即时误差
w=rand(hidnum,outnum);%随机权重

%Get the center and get their indices
[idx,cen]=kmeans(train_datasrc',hidnum);%利用kmeans得到基函数的中心点

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

%每次迭代，修改权重
iter=1;
while (iter<=iterlimit)
    trcnt=1;
    while (trcnt<=train_num)%计算误差
        
         %计算当前输出
        out=0.0;
        for i=1:hidnum
            out=out+w(i,1)*green(trcnt,i);
        end
        
        %计算误差函数值
        errtmp=(train_dataopt(trcnt)-out).^2;
        errt(trcnt)=0.5.*errtmp;
        
        %获得error_numta(k) error_numta(j)
        for i=1:hidnum
            w(i,1)=w(i,1)+alpha*(train_dataopt(trcnt)-out)*green(trcnt,i);
        end
        trcnt=trcnt+1;
    end
    
     %记录并存储总的误差
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

%测试结果输出
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

toc;%计时结束

hold on;

%画出测试集
for i=train_num:test_num+train_num
    if (data(3,i)==1)
        plot(data(1,i),data(2,i),'bo');
    else
        plot(data(1,i),data(2,i),'ro');
    end
end
%画出测试集的预测结果，以‘X’表示
for i=1:test_num
    if (test_opt(i)==2)
        plot(data(1,i+train_num),data(2,i+train_num),'bX');
    else
        plot(data(1,i+train_num),data(2,i+train_num),'rX');
    end
end


%计算错误率
error_num=0;
for i=1:test_num
    if (test_opt(i)*test_dataopt(i)<0)
        error_num=error_num+1;
    end
end
fprintf('The error rate of this prediction is %d/500 = %.2f %%.\n',error_num,error_num/5);