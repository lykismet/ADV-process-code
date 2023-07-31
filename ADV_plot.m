clear all; clc;
cd('E:\2020Jul\ADV-aquadripod-s1\ADV-HARD\process');
% load('E:\2020Jul\ADV-aquadripod-s1\ADV-HARD\process\data_down.mat');
% load('E:\2020Jul\ADV-aquadripod-s1\ADV-HARD\process\data_up.mat');
load('E:\2020Jul\ADV-aquadripod-s1\ADV-HARD\process\adv_meanvel_down');
load('E:\2020Jul\ADV-aquadripod-s1\ADV-HARD\process\adv_meanvel_up');
subplot(2,1,1)
    h11=plot(adv_meanvel_down(:,1),adv_meanvel_down(:,2),'linestyle','-','color','r','linewidth',2,...
        'marker','d','markersize',8,'markeredgecolor','r','markerfacecolor','r',...
        'markerindices',1:20:length(adv_meanvel_down(:,1)));
    hold on;
    h12=plot(adv_meanvel_down(:,1),adv_meanvel_down(:,3),'linestyle','-','color','b','linewidth',2,...
        'marker','^','markersize',8,'markeredgecolor','b','markerfacecolor','b',...
        'markerindices',1:20:length(adv_meanvel_down(:,1)));
    ax1=gca;
    %设置子图位置
    ax1.Position=[0.2,0.7,0.7,0.25];
    % x、y轴范围
    ax1.XLim=[datenum(2020,7,15,15,0,0),datenum(2020,7,17,15,0,0)];
    ax1.YLim=[-0.4,0.4];
    % x、y轴刻度
    ax1.XTick=datenum(2020,7,15,15,0,0):datenum(0,0,0,8,0,0):datenum(2020,7,17,15,0,0);
    ax1.YTick=[-0.4:0.2:0.4];
    %刻度属性
    [ax1.XAxis.MinorTick,ax1.YAxis.MinorTick]=deal('on');
    ax1.TickLength = [0.01,0.025];  %主辅刻度长度
    ax1.TickDir='in';  %刻度方向
    %背景色
    ax1.Color='#F0F8FF';
    %设置轴标题
    ax1.XLabel.String='Time';
    ax1.YLabel.String='Vel.(m/s)';
    ax1.YLabel.Position=[ax1.XLim(1)-(ax1.XLim(2)-ax1.XLim(1))*0.05,(ax1.YLim(2)+ax1.YLim(1))/2,-1];
    [ax1.XLabel.FontName,ax1.YLabel.FontName]=deal('Times new Roman');
    [ax1.XLabel.FontSize,ax1.YLabel.FontSize]=deal(18);
    [ax1.XLabel.FontWeight,ax1.YLabel.FontWeight]=deal('bold');
    %设置坐标轴及标签属性
    ax1.XAxis.TickLabels=datestr(ax1.XTick,'mm/dd HH:MM');%datestr(ax1.XTick,'mm/dd HH:MM');
    [ax1.XAxis.TickLabelRotation,ax1.YAxis.TickLabelRotation]=deal(0,0);
    [ax1.XAxis.Color,ax1.YAxis.Color]=deal('k');
    [ax1.XAxis.FontSize,ax1.YAxis.FontSize]=deal(16);
    [ax1.XAxis.FontName,ax1.YAxis.FontName]=deal('Times new Roman');
    [ax1.XAxis.FontWeight,ax1.YAxis.FontWeight]=deal('bold');
    %[ax.XAxis.MinorTick,ax.YAxis.MinorTick]=deal('on');

    hL1=legend;
    hL1.String={'EastVel','NorthVel'};
    hL1.Position=[ax1.Position(1)+0.85*ax1.Position(3),ax1.Position(2)+0.72*ax1.Position(4),0.1*ax1.Position(3),0.1*ax1.Position(4)];
    hL1.FontName='Times';
    hL1.FontSize=12;
    hL1.FontWeight='bold';
    hL1.EdgeColor='k';
    hT1=text(0.8,0.92,'Vel. from ADV at 0.4mab','Units','normalized','FontSize',16);

subplot(2,1,2)
    h21=plot(adv_meanvel_up(:,1),adv_meanvel_up(:,2),'linestyle','-','color','r','linewidth',2,...
        'marker','d','markersize',8,'markeredgecolor','r','markerfacecolor','r',...
        'markerindices',1:20:length(adv_meanvel_up(:,1)));
    hold on;
    h22=plot(adv_meanvel_up(:,1),adv_meanvel_up(:,3),'linestyle','-','color','b','linewidth',2,...
        'marker','^','markersize',8,'markeredgecolor','b','markerfacecolor','b',...
        'markerindices',1:20:length(adv_meanvel_up(:,1)));
    ax2=gca;
    %设置子图位置
    ax2.Position=[0.2,0.3,0.7,0.25];
    % x、y轴范围
    ax2.XLim=[datenum(2020,7,15,15,0,0),datenum(2020,7,17,15,0,0)];
    ax2.YLim=[-0.4,0.4];
    % x、y轴刻度
    ax2.XTick=datenum(2020,7,15,15,0,0):datenum(0,0,0,8,0,0):datenum(2020,7,17,15,0,0);
    ax2.YTick=[-0.4:0.2:0.4];
    %刻度属性
    [ax2.XAxis.MinorTick,ax2.YAxis.MinorTick]=deal('on');
    ax2.TickLength = [0.01,0.025];  %主辅刻度长度
    ax2.TickDir='in';  %刻度方向
    %背景色
    ax2.Color='#F0F8FF';
    %设置轴标题
    ax2.XLabel.String='Time';
    ax2.YLabel.String='Vel.(m/s)';
    ax2.YLabel.Position=[ax2.XLim(1)-(ax2.XLim(2)-ax2.XLim(1))*0.05,(ax2.YLim(2)+ax2.YLim(1))/2,-1];
    [ax2.XLabel.FontName,ax2.YLabel.FontName]=deal('Times new Roman');
    [ax2.XLabel.FontSize,ax2.YLabel.FontSize]=deal(18);
    [ax2.XLabel.FontWeight,ax2.YLabel.FontWeight]=deal('bold');
    %设置坐标轴及标签属性
    ax2.XAxis.TickLabels=datestr(ax2.XTick,'mm/dd HH:MM');%datestr(ax1.XTick,'mm/dd HH:MM');
    [ax2.XAxis.TickLabelRotation,ax2.YAxis.TickLabelRotation]=deal(0,0);
    [ax2.XAxis.Color,ax2.YAxis.Color]=deal('k');
    [ax2.XAxis.FontSize,ax2.YAxis.FontSize]=deal(16);
    [ax2.XAxis.FontName,ax2.YAxis.FontName]=deal('Times new Roman');
    [ax2.XAxis.FontWeight,ax2.YAxis.FontWeight]=deal('bold');
    %[ax.XAxis.MinorTick,ax.YAxis.MinorTick]=deal('on');

    hL2=legend;
    hL2.String={'EastVel','NorthVel'};
    hL2.Position=[ax2.Position(1)+0.85*ax2.Position(3),ax2.Position(2)+0.72*ax2.Position(4),0.1*ax2.Position(3),0.1*ax2.Position(4)];
    hL2.FontName='Times';
    hL2.FontSize=12;
    hL2.FontWeight='bold';
    hL2.EdgeColor='k';
    hT2=text(0.8,0.92,'Vel.from ADV at 1.35mab','Units','normalized','FontSize',16);
    
