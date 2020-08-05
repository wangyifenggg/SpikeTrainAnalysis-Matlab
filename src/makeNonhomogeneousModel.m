function [ x,y ] = makeNonhomogeneousModel( y2 )
%用非齐次指数分布拟合脉冲时间间隔,适用于1-1-5的通道52
%   y2 原数据结构体
%   y 拟合的分布数据
L=max(y2.step_time);
mu=mean(y2.step_time);
bottom=3;%脉冲后的负峰值高度
height=12;%脉冲正峰值高度
lambda=1/mu;%指数分布的参数
a=bottom/height*mu;%负峰值对脉冲产生成比例的影响
eta=0.01;%负峰值衰减到eta可近似为0
t1=0.2;%0.2s时负峰值近似为0，通道52经验值
%由0.01=a*exp(-(t1/tao))求解tao
k=log(eta/a);
tao=-t1/k;%神经元自然漏电常数
%绘制出拟合的概率密度函数
x=0:0.01:L;
y=((lambda-a*(1/tao)*exp(-(1/tao)*x)).*exp(lambda*x+a.*exp(-(1/tao)*x))).*(x<=0.2)+(lambda*exp(-lambda*x)).*(x>0.2);
%校正系数设置为1.1，通过积分获得，类似归一化,通道52
y=1.1*y;
for i=1:length(y)
    if y(1,i)<0
        y(1,i)=0;
    end
end



end

