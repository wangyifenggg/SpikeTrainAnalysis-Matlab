function [ y1 ] = getISI( y )
%����������
%   y ԭʼ�ṹ��
%   y1 �����������Ľṹ��
[~ ,N]=size(y.time);
n=1;
for i=1:N
        y1.channel(1,n)=y.channel(1,i);
        y1.time(1,n)=y.time(1,i);
        y1.height(1,n)=y.height(1,i);
        y1.width(1,n)=y.width(1,i);
        y1.context(:,n)=y.context(:,i);
        y1.thresh(1,n)=y.thresh(1,i);
        %������ʱ��
        if n>=2
            y1.step_time(1,n)=y1.time(1,n)-y1.time(1,n-1);
        else
            y1.step_time(1,n)=y1.time(1,n);
        end
        n=n+1;
    
end
if n==1
    y1.is_Exist=0;
else
    y1.is_Exist=1;
end

end

