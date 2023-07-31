function [ep,Relative,xielv,k1,k2]=adv_eps2(burst,fs,mflow,fig)

for kk=1:size(burst,2)
    len=length(burst(:,kk));
    [obs_spe,f]=pwelch(burst(:,kk),[],[],len/5,fs);
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
            ep(:,kk)=b^1.5*0.71^(-1.5)*2*pi/mflow(:,kk);
        
        
            if kk==fig
            figure;
            est_spec=(log10(f_fit))*(-5/3)+a;
            est_spec=10.^est_spec;
            loglog(f,obs_spe,'b');hold on;
            loglog(f_fit,spec_fit,'r');hold on;
            loglog(f_fit,est_spec,'k','linewidth',2);
            xlim([0 fs/2]);
            xlabel('Frequence (Hz)','fontsize',14);
            ylabel('(m2s-2)/Hz','fontsize',14);
            set(gca,'fontsize',14);
            hold on
            end
            clear obs_spe f fit_range f_fit spec_fit est_spec mm nn a1 r m n fuhe
        end
    end
end
end