function [ y1 ] = getInhibitoryISI( y )
%提取出抑制脉冲,并计算脉冲间隔
%y 原数据结构体
%y1 只包含兴奋性脉冲的数据结构体
[~ ,N]=size(y.time);
n=1;
for i=1:N
    if y.height(1,i)>0
        y1.channel(1,n)=y.channel(1,i);
        y1.time(1,n)=y.time(1,i);
        y1.height(1,n)=y.height(1,i);
        y1.width(1,n)=y.width(1,i);
        y1.context(:,n)=y.context(:,i);
        y1.thresh(1,n)=y.thresh(1,i);
        %计算间隔时间
        if n>=2
            y1.step_time(1,n)=y1.time(1,n)-y1.time(1,n-1);
        else
            y1.step_time(1,n)=y1.time(1,n);
        end
        n=n+1;
    end
end
if n==1
    y1.is_Exist=0;
else
    y1.is_Exist=1;
end
end