%% 提取DAT文件中的burst

function [burst1,burst2,burst3]=extract(dat,x,y,z,a)%a为每个burst中的个数，x，y，z为待提取的列参数


count=size(dat(:,1));
n=floor(count(1,1)/a);%burst个数

burst1=zeros(a,n);
burst2=zeros(a,n);
burst3=zeros(a,n);

for i=1:n
    burst1(:,i)=dat((i-1)*a+1:i*a,x);%提取结果为，行是a行，列数burst个数列
    burst2(:,i)=dat((i-1)*a+1:i*a,y);
    burst3(:,i)=dat((i-1)*a+1:i*a,z);
    
end
end
