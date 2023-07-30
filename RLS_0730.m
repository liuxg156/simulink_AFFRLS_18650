%%Liuxg_20230730_AFFRLS
clc;
clear;
data1=readtable('小q马里兰大学18650增量电流HPPC数据.xlsx');
I_HPPC=table2array(data1(:,1));
V_HPPC=table2array(data1(:,2));
Cq=-sum(sum(I_HPPC(I_HPPC<=0)))/3600;
t=length(I_HPPC);
t_HPPC=1:t;
k=0;
for i=1:t-1
    if abs(I_HPPC(i)-I_HPPC(i+1))>0.1
        k=k+1;
        V_OCV(k)=V_HPPC(i);
        t_OCV(k)=t_HPPC(i);
        I_OCV(k)=I_HPPC(i);
    else
        continue;
    end
end
i=1;
while i<=length(I_OCV)
    if abs(I_OCV(i))>=0.5
        V_OCV(i)=[];
        t_OCV(i)=[];
        I_OCV(i)=[];
        i=i-1;
    end
    i=i+1;
end
V_OCV=[V_OCV,V_HPPC(end)];
t_OCV=[t_OCV,t_HPPC(end)];
V_OCV=[4.166,V_OCV];
SOC=1:-0.1:0;
index=10;
f_OCV=polyfit(SOC,V_OCV,index);
%%
I_HPPC=[t_HPPC' I_HPPC];
V_HPPC=[t_HPPC' V_HPPC];