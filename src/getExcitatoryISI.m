function [ y1 ] = getExcitatoryISI( y )
%提取出兴奋脉冲,并计算脉冲间隔
%y 原数据结构体
%y1 只包含兴奋性脉冲的数据结构体
[~ ,N]=size(y.time);
p=1;
for i=1:N
    if y.height(1,i)<0
        y1.channel(1,p)=y.channel(1,i);
        y1.time(1,p)=y.time(1,i);
        y1.height(1,p)=y.height(1,i);
        y1.width(1,p)=y.width(1,i);
        y1.context(:,p)=y.context(:,i);
        y1.thresh(1,p)=y.thresh(1,i);
        %计算间隔时间
        if p>=2
            y1.step_time(1,p)=y1.time(1,p)-y1.time(1,p-1);
        else
            y1.step_time(1,p)=y1.time(1,p);
        end
        p=p+1;
    end
end
if p==1
    y1.is_Exist=0;
else
    y1.is_Exist=1;
end
end