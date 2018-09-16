clc; close all; clear all;
[xxx,mname]=xlsread('Name Rule.xlsx','C1:C13'); % Motor Name
[xxx,pname]=xlsread('Name Rule.xlsx','D14:D21'); % Propeller Name
%%
% Single Motor Multiple Propeller - 7.4V
E150=zeros(8,1);
Emax=zeros(8,1);
Emin=zeros(8,1);
for i=1:12 % # of Motors
    figure
    %movegui(figure,[420*(i-1) 1180]);
    for j=1:8 % # of Propellers
        A=[96+i 48+j 95 55 46 99 115 118]; % 7.4V
        f=strcat('modifieddata/',char(A));
        %f=strcat('rawdata/',char(A));
        [E150(j),Emax(j),Emin(j)]=Import_Plot_csv(f); % Emax:E for plot
    end
    hold off;
    set(legend,'Fontsize',8);
    legend(pname);
    legend('location','southeast');
    legend boxoff;
    title(strcat(mname(i),'- 7.4V'));
    ylim([0.8*min(Emin),1.1*max(Emax)]);
    y=get(gca,'ylim');
    x=get(gca,'xlim');
    [xxx,k]=max(E150); % Find most efficient one
    text(10+x(1),0.95*y(2),strcat('The Most Efficient @ 150 gf :','{ }',pname(k)));
    set(gcf,'position',[850 850 666 666]);
    temp=[char(strcat(mname(i),'- 7.4V')),'.png'];
    saveas(gca,fullfile('testresults/motorside',temp));
    close;
end
%% 

% Single Motor Multiple Propeller - 11.1V
for i=1:12 % # of Motors
    figure
    %movegui(figure,[420*(i-1) 780]);
    for j=1:8 % # of Propellers
        A=[96+i 48+j 95 49 49 46 99 115 118]; % 11.1V
        f=strcat('modifieddata/',char(A));
        %f=strcat('rawdata/',char(A));
        [E150(j),Emax(j),Emin(j)]=Import_Plot_csv(f); % Emax:E for plot
    end
    hold off;
    set(legend,'Fontsize',8);
    legend(pname);
    legend('location','southeast');
    legend boxoff;
    title(strcat(mname(i),'- 11.1V'));
    ylim([0.8*min(Emin),1.1*max(Emax)]);
    y=get(gca,'ylim');
    x=get(gca,'xlim');
    [xxx,k]=max(E150); % Find most efficient one
    text(10+x(1),0.95*y(2),strcat('The Most Efficient @ 150 gf :','{ }',pname(k)),'Fontsize',8);
    set(gcf,'position',[850 850 666 666]);
    temp=[char(strcat(mname(i),'- 11.1V')),'.png'];
    saveas(gca,fullfile('testresults/motorside',temp));
    close;
end
%% 
% Single Propeller Multiple Motor - 7.4V
E150=zeros(12,1);
Emax=zeros(12,1);
Emin=zeros(12,1);
z=zeros(5,1);
all150=zeros(12,8);
for j=1:8 % # of Propellers
    figure
    %movegui(figure,[420*(j-1) 400]);
    for i=1:12 % # of Motors
        A=[96+i 48+j 95 55 46 99 115 118]; % 7.4V
        f=strcat('modifieddata/',char(A));
        %f=strcat('rawdata/',char(A));
        [E150(i),Emax(i),Emin(i)]=Import_Plot_csv(f); % Emax:E for plot
    end
    hold off;
    legend(mname);
    legend('location','southeast');
    legend boxoff;
    title(strcat(pname(j),'- 7.4V'));
    ylim([0.8*min(Emin),1.1*max(Emax)]);
    y=get(gca,'ylim');
    x=get(gca,'xlim');
    E150s=sort(E150);
    for k=1:5 % find top 5
        z(k)=find(E150==E150s(end-(k-1))); % magnitude corresponds to z is descending
        text(10+x(1),(1-k*0.05)*y(2),strcat('Top','{ }',num2str(k),' Efficient Motors :','{ }',mname(z(k))),'Fontsize',8);
    end
    all150(:,j)=E150; % store all E150
    set(legend,'Fontsize',8);
    set(gcf,'position',[850 850 666 666]);
    temp=[char(strcat(pname(j),'- 7.4V')),'.png'];
    saveas(gca,fullfile('testresults/propellerside',temp));
    close;
end
%% 

a=zeros(5,1);
c=zeros(5,1);
r=zeros(5,1);
for i=1:5
    [a(i),b]=max(all150(:));
    r(i)=rem(b,12); % row
    c(i)=ceil(b/12); % column
    all150(r(i),c(i))=0;
