function [] = drawProbabilityDensity( data,bin )
%������ʱ��������ͳ�ƣ������Ƴ������ܶ�����
%   data ��������ʱ����������
%   bin �������

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