%% load raw data
clear all; clc;warning off
% dat=textread('E:\2021sysu\S1\Quadripod\ADV_down\data\S1down02.dat');  %读取原始数据
cd('E:\2021sysu\S1\Quadripod\ADV_down\process');
% save('data_down.mat','dat');
load('E:\2021sysu\S1\Quadripod\ADV_down\process\data_down.mat');
%%   设置时间，挑选burst序列

record_start=datenum(2021,7,23,14,0,0);  %仪器开始记录时间
record_end=datenum(2021,7,25,19,01,39);  %仪器结束记录时间
start_time=datenum(2021,7,23,17,0,0);    %提取数据的开始时间
end_time=datenum(2021,7,25,17,30,0);      %提取数据的结束时间
samplerate=32;                           %采样频率
burst_length=15;                         %burst时长 min
burst_datanum=9600;                      %每个burst中测得的数据个数
time_series=[record_start:datenum(0,0,0,0,burst_length,0):record_end];
burst_num=find(time_series>=start_time&time_series<=end_time);



%% despike & get fluctuation
[snr_cor_num,snr_cor_index,u_raw,v_raw,w_raw]=snr_cor_validity(dat,burst_num,burst_datanum);
[u,dipnum_ud]=despike(u_raw,1);    %despike(raw data, cut-off frequency);
[v,dipnum_vd]=despike(v_raw,1);
[w,dipnum_wd]=despike(w_raw,1);
[ut,vt,wt]=get_fluctuation(u,v,w);

vel=struct('u',u,'v',v,'w',w,'wt',wt);
save('adv_vel.mat','vel');
%% 

%calculate the average velocity
%平均时长
ave_t=2;    %平均时：min

[ave_u, ave_time,  ~]=...
    adv_average_velocity(u,ave_t,samplerate,start_time,burst_length);
[ave_v, ~,  ~]=...
    adv_average_velocity(v,ave_t,samplerate,start_time,burst_length);
[ave_w, ~,  ~]=...
    adv_average_velocity(w,ave_t,samplerate,start_time,burst_length);
adv_meanvel=cat(2,ave_time(:),ave_u(:),ave_v(:),ave_w(:));
save('adv_meanvel_down.mat','adv_meanvel');



%% calculate the tubulent dissipation
mflow=mean(sqrt(u.^2+v.^2));
[epsd,Relatived,xielvd,k1d,k2d]=adv_eps2(wt,samplerate,mflow,45);
