function [ K,R ] = makeGrammaModel( y )
%用伽马分布拟合脉冲时间间隔分布
%   y 原数据结构体
%   K 伽马分布的第一个参数
%   R 伽马分布的第二个参数

[~,N]=size(y.step_time);
mu=mean(y.step_time);
L=floor(N/2);
CV2=zeros(1,L);
for i=1:L
    CV2(1,i)=2*abs(y.step_time(1,2*i)-y.step_time(1,2*i-1))/(y.step_time(1,2*i)+y.step_time(1,2*i-1));
end
CV2_2=CV2*CV2'/N;
K=2/CV2_2-0.5;
R=mu/K;




end