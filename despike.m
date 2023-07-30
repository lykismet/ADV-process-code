function [mpsta,despnum]=despike(orig,q)

x=size(orig,1);
um=sqrt(2*log(x));% 通用阈值
list=size(orig);%要处理的数据的行数、列数

for n=1:list(1,2)
    cn=10;    %去毛刺的初设循环次数
    a1=orig(:,n); % 将需要处理的数据赋值给a1
    [c,l]=wavedec(a1,q,'db5');%小波变换处理成频域
    a5=wrcoef('a',c,l,'db5',q);%反小波变换取出低频数据，低频数据不需要参与去毛刺
    a=a1-a5;      % a为1HZ以上数据
       while (1);%死循环，永远执行，除非break
           counter=0;
           a(1,2)=a(2,1)-a(1,1);%计算首尾点的一阶、二阶导数，首尾点导数的计算方式值得思考
           a(x,2)=a(x,1)-a((x-1),1);
           a(1,3)=a(2,2)-a(2,1);
           a(x,3)=a(x,2)-a(x,1);
           for j=2:(x-1) %计算中间点的一阶、二阶导数
               a(j,2)=(a(j+1,1)-a(j-1,1))/2;
               a(j,3)=(a(j+1,2)-a(j-1,2))/2;
           end
           b=cov(a);%协方差矩阵
           [ev,e]=eigs(b);%求出协方差矩阵的特征向量矩阵（ev）和特征值（斜对角矩阵）e
           rota=a*ev; %计算旋转后的数据(庞加莱影射）
           axis(1,1)=sqrt(e(1,1))*um;
           axis(2,1)=sqrt(e(2,2))*um;
           axis(3,1)=sqrt(e(3,3))*um;%计算椭圆长、中、短轴
           for i=1:x
               if (rota(i,1).^2/axis(1,1).^2+rota(i,2).^2/axis(2,1).^2+rota(i,3).^2/axis(3,1).^2>1);  %毛刺点位于椭球外
                   counter=counter+1; % 记录毛刺点的个数，用以判循环是否续继
                   if i==1 ;
                       a(i,1)=mean(a(:,1));  % 如果是第一个值为毛刺，就将其赋值为平均值.
                   else
                       a(i,1)=a(i-1,1); % 第2到最后一个点，若判断为毛刺，就用前一点来替代
                   end;
               end
           end
           cn=cn+1;%初设循环次数+1
           desnum(cn,1)=counter;%记录最后一次的毛刺点个数
           
         if (counter==0 || (desnum(cn-10)==desnum(cn)&&desnum(cn-7)==desnum(cn)&&desnum(cn-5)==desnum(cn)&&desnum(cn-3)==desnum(cn)&&desnum(cn-9)==desnum(cn)&&desnum(cn-8)==desnum(cn)&&desnum(cn-6)==desnum(cn)))
                break;       %毛刺点个数为0或不变时停止循环
          end
              despnum(1,n)=desnum(cn,1);%处理后的毛刺点个数
       end
          
           mpsta(:,n)=a(:,1)+a5;%加回原来数据的低频部分
           t=find(orig(:,n)-mpsta(:,n));
           d=size(t);%原始数据中毛刺点的个数
           despnum(2,n)=d(1,1);%原始数据中毛刺点的个数和处理后的毛刺点个数
           
end
end