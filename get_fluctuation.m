function [ut,vt,wt]=get_fluctuation(u,v,w)

for i=1:size(u,2)
    ut(:,i)=u(:,i)-mean(u(:,i));
    vt(:,i)=v(:,i)-mean(v(:,i));
    wt(:,i)=w(:,i)-mean(w(:,i));
end

end