end
figure
for i=1:5
    A=[96+r(i) 48+c(i) 95 55 46 99 115 118]; % 7.4V
    f=strcat('modifieddata/',char(A));
    %f=strcat('rawdata/',char(A));
    Import_Plot_csv(f);
end
hold off;
title('Top 5 Combination for 7.4V');
legend(strcat(mname(r),' +',pname(c),'{  }',num2str(a,4)),'Fontsize',8)
legend('location','southeast');
legend boxoff;
f=gcf;

set(f,'position',[5 45 666 666]);

saveas(gca,fullfile('testresults','Top 5 Combination for 7.4V.png'));
close;
%% 

% Single Propeller Multiple Motor - 11.1V
for j=1:8 % # of Props
    figure
    %movegui(figure,[420*(j-1) 20]);
    for i=1:12 % # of Motors
        A=[96+i 48+j 95 49 49 46 99 115 118]; % 11.1V
        f=strcat('modifieddata/',char(A));
        %f=strcat('rawdata/',char(A));
        [E150(i),Emax(i),Emin(i)]=Import_Plot_csv(f); % Emax:E for plot
    end
    hold off;
    set(legend,'Fontsize',8);
    legend(mname);
    legend('location','southeast');
    legend boxoff;
    title(strcat(pname(j),'- 11.1V'));
    ylim([0.8*min(Emin),1.1*max(Emax)]);
    y=get(gca,'ylim');
    x=get(gca,'xlim');
    E150s=sort(E150);
    for k=1:5 % find top 5
        z(k)=find(E150==E150s(end-(k-1))); % magnitude corresponds to z is descending
        text(10+x(1),(1-k*0.05)*y(2),strcat('Top','{ }',num2str(k),' Efficient Motors :','{ }',mname(z(k))),'Fontsize',8);
    end
    set(gcf,'position',[850 850 666 666]);
    temp=[char(strcat(pname(j),'- 11.1V')),'.png'];
    saveas(gca,fullfile('testresults/propellerside',temp));
    close;
end
a=zeros(5,1);
c=zeros(5,1);
r=zeros(5,1);
for i=1:5
    [a(i),b]=max(all150(:));
    r(i)=rem(b,12); % row
    c(i)=ceil(b/12); % column
    all150(r(i),c(i))=0;
end
figure
for i=1:5
    A=[96+r(i) 48+c(i) 95 49 49 46 99 115 118]; % 11.1 V
    f=strcat('modifieddata/',char(A));
    %f=strcat('rawdata/',char(A));
    Import_Plot_csv(f);
end
hold off;
title('Top 5 Combination for 11.1V');
legend(strcat(mname(r),' +',pname(c),'{  }',num2str(a,4)),'Fontsize',8)
legend('location','southeast');
legend boxoff;
f=gcf;
set(f,'position',[850 45 666 666]);
saveas(gca,fullfile('testresults','Top 5 Combination for 11.1V.png'));
close;
%% 

% plot of each experiment
for i=1:12 % # of Motors
    
    for j=1:8 % # of Propellers
        figure
        A=[96+i 48+j 95 55 46 99 115 118]; % 7.4V
        f=strcat('modifieddata/',char(A));
        %f=strcat('rawdata/',char(A));
        Import_Plot_experiment(f); % Emax:E for plot
        set(gcf,'position',[1450 850 666 666]);
        title(strcat(mname(i),' motor &',pname(j),' propeller - 7.4V'));
        set(legend,'Fontsize',8);
        legend('Thrust (100 gf)','Voltage (V)','Current (A)','Motor Electrical Speed (1000 RPM)','Electrical Power (10 W)','Overall Efficiency (gf/W)')
        legend('location','northwest');
        legend boxoff;
        temp=[char(strcat(mname(i),' motor &',pname(j),' propeller -7.4V')),'.png'];
        saveas(gca,fullfile('testresults/eachexperiment',temp))
        close;
    end
    
end

for i=1:12 % # of Motors
    
    for j=1:8 % # of Propellers
        figure
        A=[96+i 48+j 95 49 49 46 99 115 118]; % 11.1V
        f=strcat('modifieddata/',char(A));
        %f=strcat('rawdata/',char(A));
        Import_Plot_experiment(f); % Emax:E for plot
        set(gcf,'position',[1450 850 666 666]);
        title(strcat(mname(i),' motor &',pname(j),' propeller - 11.1V'));
        set(legend,'Fontsize',8);
        legend('Thrust (100 gf)','Voltage (V)','Current (A)','Motor Electrical Speed (1000 RPM)','Electrical Power (10 W)','Overall Efficiency (gf/W)')
        legend('location','northwest');
        legend boxoff;
        temp=[char(strcat(mname(i),' motor &',pname(j),' propeller - 11.1V')),'.png'];
        saveas(gca,fullfile('testresults/eachexperiment',temp))
        close;
    end

end
