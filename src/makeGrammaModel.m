function [ K,R ] = makeGrammaModel( y )
%��٤��ֲ��������ʱ�����ֲ�
%   y ԭ���ݽṹ��
%   K ٤��ֲ��ĵ�һ������
%   R ٤��ֲ��ĵڶ�������

[~,N]=size(y.step_time);
mu=mean(y.step_time);
L=floor(N/2);
CV2=zeros(1,L);
for i=1:L
    CV2(1,i)=2*abs(y.step_time(1,2*i)-y.step_time(1,2*i-1))/(y.step_time(1,2*i)+y.step_time(1,2*i-1));
end
CV2_2=CV2*CV2'/N;
K=2/CV2_2-0.5;
R=mu/K;




end