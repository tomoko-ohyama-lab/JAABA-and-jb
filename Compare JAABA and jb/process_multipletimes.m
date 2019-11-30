function [JAABAindexlist,JAABAt0sSeconds,JAABAt1sSeconds,jbt0sSeconds,jbt1sSeconds,overlap_avg,onlyJAABA_avg,onlyjb_avg]=process_multipletimes(genotype,timestamps,feature,bin)
%%
overlap_avg=[];
onlyJAABA_avg=[];
onlyjb_avg=[];
for ii=1:length(timestamps)
    timestamp=timestamps{ii};
[driver,effector,tracker,protocol,times]=read_name(genotype);
waiting=times.waiting;
circles=times.circles;
stimdur=times.stimdur;
stimint=times.stimint;
total=stimint+circles*(stimdur+waiting);
timebin=[0:bin:total]; %timebin=0.2sec
JAABA=load(strcat('C:\Users\Ohyama_Dell\Documents\JAABA_processed\',tracker,'\',driver,'@',effector,'\',protocol,'@100\',timestamp,'\scores_',feature,'_updated.mat'));
JAABA=JAABA.allScores;
jb=load(strcat('C:\Users\Ohyama_Dell\Documents\jb-results\',tracker,'\',driver,'@',effector,'\',protocol,'@100\',timestamp,'\trx.mat'));
jb=jb.trx;
%% Match index between JAABA and jb
% JAABA aninum >= jb aninum
JAABAindex=unique(JAABA.allScores.crabspeed(:,5));
jbindex=(unique([jb.numero_larva_num]))';
index=1;
JAABAt0sSeconds={};
JAABAt1sSeconds={};
JAABAtrackStart=[];
JAABAtrackEnd=[];
JAABAindexlist=[];
for i=1:length(JAABAindex)
    if (find(JAABAindex(i)==(jbindex)))
        JAABAt0sSeconds(index)=JAABA.allScores.t0sSeconds(i);
        JAABAt1sSeconds(index)=JAABA.allScores.t1sSeconds(i);
        JAABAtrackStart(index)=JAABA.allScores.tStartSeconds(i);
        JAABAtrackEnd(index)=JAABA.allScores.tEndSeconds(i);
        JAABAindexlist(index)=i;
        index=index+1;
    end
end
%% jb: convert from frame to sec
jbt0sSeconds={};
jbt1sSeconds={};
for i=1:size(jb,1)
    jbroll=jb(i).roll;
    jbt=jb(i).t;
    ind=find(jbroll==1);
    if ~isempty(ind)
        jbt0sSeconds{i}=[ind(1)];
        k=1;
        jbt1sSeconds{i}=[];
        for j=2:length(ind)
            dif=ind(j)-ind(j-1);
            if dif~=1
                jbt0sSeconds{i}(k+1)=ind(j);
                jbt1sSeconds{i}(k)=ind(j-1);
                k=k+1;
            end
        end
        jbt1sSeconds{i}(k)=ind(end);
        % Convert to sec
        t0s=jbt0sSeconds{i};
        jbt0sSeconds{i}=jbt(t0s);
        t1s=jbt1sSeconds{i};
        jbt1sSeconds{i}=jbt(t1s);
    else
        jbt0sSeconds{i}=[];
        jbt1sSeconds{i}=[];
    end
end 
%% Calculate overlap %
tracking=NaN(length(JAABAt0sSeconds),length(timebin));
overlap=NaN(length(JAABAt0sSeconds),length(timebin));
onlyJAABA=NaN(length(JAABAt0sSeconds),length(timebin));
onlyjb=NaN(length(JAABAt0sSeconds),length(timebin));
overlap_track=NaN(length(JAABAt0sSeconds),length(timebin));
onlyJAABA_track=NaN(length(JAABAt0sSeconds),length(timebin));
onlyjb_track=NaN(length(JAABAt0sSeconds),length(timebin));
for i=1:length(JAABAt0sSeconds)
    % tracking
    temp=NaN(size(timebin));
    [n,temp_track_start]=min(abs(JAABAtrackStart(i)-timebin));
    [n,temp_track_end]=min(abs(JAABAtrackEnd(i)-timebin));
    temp(temp_track_start:temp_track_end)=0;
    tracking(i,:)=temp;
    % overlap
    temp_oJAABA=zeros(size(timebin));
    oJAABA=JAABAt0sSeconds{i}';
    oJAABA(:,2)=JAABAt1sSeconds{i}';
    for j=1:size(oJAABA,1)
        [n,temp_start]=min(abs(oJAABA(j,1)-timebin));
        [n,temp_end]=min(abs(oJAABA(j,2)-timebin));
        temp_oJAABA(temp_start:temp_end)=1;
    end
    temp_ojb=zeros(size(timebin));
        if ~isempty(jbt0sSeconds{i})
    ojb=jbt0sSeconds{i};
    ojb(:,2)=jbt1sSeconds{i};
    for j=1:size(ojb,1)
        [n,temp_start]=min(abs(ojb(j,1)-timebin));
        [n,temp_end]=min(abs(ojb(j,2)-timebin));
        temp_ojb(temp_start:temp_end)=1;
    end
        end
    
    temp_overlap=temp_oJAABA&temp_ojb;
    overlap(i,find(temp_overlap==1))=1;
    temp_oJAABA=temp_oJAABA-temp_overlap;
    temp_ojb=temp_ojb-temp_overlap;
    onlyJAABA(i,find(temp_oJAABA==1))=1;
    onlyjb(i,find(temp_ojb==1))=1;
    
%     M(2,2)=M(2,2)+length(find(temp_overlap==1))/length(find(temp==1));
%     M(1,2)=M(1,2)+length(find(temp_oJAABA==1))/length(find(temp==1));
%     M(2,1)=M(2,1)+length(find(temp_ojb==1))/length(find(temp==1));
%     M(1,1)=M(1,1)+length(find((temp-temp_overlap-temp_oJAABA-temp_ojb)==1))/length(find(temp==1));
end
overlap_track(find(tracking==0))=0;
overlap_track(find(overlap==1))=1;
onlyJAABA_track(find(tracking==0))=0;
onlyJAABA_track(find(onlyJAABA==1))=1;
onlyjb_track(find(tracking==0))=0;
onlyjb_track(find(onlyjb==1))=1;

overlap_avg=vertcat(overlap_avg,overlap_track);
onlyJAABA_avg=vertcat(onlyJAABA_avg,onlyJAABA_track);
onlyjb_avg=vertcat(onlyjb_avg,onlyjb_track);
end
overlap_avg=nanmean(overlap_track);
onlyJAABA_avg=nanmean(onlyJAABA_track);
onlyjb_avg=nanmean(onlyjb_track);
end