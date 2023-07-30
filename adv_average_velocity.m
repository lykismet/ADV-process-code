function [ave_vel, time,  CI95]=adv_average_velocity(vel,ave_t,samplerate,start_datenum,burst_length)
%% calculate the average velocity in speicific average time
%vel  rawdata of velocity in m*n ,m is raw numbers per cell, n is the cells
%     column numeber
% ave_t  configure the average time ,unit:minuts  <=5
%samplerate  32
%start_datenum  
%vel_time  unit : minuts


samnum=ave_t*60*samplerate;  %sample number per average time;
groups=floor(size(vel,1)/samnum*2);
if groups>2
    for i=1:groups-1
        ave_vel(i,1:size(vel,2))=mean(vel((i-1)*samnum/2+1:(i+1)*samnum/2,:),1);  %average velocity
        CI95(i,1:size(vel,2))=1.96*var(vel((i-1)*samnum/2+1:(i+1)*samnum/2,:),1,1);
    end

    %time_ave_v_CI95=cat(2,t(:),ave_v(:),CI95(:));
else
    time_ave_v_CI95=cellstr({'平均时间太长，数据不足，出错'});
end


%calculate the respongding time series
ave_day=ave_t/60/24;
t1=[start_datenum+ave_day/2:ave_day/2:start_datenum+(groups-1)*ave_day/2]';
for j=0:size(vel,2)-1
    time(:,j+1)=t1(:,1)+burst_length/60/24*j;
end

end