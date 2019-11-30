function Ethogram_jbALL_JAABA_1stStimulus(genotype,timestamp,feature,bin)
%% DELETE LATER
genotype='Basin2@UAS_Chrimson@t93@r_LED30_30s2x15s30s#n#n#n@100';
timestamp='20180224_145926';
%timestamp={'20180223_160049','20180223_160312','20180224_141612'};%,'20180224_155812'};
feature='roll';
bin=0.1;
%%
[driver,effector,tracker,protocol,times]=read_name(genotype);
waiting=times.waiting;
circles=times.circles;
stimdur=times.stimdur;
stimint=times.stimint;
total=stimint+circles*(stimdur+waiting);
timebin=[0:bin:total];
[JAABAt0s,JAABAt1s,jb_beh]=process_jbALL_JAABA_sec_1stStimulus(genotype,timestamp,feature,bin);
%% Plot how much overlap and where (ETHOGRAM)
[etho_JAABA,etho_jb]=optimize_data_ethogram(JAABAt0s,JAABAt1s,jb_beh);
fig=figure;

for j=1:1
    f=fill([waiting+(j-1)*(stimdur+stimint),waiting+(j-1)*(stimdur+stimint)+stimdur,waiting+(j-1)*(stimdur+stimint)+stimdur,waiting+(j-1)*(stimdur+stimint)],[0,0,length(JAABAt0s)+1,length(JAABAt0s)+1],'k');
    f.FaceAlpha=0.025;
    f.EdgeColor='none';
end
hold on
% JAABA ROLL=BLUE
% plot(etho_JAABA(:,1:2)',etho_JAABA(:,3:4)','Color','b','LineWidth',0.5,'DisplayName','JAABA');

% SMALL MOTION=grey
% plot(etho_jb{1,13}',etho_jb{1,14}','Color',[0.6 0.6 0.6],'LineWidth',5,'DisplayName','jb');
% RUN=yellow green
plot(etho_jb{1,1}',etho_jb{1,2}','Color',[154/255 205/255 50/255],'LineWidth',10,'DisplayName','jb');
% CAST=corn flower blue
plot(etho_jb{1,3}',etho_jb{1,4}','Color',[100/255 149/255 237/255],'LineWidth',10,'DisplayName','jb');
% STOP=black
plot(etho_jb{1,5}',etho_jb{1,6}','Color','black','LineWidth',10,'DisplayName','jb');
% HUNCH=orange
plot(etho_jb{1,7}',etho_jb{1,8}','Color',[255/255 165/255 0],'LineWidth',10,'DisplayName','jb');
% BACK=dark golden rod
plot(etho_jb{1,9}',etho_jb{1,10}','Color',[184/255 134/255 11/255],'LineWidth',10,'DisplayName','jb');
% ROLL=hot pink
plot(etho_jb{1,11}',etho_jb{1,12}','Color',[1 105/255 180/255],'LineWidth',10,'DisplayName','jb');

xlabel('Seconds'),ylabel('larvae index')
xlim([25 55])
title({strrep(genotype,'_','-'),strrep(timestamp,'_','-'),'jb RUN=light green','jb CAST=light blue','jb STOP=purple','jb HUNCH=green','jb BACK=cyan','jb ROLL=magenda'})%'JAABA ROLL=blue(upper line)'
hold off
%% Save in Documents/figures/
save_fig(fig,'Ethogram_JAABA_jbALL_1stStimulus',genotype,timestamp)
end
