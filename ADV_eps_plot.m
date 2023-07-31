clear all;close all;clc;
path='E:\2021sysu\S1\Quadripod\ADV_down\process';
load([path,'\adv_vel.mat']);
u=vel.u;
v=vel.v;
wt=vel.wt;
record_start=datenum(2021,7,23,14,0,0);  %仪器开始记录时间
record_end=datenum(2021,7,25,19,01,39);  %仪器结束记录时间
start_time=datenum(2021,7,23,17,0,0);    %提取数据的开始时间
end_time=datenum(2021,7,25,17,30,0);      %提取数据的结束时间
samplerate=32;                           %采样频率
burst_length=15;                         %burst时长 min
burst_datanum=9600;                      %每个burst中测得的数据个数
time_series=[record_start:datenum(0,0,0,0,burst_length,0):record_end];
burst_num=find(time_series>=start_time&time_series<=end_time);
time=time_series(1,burst_num);


c=colormap(jet(size(burst_num,2)));
mflowd=mean(sqrt(u.^2+v.^2));
burst=wt;
time_tag=[];
for kk=1:10:size(wt,2)
time_tag=[time_tag,{datestr(time(:,kk),'mm/dd HH:MM')}];
len=length(burst(:,kk));
[obs_spe,f]=pwelch(burst(:,kk),[],[],len/5,samplerate);
st_fre=[0.2:0.1:2.0];
en_fre=[2.0:0.5:12];
for i=1:size(st_fre,2)
    for j=1:size(en_fre,2)
        fit_range=find(f<=en_fre(1,j) & f>=st_fre(1,i));
        f_fit=[ones(size(fit_range,1),size(fit_range,2)) log10(f(fit_range))];
        spec_fit=log10(obs_spe(fit_range));
        [b,~,~,~,R]=regress(spec_fit,f_fit);
        a0(i,j)=b(1,1);
        a1(i,j)=b(2,1);
        r(i,j)=R(1,1);
        clear fit_range f_fit spec_fit b R
    end
end
[m,n]=find(r>0.80);
if isempty(m)||isempty(n)
    ep(:,kk)=nan;
    Relative(:,kk)=nan;
    xielv(:,kk)=nan;
    k1(:,kk)=nan;
    k2(:,kk)=nan;
else
    for tt=1:size(m,1)
        fuhe(tt,1)=abs(a1(m(tt,1),n(tt,1))+5/3);
    end
        if min(fuhe)>0.2
            ep(:,kk)=nan;
            Relative(:,kk)=nan;
            xielv(:,kk)=nan;
            k1(:,kk)=nan;
            k2(:,kk)=nan;
        else
            mm=m(find(fuhe==min(fuhe)),1);
            nn=n(find(fuhe==min(fuhe)),1);

            xiaxian(:,kk)=st_fre(1,mm);
            shangxian(:,kk)=en_fre(1,nn);
            fit_range=find(f<=shangxian(:,kk) & f>=xiaxian(:,kk));
            f_fit=f(fit_range);
            k1(:,kk)=f_fit(1,1);
            k2(:,kk)=f_fit(end,1);
            spec_fit=obs_spe(fit_range);
            Relative(:,kk)=r(mm,nn);
            xielv(:,kk)=a1(mm,nn);
            fun = @(a,xdata)(-5/3)*(xdata)+a;
            a=lsqcurvefit(fun,0,log10(f_fit),log10(spec_fit));
            b=10.^a;
            ep(:,kk)=b^1.5*0.71^(-1.5)*2*pi/mflowd(:,kk);


        if ~isnan(ep(:,kk))
            est_spec=(log10(f_fit))*(-5/3)+a;
            est_spec=10.^est_spec;
            h=loglog(f,obs_spe,'color',c(kk,:),'linewidth',1);
            hold on;
            loglog(f_fit,spec_fit,'color','#330033','linewidth',1,'HandleVisibility','off');
            %loglog(f_fit,est_spec,'color',c(kk,:),'linewidth',3,'HandleVisibility','off');
            
        end
            clear obs_spe f fit_range f_fit spec_fit est_spec mm nn a1 r m n fuhe
            
   end
end
end
ax=gca;
ax.Color='#F0F8FF';
ax.XLim=[0.01,100];
ax.YLim=[10^-8,10^-2];
[ax.XAxis.MinorTick,ax.YAxis.MinorTick]=deal('on');
ax.TickLength = [0.025,0.05];  %主辅刻度长度
ax.TickDir='in';  %刻度方向
ax.XLabel.String='Frequence (Hz)';
ax.YLabel.String='(m^{2}s^{-2})/Hz';
[ax.XLabel.FontName,ax.YLabel.FontName]=deal('Times new Roman');
[ax.XLabel.FontSize,ax.YLabel.FontSize]=deal(18);
[ax.XLabel.FontWeight,ax.YLabel.FontWeight]=deal('bold');
ax.XTick=[10^-2,10^-1,10^0,10^1,10^2];
ax.XAxis.TickLabels={'10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'};
[ax.XAxis.FontSize,ax.YAxis.FontSize]=deal(18);
[ax.XAxis.FontName,ax.YAxis.FontName]=deal('Times new Roman');
[ax.XAxis.FontWeight,ax.YAxis.FontWeight]=deal('bold');
ax.XGrid='on';
ax.YGrid='on';
ax.GridAlpha=0.3;
hL=legend;
hL.String=time_tag;
hL.FontName='Times';
hL.FontSize=12;
hL.FontWeight='bold';
hold on
addpath 'F:\技术贴\export_fig'
export_fig 'E:\2021sysu\S1\Quadripod\ADV_down\process\eps.tif -r300'

