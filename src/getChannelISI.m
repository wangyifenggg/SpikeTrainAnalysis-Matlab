function [ y1 ] = getChannelISI( y,c )
%�����ͨ�������ݣ�����������  
%c Ϊͨ��
%y ԭ���ݽṹ��
%y1 ͨ�����������ݽṹ��
 
[~ ,N]=size(y.time);
t=1;
y1.Channel=c;
for i=1:N
    if y.channel(1,i)==c
        y1.channel(1,t)=y.channel(1,i);
        y1.time(1,t)=y.time(1,i);
        y1.height(1,t)=y.height(1,i);
        y1.width(1,t)=y.width(1,i);
        y1.context(:,t)=y.context(:,i);
        y1.thresh(1,t)=y.thresh(1,i);
        %������ʱ��
        if t>=2
            y1.step_time(1,t)=y1.time(1,t)-y1.time(1,t-1);
        else
             y1.step_time(1,t)=y1.time(1,t);
        end 
        t=t+1;        
    end
end

if t==1
    y1.is_Exist=0;
else
    y1.is_Exist=1;
end

end
