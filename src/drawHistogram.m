function [ ] = drawHistogram( data , bar_width )
%画出样本数据的直方图
%   data 样本数据
%   bin 直方图间隔
if size(data,1)~=1
    disp('Error:Wrong Size!');
    return;
end
h1 = histogram(data);
h1.Normalization='probability';
h1.BinWidth=bar_width;
end

