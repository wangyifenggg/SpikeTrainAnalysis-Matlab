function [ x,cov ] = getSpikeCov( y1,y2 )
%计算两个脉冲时间序列的时间相关性
%   y1 第一个脉冲时间序列
%   y2 第二个脉冲时间序列
%   cov 相关序列

if y1.is_Exist==0 ||y2.is_Exist==0    
    cov=0;
    disp('Error:Empty Spike！！')
    return
end
[~,N_1]=size(y1.time);
[~,N_2]=size(y2.time);
% M_1=floor(min(N_1,N_2)/100)*100;
% if M_1==0
%     corl=0;
%     return;
% end
% end_time=floor(y1_1.time(1,M_1))+1;
% [~,M_2] = min(abs(y1_2.time-end_time));

bin=0.1;
L=100;
spike_d=zeros(N_1,2*L+1);
for i=1:N_1
    ref=y1.time(1,i);
    for j=1:N_2
        delta=y2.time(1,j)-ref;
        if delta>=-L*bin && delta<=L*bin
            k=floor(delta/bin)+1+L;
            spike_d(i,k)=spike_d(i,k)+1;
        end
    end
end
cov=sum(spike_d,1);
cov=cov*100/(sqrt(N_1)*sqrt(N_2));
x=-bin:0.001:bin;

end

