clc
clear
close all
% �������ݣ�������23��ָ���2010��1���ȵ�2018��1���ȵ����ݣ���֤����2017�����ݣ����Լ���2018��1����
data=xlsread('�ϲ����ݸ���.xlsx');
[m1 n1] = size(data);
data_new=data(:,n1);
data=data(:,1:n1-1);
[m n] = size(data);
%indices=crossvalind('Kfold',data(m,1:n),8);
indices=[1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8];
x_new = data_new(1:m-1,1);
y_new = data_new(m,1);
% Bhartendu, Machine Learning & computing


% ������������spread����
cost=100;
cost_test = 0;
aa=0;
cc = [];
for spread=1:300
    for k=1:8
        test = (indices==k);
        train = ~test;
        x_train = data(1:m-1,train);
        y_train = data(m,train);
        x_test = data(1:m-1,test);
        y_test = data(m,test);
        net = newrbe(x_train,y_train,spread);
        fxtest= sim(net,x_test);
        cc(k) = sum(abs(fxtest-y_test));
        cost_test = cost_test+sum(abs(fxtest-y_test));
    end
    cost_test = cost_test/8;
    if cost_test<cost
        aa = spread;
        bb = cc;
        cost = cost_test;
    end
end

% �������Ų�����Ԥ������
spread = aa;      % ��ֵԽ��,���ǵĺ���ֵ�ʹ�,�˲���Ӱ��Ԥ���Ч��
net = newrbe(x_train,y_train,spread);
fxtr= sim(net,x_train);
fxtest= sim(net,x_test);
fxnew = sim(net,x_new);
