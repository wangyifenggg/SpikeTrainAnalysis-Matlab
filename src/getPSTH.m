function [ x,spike_after_sti ] = getPSTH( y,s_c,bin )
%记录某个通道相对刺激后的时间
%   y 刺激数据源
%   s_c 刺激的通道
%   bin 统计的间隔
[~,M]=size(y.time);
%提取出刺激时间,有2800个刺激
%sti_time=zeros(1,2800);
n=1;
for i=1:M
    if y.channel(1,i)==60
        sti_time(1,n)=y.time(1,i);
        n=n+1;
    end
end
if ((s_c==14) | (s_c==31) | (s_c==37) | (s_c==43))
    spike_after_sti=0;
    return;
end

k1=0;
if s_c>=14
    k1=k1+1;
end
if s_c>=31
    k1=k1+1;
end
if s_c>=37
    k1=k1+1;
end
if s_c>=43
    k1=k1+1;
end

[~,M1]=size(sti_time);%M1=2800
sti_time_c=zeros(1,M1/56);%只用了56个通道进行刺激
k2=0;
k3=1;
for i=1:M1
    k2=mod(i,56)-1;    
    if s_c==k2+k1
        sti_time_c(1,k3)=sti_time(1,i);
        k3=k3+1;
    end
end

STI_STEP=sti_time(1,2)-sti_time(1,1);
L=floor(STI_STEP/bin);
[~,M2]=size(sti_time_c);
n1=1;%刺激计数器
spike_after_sti=zeros(1,L+1);
%遍历所有刺激时间
for i=1:M
    if y.time(1,i)>sti_time_c(1,n1) & y.time(1,i)<sti_time_c(1,n1)+STI_STEP
%         if y.channel(1,i)==o_c
            k=floor((y.time(1,i)-sti_time_c(1,n1))/bin)+1;
            spike_after_sti(1,k)=spike_after_sti(1,k)+1;
%         end        
    end
    if y.time(1,i)>sti_time_c(1,n1)+STI_STEP & n1<M2
        n1=n1+1;
    end
end
spike_after_sti=spike_after_sti/M2;
x=0:bin:L*bin;
end

