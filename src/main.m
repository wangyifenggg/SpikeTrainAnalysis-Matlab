%���нű�������

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
title('ȫ����������������˷���������������ֲ��Ա�');

figure(2);
[ y3 ] = getChannelISI( y2,52 );
drawHistogram( y3.step_time , C52_BIN );
hold on;
mu=mean( y3.step_time);
f1=exprnd(mu,1,N);
drawHistogram( f1 , C52_BIN );
title('ͨ��52���������ֲ�ֱ��ͼ��ָ���ֲ�ֱ��ͼ�Ա�');

figure(3);
[ K,R ] = makeGrammaModel( y3 );
x=0:0.01:max(y1.step_time)+1;
f=gampdf(x,K,R);
plot(x,f);
hold on;
drawProbabilityDensity( y3.step_time ,BIN );
title('ͨ��52�������������ܶȺ�٤��ģ�͵ĸ����ܶȶԱ�');

figure(4)
[ x2,f2 ] = makeNonhomogeneousModel( y3 );
plot(x2,f2);
hold on;
drawProbabilityDensity( y3.step_time ,BIN );
hold on;
mu=mean( y3.step_time);
f3=exppdf(x2,mu);
plot(x2,f3);
title('ͨ��52�������������ܶȺ�ָ���ֲ������ܶȺͷ����ģ�͸����ܶȶԱ�');

figure(5);
[ y4 ] = getChannelISI( y1,7 );
[ y5 ] = getChannelISI( y1,17 );
[ x3,cov ] = getSpikeCov( y4,y5 );
plot(x3,cov);
title('ͨ��7��ͨ��17�Ļ������');

figure(6);
s=loadspike('..\data\stimulus-evoked\1-1-4.spike',N);
[ x4,s1 ] = getPSTH( s,3,0.02 );
bar(x4,s1);
title('ͨ��3��PSTHͼ')

figure(7);
[ x5,s2 ] = getPSTH( s,4,0.02 );
bar(x5,s2);
title('ͨ��4��PSTHͼ')

figure(8);
[x6,j]=getJPSTH(s,3,4,0.02);
imagesc(x6,x6,j);
title('ͨ��3��ͨ��4��JPSTHͼ')

figure(9);
cov_t=s1'*s2;
imagesc(x6,x6,j-cov_t);
title('������ͨ��3��ͨ��4��JPSTHͼ')
%��ͨ����Ƶ�ʾ�ֵ��ʱ��������
ColormapOfMean_Var( y );

