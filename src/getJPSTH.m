function [x,J] = getJPSTH(y,s_c1,s_c2,bin)
%���JPSTH����
%s_c1 ��¼�ĵ�һ��ͨ��
%s_c2 ��¼�ĵڶ���ͨ��
%bin ֱ��ͼ���

[~,M]=size(y.time);
n=1;
for i=1:M
    if y.channel(1,i)==60
        sti_time(1,n)=y.time(1,i);
        n=n+1;
    end
end
if ((s_c1==14) | (s_c1==31) | (s_c1==37) | (s_c1==43))
    J=0;
    return;
end
if ((s_c2==14) | (s_c2==31) | (s_c2==37) | (s_c2==43))
    J=0;
    return;
end
k1=0;
switch s_c1
    case num2cell(14:30)
        k1=1;
    case num2cell(31:36)
        k1=2;
    case num2cell(37:42)
        k1=3
    case num2cell(43:59)
        k1=4;
    otherwise
        k1=0;
end

k2=0;
switch s_c1
    case num2cell(14:30)
        k2=1;
    case num2cell(31:36)
        k2=2;
    case num2cell(37:42)
        k2=3
    case num2cell(43:59)
        k2=4;
    otherwise
        k2=0;
end

[~,M1]=size(sti_time);%M1=2800
sti_time_c1=zeros(1,M1/56);%ֻ����56��ͨ�����д̼�����һ���̼�ͨ��������ʱ��
k3=1;
for i=1:M1       
    if s_c1==mod(i,56)-1+k1
        sti_time_c1(1,k3)=sti_time(1,i);
        k3=k3+1;
    end
end

sti_time_c2=zeros(1,M1/56);%ֻ����56��ͨ�����д̼����ڶ����̼�ͨ��������ʱ��
k4=1;
for i=1:M1       
    if s_c1==mod(i,56)-1+k2
        sti_time_c2(1,k4)=sti_time(1,i);
        k4=k4+1;
    end
end

STI_STEP=sti_time(1,2)-sti_time(1,1);
L=floor(STI_STEP/bin);
[~,M2]=size(sti_time_c1);
[~,M3]=size(sti_time_c2);
n1=1;%��һ��ͨ���Ĵ̼�������
n2=1;%�ڶ���ͨ���Ĵ̼�������
J=zeros(L+1,L+1);

for n=1:M2
    ref1=sti_time_c1(1,n);
    ref2=sti_time_c2(1,n);
    for i=1:M
        if y.time(1,i)>ref1 & y.time(1,i)<ref1+STI_STEP
            u=floor((y.time(1,i)-ref1)/bin)+1;
            for j=1:M
                if y.time(1,j)>ref2 & y.time(1,j)<ref2+STI_STEP
                    v=floor((y.time(1,j)-ref2)/bin)+1;
                    J(u,v)=J(u,v)+1;
                elseif y.time(1,j)>=ref2+STI_STEP
                    break;
                end
            end
        elseif y.time(1,i)>=ref1+STI_STEP
            break;
        end
            
    end
end

J=J/M2;
x=0:bin:L*bin;


end