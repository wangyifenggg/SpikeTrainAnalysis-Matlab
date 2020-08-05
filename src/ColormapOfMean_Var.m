function [ ] = ColormapOfMean_Var( y )
%画出各通道频率均值和脉冲时间间隔方差
m_map_V=ones(1,60)*10000;
s_map_V=zeros(1,60);
[y1]=getExcitatoryISI( y );
for i=1:60    
    [y2]=getChannelISI( y1,i-1 );
    if y2.is_Exist==1      
        m_map_V(1,i)=mean(y2.step_time);
        s_map_V(1,i)=var(y2.step_time,0,2);
    end
end

m_map=zeros(8,8);
s_map=zeros(8,8);
for i=1:60
    [c,r]=hw2cr(i-1);
    m_map(r,c)=1/(m_map_V(1,i));
    s_map(r,c)=s_map_V(1,i);
end
%imagesc(m_map_V);
figure(10);

imagesc(m_map);
title('频率均值');
colorbar;

figure(11);
imagesc(s_map);
title('时间间隔方差');

colorbar;

end

