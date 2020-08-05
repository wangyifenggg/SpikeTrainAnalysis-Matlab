function [] = drawProbabilityDensity( data,bin )
%对脉冲时间间隔进行统计，并绘制出概率密度曲线
%   data 所有脉冲时间间隔的数组
%   bin 采样间隔

[M ,N]=size(data);
if M~=1
    disp('Error:Wrong Size!');
    return;
end
Max=floor(max(data))+1;
Min=floor(min(data));
L=floor((Max-Min)/bin)+1;
step_time_st=zeros(1,L);

for i=1:N
    k=floor((data(1,i)-Min)/bin)+1;
    step_time_st(1,k)=step_time_st(1,k)+1;    
end
density=step_time_st/(bin*N);
x=linspace(Min,Max,L);
%plot(x,log(step_time_density));
plot(x,density);
end