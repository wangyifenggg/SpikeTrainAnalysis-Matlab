function [ y1 ] = getExcitatoryISI( y )
%��ȡ���˷�����,������������
%y ԭ���ݽṹ��
%y1 ֻ�����˷�����������ݽṹ��
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
        %������ʱ��
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