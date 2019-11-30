function Overlap_ethogram(genotype,timestamp,feature,bin)
%% This creates ethogram of JAABA and jb rolloing
% feature=name of JAABA classifier
% jb rolling indicates all rolling (weak+strong roll)
%% DELETE LATER
genotype='GMR_SS43207@UAS_Chrimson_attp18@t93@r_LED30_45s2x30s30s#n#n#n@100';
timestamp={'20190327_161836'};
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
[JAABAindexlist,JAABAt0sSeconds,JAABAt1sSeconds,jbt0sSeconds,jbt1sSeconds,overlap_avg,onlyJAABA_avg,onlyjb_avg]=process_multipletimes(genotype,timestamp,feature,bin);
%% Plot how much overlap and where (ETHOGRAM)
fig=figure;
JAABA_M=[];
JAABA_T=[];
jb_M=[];
jb_T=[];
for i=1:length(JAABAt0sSeconds)
    JAABA_MM=JAABAt0sSeconds{i}';
    JAABA_MM(:,2)=JAABAt1sSeconds{i}';
    JAABA_TT=zeros(size(JAABA_MM));
    JAABA_TT(:,:)=i;
    JAABA_M=vertcat(JAABA_M,JAABA_MM);
    JAABA_T=vertcat(JAABA_T,JAABA_TT);
    if ~isempty(jbt0sSeconds{i})
    jb_MM=jbt0sSeconds{i};
    jb_MM(:,2)=jbt1sSeconds{i};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=i+0.1;
    jb_M=vertcat(jb_M,jb_MM);
    jb_T=vertcat(jb_T,jb_TT);
    end
end
p1=plot(JAABA_M',JAABA_T','Color','b','LineWidth',0.5,'DisplayName','JAABA');
hold on
%legend('-DynamicLegend');
%legend('show');
drawnow;
p2=plot(jb_M',jb_T','Color','r','LineWidth',0.5,'DisplayName','jb');
xlabel('Seconds'),ylabel('larvae index')
title(strcat(genotype,'(JAABA (BLUE) vs jb (RED))'))
for j=1:circles
    f=fill([waiting+(j-1)*(stimdur+stimint),waiting+(j-1)*(stimdur+stimint)+stimdur,waiting+(j-1)*(stimdur+stimint)+stimdur,waiting+(j-1)*(stimdur+stimint)],[0,0,length(JAABAt0sSeconds),length(JAABAt0sSeconds)],'k');
    f.FaceAlpha=0.025;
    f.EdgeColor='none';
end
hold off
%% Save in Documents/figures/
save_fig(fig,'Ethogram_draftJAABA_jb_',genotype)
end