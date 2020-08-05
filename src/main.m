%运行脚本的例子

N=30000;
BIN=0.01;
C52_BIN=0.1;
y=loadspike('..\data\spontaneous\1-1-5.spike',N);
figure(1);
[ y1 ] = getISI( y );
[ y2 ] = getExcitatoryISI( y );
drawHistogram( y1.step_time , BIN );
hold on;
drawHistogram( y2.step_time , BIN );
title('全部脉冲的脉冲间隔和兴奋性脉冲的脉冲间隔分布对比');

figure(2);
[ y3 ] = getChannelISI( y2,52 );
drawHistogram( y3.step_time , C52_BIN );
hold on;
mu=mean( y3.step_time);
f1=exprnd(mu,1,N);
drawHistogram( f1 , C52_BIN );
title('通道52的脉冲间隔分布直方图和指数分布直方图对比');

figure(3);
[ K,R ] = makeGrammaModel( y3 );
x=0:0.01:max(y1.step_time)+1;
f=gampdf(x,K,R);
plot(x,f);
hold on;
drawProbabilityDensity( y3.step_time ,BIN );
title('通道52的脉冲间隔概率密度和伽马模型的概率密度对比');

figure(4)
[ x2,f2 ] = makeNonhomogeneousModel( y3 );
plot(x2,f2);
hold on;
drawProbabilityDensity( y3.step_time ,BIN );
hold on;
mu=mean( y3.step_time);
f3=exppdf(x2,mu);
plot(x2,f3);
title('通道52的脉冲间隔概率密度和指数分布概率密度和非齐次模型概率密度对比');

figure(5);
[ y4 ] = getChannelISI( y1,7 );
[ y5 ] = getChannelISI( y1,17 );
[ x3,cov ] = getSpikeCov( y4,y5 );
plot(x3,cov);
title('通道7和通道17的互相关性');

figure(6);
s=loadspike('..\data\stimulus-evoked\1-1-4.spike',N);
[ x4,s1 ] = getPSTH( s,3,0.02 );
bar(x4,s1);
title('通道3的PSTH图')

figure(7);
[ x5,s2 ] = getPSTH( s,4,0.02 );
bar(x5,s2);
title('通道4的PSTH图')

figure(8);
[x6,j]=getJPSTH(s,3,4,0.02);
imagesc(x6,x6,j);
title('通道3和通道4的JPSTH图')

figure(9);
cov_t=s1'*s2;
imagesc(x6,x6,j-cov_t);
title('修正的通道3和通道4的JPSTH图')
%各通道的频率均值和时间间隔方差
ColormapOfMean_Var( y );

