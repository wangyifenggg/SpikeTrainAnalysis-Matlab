function [ x,y ] = makeNonhomogeneousModel( y2 )
%�÷����ָ���ֲ��������ʱ����,������1-1-5��ͨ��52
%   y2 ԭ���ݽṹ��
%   y ��ϵķֲ�����
L=max(y2.step_time);
mu=mean(y2.step_time);
bottom=3;%�����ĸ���ֵ�߶�
height=12;%��������ֵ�߶�
lambda=1/mu;%ָ���ֲ��Ĳ���
a=bottom/height*mu;%����ֵ����������ɱ�����Ӱ��
eta=0.01;%����ֵ˥����eta�ɽ���Ϊ0
t1=0.2;%0.2sʱ����ֵ����Ϊ0��ͨ��52����ֵ
%��0.01=a*exp(-(t1/tao))���tao
k=log(eta/a);
tao=-t1/k;%��Ԫ��Ȼ©�糣��
%���Ƴ���ϵĸ����ܶȺ���
x=0:0.01:L;
y=((lambda-a*(1/tao)*exp(-(1/tao)*x)).*exp(lambda*x+a.*exp(-(1/tao)*x))).*(x<=0.2)+(lambda*exp(-lambda*x)).*(x>0.2);
%У��ϵ������Ϊ1.1��ͨ�����ֻ�ã����ƹ�һ��,ͨ��52
y=1.1*y;
for i=1:length(y)
    if y(1,i)<0
        y(1,i)=0;
    end
end



end

