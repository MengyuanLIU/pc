%BP Network


clear;
%初始化
tic;% 计时开始
data = importdata ('Data-Ass2.mat');
train_num=2500;%训练数据的数量
test_num=500;%测试数据的力量
train_data = data(:,1:train_num);%训练数据
test_data = data(:,train_num+1:train_num+test_num);%测试数据


%为训练集和测试集增加一列常数项1
train_constant_colu = ones(1,train_num);
test_constant_colu = ones(1,test_num);
train_datasrc=[train_data(1:2,:)',train_constant_colu']';
train_dataopt=train_data(3,:);
test_datasrc=[test_data(1:2,:)',test_constant_colu']';
test_opt=zeros(1,test_num);%预测的分类
test_dataopt=test_data(3,:);%正确的分类

%BP神经网络参数的声明和设置
iterlimit=350;%迭代次数
alpha=0.03;%学习率
innum=3;%神经网络的层数
hidnum=4;%隐含层节点的数目
outnum=1;%输出层节点的数目
err=zeros(1,iterlimit+1);%记录每次迭代下的误差
errt=zeros(1,train_num);%//每个样本下的误差，即时误差
v=rand(innum,hidnum);%输入净值
dv=zeros(innum,hidnum);
w=rand(hidnum,outnum);%随机权重
dw=zeros(hidnum,outnum);
y=zeros(hidnum);
secder=zeros(hidnum);


for i=1:train_num
    if (train_dataopt(i)==-1)
        train_dataopt(i)=0;
    end
end

%每次迭代，修改权重
iter=1;
while (iter<=iterlimit)
    trcnt=1;
    while (trcnt<=train_num) %计算误差
        d=train_dataopt(trcnt);
        x=train_datasrc(:,trcnt)';
        
        %计算当前输出
        for j=1:hidnum
            net=0.0;
            for i=1:innum
                net=net+x(i)*v(i,j);
            end
            y(j)=1/(1+exp(-net));
        end
        
        net=0.0;
        for j=1:hidnum
            net=net+y(j)*w(j,1);
        end
        
        o=1/(1+exp(-net));
        
        %计算误差函数值
        errtmp=(d-o).^2;
        errt(trcnt)=0.5*errtmp;
        
        %获得error_numta(k) error_numta(j)
        firder = (d-o)*o*(1-o);
        
        for j=1:hidnum
            secder(j) = firder*w(j,1)*y(j)*(1-y(j));
        end
        
        %修改权重
        for j=1:hidnum
            dw(j,1)=alpha*firder*y(j);
            w(j,1)=w(j,1)+dw(j,1);
        end
        
        for i=1:innum
            for j=1:hidnum
                dv(i,j)=alpha*secder(j)*x(i);
                v(i,j)=v(i,j)+dv(i,j);
            end
        end
        
        trcnt=trcnt+1;
    end
    
    %记录并存储总的误差
    tot=0.0;
    for i=1:train_num
        tot=tot+errt(i).^2;
    end
    tot=tot/train_num;
    err(iter)=tot.^(1/2);
    
    if (err(iter)<0.001)
        break;
    end
    
    iter=iter+1;
end

%测试代码段
tecnt=1;
while (tecnt<=test_num)
    x=test_datasrc(:,tecnt)';
    
    for j=1:hidnum
        net=0.0;
        for i=1:innum
            net=net+x(i)*v(i,j);
        end
        y(j)=1/(1+exp(-net));
    end
    
    net=0.0;
    for j=1:hidnum
        net=net+y(j)*w(j,1);
    end
    
    o=1/(1+exp(-net));%激活函数
    if o>0.5
        test_opt(tecnt)=1;
    else
        test_opt(tecnt)=-1;
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
    if (test_opt(i)==1)
        plot(data(1,i+train_num),data(2,i+train_num),'bX');
    else
        plot(data(1,i+train_num),data(2,i+train_num),'rX');
    end
end

%计算错误率
error_num=0;
for i=1:test_num
    %真实结果和预测结果异号的时候表示结果有错误
    if (test_opt(i)*test_dataopt(i)<0)
        error_num=error_num+1;
    end
end
%打印出错误率
fprintf('The error rate of this prediction is %d/500 = %.2f %%.\n',error_num,error_num/5);