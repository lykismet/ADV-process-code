function [mpsta,despnum]=despike(orig,q)

x=size(orig,1);
um=sqrt(2*log(x));% ͨ����ֵ
list=size(orig);%Ҫ��������ݵ�����������

for n=1:list(1,2)
    cn=10;    %ȥë�̵ĳ���ѭ������
    a1=orig(:,n); % ����Ҫ��������ݸ�ֵ��a1
    [c,l]=wavedec(a1,q,'db5');%С���任�����Ƶ��
    a5=wrcoef('a',c,l,'db5',q);%��С���任ȡ����Ƶ���ݣ���Ƶ���ݲ���Ҫ����ȥë��
    a=a1-a5;      % aΪ1HZ��������
       while (1);%��ѭ������Զִ�У�����break
           counter=0;
           a(1,2)=a(2,1)-a(1,1);%������β���һ�ס����׵�������β�㵼���ļ��㷽ʽֵ��˼��
           a(x,2)=a(x,1)-a((x-1),1);
           a(1,3)=a(2,2)-a(2,1);
           a(x,3)=a(x,2)-a(x,1);
           for j=2:(x-1) %�����м���һ�ס����׵���
               a(j,2)=(a(j+1,1)-a(j-1,1))/2;
               a(j,3)=(a(j+1,2)-a(j-1,2))/2;
           end
           b=cov(a);%Э�������
           [ev,e]=eigs(b);%���Э��������������������ev��������ֵ��б�ԽǾ���e
           rota=a*ev; %������ת�������(�Ӽ���Ӱ�䣩
           axis(1,1)=sqrt(e(1,1))*um;
           axis(2,1)=sqrt(e(2,2))*um;
           axis(3,1)=sqrt(e(3,3))*um;%������Բ�����С�����
           for i=1:x
               if (rota(i,1).^2/axis(1,1).^2+rota(i,2).^2/axis(2,1).^2+rota(i,3).^2/axis(3,1).^2>1);  %ë�̵�λ��������
                   counter=counter+1; % ��¼ë�̵�ĸ�����������ѭ���Ƿ�����
                   if i==1 ;
                       a(i,1)=mean(a(:,1));  % ����ǵ�һ��ֵΪë�̣��ͽ��丳ֵΪƽ��ֵ.
                   else
                       a(i,1)=a(i-1,1); % ��2�����һ���㣬���ж�Ϊë�̣�����ǰһ�������
                   end;
               end
           end
           cn=cn+1;%����ѭ������+1
           desnum(cn,1)=counter;%��¼���һ�ε�ë�̵����
           
         if (counter==0 || (desnum(cn-10)==desnum(cn)&&desnum(cn-7)==desnum(cn)&&desnum(cn-5)==desnum(cn)&&desnum(cn-3)==desnum(cn)&&desnum(cn-9)==desnum(cn)&&desnum(cn-8)==desnum(cn)&&desnum(cn-6)==desnum(cn)))
                break;       %ë�̵����Ϊ0�򲻱�ʱֹͣѭ��
          end
              despnum(1,n)=desnum(cn,1);%������ë�̵����
       end
          
           mpsta(:,n)=a(:,1)+a5;%�ӻ�ԭ�����ݵĵ�Ƶ����
           t=find(orig(:,n)-mpsta(:,n));
           d=size(t);%ԭʼ������ë�̵�ĸ���
           despnum(2,n)=d(1,1);%ԭʼ������ë�̵�ĸ����ʹ�����ë�̵����
           
end
end