function Ethogram_jbALL_JAABA(genotype,timestamp,feature,bin)
%% DELETE LATER
%genotype='Basin2@UAS_Chrimson@t93@r_LED30_30s2x15s30s#n#n#n@100';
%timestamp='20180224_145926';
%timestamp={'20180223_160049','20180223_160312','20180224_141612'};%,'20180224_155812'};
%feature='roll';
%bin=0.1;
%%
[driver,effector,tracker,protocol,times]=read_name(genotype);
waiting=times.waiting;
circles=times.circles;
stimdur=times.stimdur;
stimint=times.stimint;
total=stimint+circles*(stimdur+waiting);
timebin=[0:bin:total]; %timebin=0.2sec
[JAABAt0s,JAABAt1s,jb_beh]=process_jbALL_JAABA_sec(genotype,timestamp,feature,bin);
%% Plot how much overlap and where (ETHOGRAM)
[etho_JAABA,etho_jb]=optimize_data_ethogram(JAABAt0s,JAABAt1s,jb_beh);
fig=figure;
plot(etho_JAABA(:,1:2)',etho_JAABA(:,3:4)','Color','b','LineWidth',0.5,'DisplayName','JAABA');
hold on
% legend('-DynamicLegend');
% legend('show');
% drawnow;


% RUN=light green
plot(etho_jb{1,1}',etho_jb{1,2}','Color',[0.75 0.75 0],'LineWidth',0.5,'DisplayName','jb');
% CAST=dark red
plot(etho_jb{1,3}',etho_jb{1,4}','Color',[0.6350 0.0780 0.1840],'LineWidth',0.5,'DisplayName','jb');
% STOP=purple
plot(etho_jb{1,5}',etho_jb{1,6}','Color',[0.6 0 1],'LineWidth',0.5,'DisplayName','jb');
% HUNCH=green
plot(etho_jb{1,7}',etho_jb{1,8}','Color',[0 0.6 0],'LineWidth',0.5,'DisplayName','jb');
% BACK=cyan
plot(etho_jb{1,9}',etho_jb{1,10}','Color','c','LineWidth',0.5,'DisplayName','jb');
% SMALL MOTION=grey
plot(etho_jb{1,13}',etho_jb{1,14}','Color',[0.6 0.6 0.6],'LineWidth',0.5,'DisplayName','jb');
% ROLL=magenda
plot(etho_jb{1,11}',etho_jb{1,12}','Color','m','LineWidth',0.5,'DisplayName','jb');


%'\color{magenta}Month1,\newline

xlabel('Seconds'),ylabel('larvae index')
title({strrep(genotype,'_','-'),strrep(timestamp,'_','-'),'jb RUN=light green','jb CAST=dark red','jb STOP=purple','jb HUNCH=green','jb BACK=cyan','jb ROLL=magenda','JAABA ROLL=blue'})
for j=1:circles
    f=fill([waiting+(j-1)*(stimdur+stimint),waiting+(j-1)*(stimdur+stimint)+stimdur,waiting+(j-1)*(stimdur+stimint)+stimdur,waiting+(j-1)*(stimdur+stimint)],[0,0,length(JAABAt0s),length(JAABAt0s)],'k');
    f.FaceAlpha=0.025;
    f.EdgeColor='none';
end
hold off
%% Save in Documents/figures/
save_fig(fig,'Ethogram_JAABA_jbALL_',genotype,timestamp)
end
