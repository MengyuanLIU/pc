%BP Network


clear;
%��ʼ��
tic;% ��ʱ��ʼ
data = importdata ('Data-Ass2.mat');
train_num=2500;%ѵ�����ݵ�����
test_num=500;%�������ݵ�����
train_data = data(:,1:train_num);%ѵ������
test_data = data(:,train_num+1:train_num+test_num);%��������


%Ϊѵ�����Ͳ��Լ�����һ�г�����1
train_constant_colu = ones(1,train_num);
test_constant_colu = ones(1,test_num);
train_datasrc=[train_data(1:2,:)',train_constant_colu']';
train_dataopt=train_data(3,:);
test_datasrc=[test_data(1:2,:)',test_constant_colu']';
test_opt=zeros(1,test_num);%Ԥ��ķ���
test_dataopt=test_data(3,:);%��ȷ�ķ���

%BP���������������������
iterlimit=350;%��������
alpha=0.03;%ѧϰ��
innum=3;%������Ĳ���
hidnum=4;%������ڵ����Ŀ
outnum=1;%�����ڵ����Ŀ
err=zeros(1,iterlimit+1);%��¼ÿ�ε����µ����
errt=zeros(1,train_num);%//ÿ�������µ�����ʱ���
v=rand(innum,hidnum);%���뾻ֵ
dv=zeros(innum,hidnum);
w=rand(hidnum,outnum);%���Ȩ��
dw=zeros(hidnum,outnum);
y=zeros(hidnum);
secder=zeros(hidnum);


for i=1:train_num
    if (train_dataopt(i)==-1)
        train_dataopt(i)=0;
    end
end

%ÿ�ε������޸�Ȩ��
iter=1;
while (iter<=iterlimit)
    trcnt=1;
    while (trcnt<=train_num) %�������
        d=train_dataopt(trcnt);
        x=train_datasrc(:,trcnt)';
        
        %���㵱ǰ���
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
        
        %��������ֵ
        errtmp=(d-o).^2;
        errt(trcnt)=0.5*errtmp;
        
        %���error_numta(k) error_numta(j)
        firder = (d-o)*o*(1-o);
        
        for j=1:hidnum
            secder(j) = firder*w(j,1)*y(j)*(1-y(j));
        end
        
        %�޸�Ȩ��
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
    
    %��¼���洢�ܵ����
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

%���Դ����
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
    
    o=1/(1+exp(-net));%�����
    if o>0.5
        test_opt(tecnt)=1;
    else
        test_opt(tecnt)=-1;
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
    if (test_opt(i)==1)
        plot(data(1,i+train_num),data(2,i+train_num),'bX');
    else
        plot(data(1,i+train_num),data(2,i+train_num),'rX');
    end
end

%���������
error_num=0;
for i=1:test_num
    %��ʵ�����Ԥ������ŵ�ʱ���ʾ����д���
    if (test_opt(i)*test_dataopt(i)<0)
        error_num=error_num+1;
    end
end
%��ӡ��������
fprintf('The error rate of this prediction is %d/500 = %.2f %%.\n',error_num,error_num/5);