function [ ] = drawHistogram( data , bar_width )
%�����������ݵ�ֱ��ͼ
%   data ��������
%   bin ֱ��ͼ���
if size(data,1)~=1
    disp('Error:Wrong Size!');
    return;
end
h1 = histogram(data);
h1.Normalization='probability';
h1.BinWidth=bar_width;
end

