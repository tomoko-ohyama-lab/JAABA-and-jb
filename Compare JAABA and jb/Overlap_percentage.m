function Overlap_percentage(genotype,feature,bin)
%% This code is to make a figure of 
% overall percentage of rolling vs time
% automatically gets all timestamps from jb-results
%% DELETE LATER
genotype='Basin4@UAS_Chrimson@t93@r_LED30_30s2x15s30s#n#n#n@100';
feature='roll_moreprecise';
bin=0.1;
%%
[driver,effector,tracker,protocol,times]=read_name(genotype);
waiting=times.waiting;
circles=times.circles;
stimdur=times.stimdur;
stimint=times.stimint;
total=stimint+circles*(stimdur+waiting);
timebin=[0:bin:total]; %timebin=0.2sec
timestamps=get_allTS(genotype);
[JAABAindexlist,JAABAt0sSeconds,JAABAt1sSeconds,jbt0sSeconds,jbt1sSeconds,overlap_avg,onlyJAABA_avg,onlyjb_avg]=process_multipletimes(genotype,timestamps,feature,bin);
%% Plot how much overlap and where (LINE)
fig=figure;
%% YOU CAN CHOOSE TO MAKE OVERLAP, NO OVERLAP FIGURE
% Do it by comment/uncomment
%% No overlap
% p1=plot(timebin',(overlap_avg+onlyJAABA_avg)','Color','b','LineWidth',0.5,'DisplayName','JAABA');
% hold on
% legend('-DynamicLegend');
% legend('show');
% drawnow;
% p2=plot(timebin',(overlap_avg+onlyjb_avg)','Color','r','LineWidth',0.5,'DisplayName','jb');
% hold on
% xlabel('Seconds'),ylabel('Average %')
% for i=1:length(timestamps)
%     timestamps{i}=strrep(timestamps{i},'_','-');
% end
% title({strrep(genotype,'_','-'),timestamps{:},'JAABA vs jb'})
%% Overlap
p1=plot(timebin',overlap_avg','Color','g','LineWidth',0.5,'DisplayName','Overlap');
hold on
legend('-DynamicLegend');
legend('show');
drawnow;
p2=plot(timebin',onlyJAABA_avg','Color','b','LineWidth',0.5,'DisplayName','JAABA Only');
hold on
p3=plot(timebin',onlyjb_avg','Color','r','LineWidth',0.5,'DisplayName','jb Only');
hold on
xlabel('Seconds'),ylabel('Average %')
for i=1:length(timestamps)
    timestamps{i}=strrep(timestamps{i},'_','-');
end
title({strrep(genotype,'_','-'),timestamps{:},'(Overlap vs Only JAABA vs Only jb)'})
%%
for j=1:circles
    f=fill([waiting+(j-1)*(stimdur+stimint),waiting+(j-1)*(stimdur+stimint)+stimdur,waiting+(j-1)*(stimdur+stimint)+stimdur,waiting+(j-1)*(stimdur+stimint)],[0,0,1,1],'k');
    f.FaceAlpha=0.025;
    f.EdgeColor='none';
end
hold off
save_fig(fig,'Overlap_draftJAABA_jb',genotype)
end