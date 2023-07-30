function [snr_cor_num,snr_cor_index,u,v,w]=snr_cor_validity(dat,burst_num,burst_datanum)
%计算每个burst中SNR<5或COR<70%的个数
%dat  原始数据
%burst_num  筛选出来的列序号

[snr_u,snr_v,snr_w]=extract(dat,9,10,11,burst_datanum);
[cor_u,cor_v,cor_w]=extract(dat,12,13,14,burst_datanum);
[u,v,w]=extract(dat,3,4,5,burst_datanum);
snr_u=snr_u(:,burst_num);
snr_v=snr_v(:,burst_num);
snr_w=snr_w(:,burst_num);
cor_u=cor_u(:,burst_num);
cor_v=cor_v(:,burst_num);
cor_w=cor_w(:,burst_num);
u=u(:,burst_num);
v=v(:,burst_num);
w=w(:,burst_num);


snr_cor_num=nan(1,size(snr_u,2));
snr_cor_index=[];
for i=1:size(snr_u,2)
    count=0;
    for j=1:size(snr_u,1)
        if snr_u(j,i)<5 || snr_v(j,i)<5 || snr_w(j,i)<5 ||cor_u(j,i)<70 || cor_v(j,i)<70 || cor_w(j,i)<70
            count=count+1;
            snr_cor_index=cat(1,snr_cor_index,[j,i]);
            if j==1
                u(j,i)=(u(j+1,i)+u(j+2,i))/2;
                v(j,i)=(u(j+1,i)+v(j+2,i))/2;
                w(j,i)=(w(j+1,i)+w(j+2,i))/2;
            elseif j==9600
                u(j,i)=(u(j-1,i)+u(j-2,i))/2;
                v(j,i)=(v(j-1,i)+v(j-2,i))/2;
                w(j,i)=(w(j-1,i)+w(j-2,i))/2;
            else
                u(j,i)=(u(j-1,i)+u(j+1,i))/2;
                v(j,i)=(v(j-1,i)+v(j+1,i))/2;
                w(j,i)=(w(j-1,i)+w(j+1,i))/2;
            end
        end
    end
    snr_cor_num(1,i)=count;
    clear count;
end
end