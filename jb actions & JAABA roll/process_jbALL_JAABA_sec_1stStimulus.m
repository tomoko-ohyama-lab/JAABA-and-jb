function [JAABAt0s,JAABAt1s,jb_beh]=process_jbALL_JAABA_sec_1stStimulus(genotype,timestamp,feature,bin)
%%
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
JAABAt0s={};
JAABAt1s={};
JAABAtrackStart=[];
JAABAtrackEnd=[];
JAABAindexlist=[];
jbupdated=struct(jb);
jbupdated(1:size(jbupdated,1))=[];
for i=1:length(JAABAindex)
    if (find(JAABAindex(i)==(jbindex)))
        jb_ind=find(1==(jbindex==JAABAindex(i)));
        if(JAABA.allScores.tStartSeconds(i)<=25 && JAABA.allScores.tEndSeconds(i)>=55)
            JAABAt0s(index)=JAABA.allScores.t0sSeconds(i);
            JAABAt1s(index)=JAABA.allScores.t1sSeconds(i);
            JAABAtrackStart(index)=JAABA.allScores.tStartSeconds(i);
            JAABAtrackEnd(index)=JAABA.allScores.tEndSeconds(i);
            JAABAindexlist(index)=i;
            jbupdated=vertcat(jbupdated,jb(jb_ind));
            index=index+1;
        end
    end
end
%% jb: convert from frame to sec (RUN,CAST,STOP,HUNCH,BACK,ROLL,SMALL)
jbt0sRoll={};
jbt1sRoll={};
jbt0sRun={};
jbt1sRun={};
jbt0sCast={};
jbt1sCast={};
jbt0sStop={};
jbt1sStop={};
jbt0sHunch={};
jbt1sHunch={};
jbt0sBack={};
jbt1sBack={};
jbt0sSmall={};
jbt1sSmall={};
for i=1:size(jbupdated,1)
    %% RUN
    jbrun=jbupdated(i).run;
    jbt=jbupdated(i).t;
    ind=find(jbrun==1);
    if ~isempty(ind)
        jbt0sRun{i}=[ind(1)];
        k=1;
        jbt1sRun{i}=[];
        for j=2:length(ind)
            dif=ind(j)-ind(j-1);
            if dif~=1
                jbt0sRun{i}(k+1)=ind(j);
                jbt1sRun{i}(k)=ind(j-1);
                k=k+1;
            end
        end
        jbt1sRun{i}(k)=ind(end);
        % Convert to sec
        jbt0sRun{i}=jbt(jbt0sRun{i});
        jbt1sRun{i}=jbt(jbt1sRun{i});
    else
        jbt0sRun{i}=[];
        jbt1sRun{i}=[];
    end
    %% CAST
    jbcast=jbupdated(i).cast;
    jbt=jbupdated(i).t;
    ind=find(jbcast==1);
    if ~isempty(ind)
        jbt0sCast{i}=[ind(1)];
        k=1;
        jbt1sCast{i}=[];
        for j=2:length(ind)
            dif=ind(j)-ind(j-1);
            if dif~=1
                jbt0sCast{i}(k+1)=ind(j);
                jbt1sCast{i}(k)=ind(j-1);
                k=k+1;
            end
        end
        jbt1sCast{i}(k)=ind(end);
        % Convert to sec
        jbt0sCast{i}=jbt(jbt0sCast{i});
        jbt1sCast{i}=jbt(jbt1sCast{i});
    else
        jbt0sCast{i}=[];
        jbt1sCast{i}=[];
    end
    %% STOP
    jbstop=jbupdated(i).stop;
    jbt=jbupdated(i).t;
    ind=find(jbstop==1);
    if ~isempty(ind)
        jbt0sStop{i}=[ind(1)];
        k=1;
        jbt1sStop{i}=[];
        for j=2:length(ind)
            dif=ind(j)-ind(j-1);
            if dif~=1
                jbt0sStop{i}(k+1)=ind(j);
                jbt1sStop{i}(k)=ind(j-1);
                k=k+1;
            end
        end
        jbt1sStop{i}(k)=ind(end);
        % Convert to sec
        jbt0sStop{i}=jbt(jbt0sStop{i});
        jbt1sStop{i}=jbt(jbt1sStop{i});
    else
        jbt0sStop{i}=[];
        jbt1sStop{i}=[];
    end
    %% HUNCH
    jbhunch=jbupdated(i).hunch;
    jbt=jbupdated(i).t;
    ind=find(jbhunch==1);
    if ~isempty(ind)
        jbt0sHunch{i}=[ind(1)];
        k=1;
        jbt1sHunch{i}=[];
        for j=2:length(ind)
            dif=ind(j)-ind(j-1);
            if dif~=1
                jbt0sHunch{i}(k+1)=ind(j);
                jbt1sHunch{i}(k)=ind(j-1);
                k=k+1;
            end
        end
        jbt1sHunch{i}(k)=ind(end);
        % Convert to sec
        jbt0sHunch{i}=jbt(jbt0sHunch{i});
        jbt1sHunch{i}=jbt(jbt1sHunch{i});
    else
        jbt0sHunch{i}=[];
        jbt1sHunch{i}=[];
    end
    %% BACK
    jbback=jbupdated(i).back;
    jbt=jbupdated(i).t;
    ind=find(jbback==1);
    if ~isempty(ind)
        jbt0sBack{i}=[ind(1)];
        k=1;
        jbt1sBack{i}=[];
        for j=2:length(ind)
            dif=ind(j)-ind(j-1);
            if dif~=1
                jbt0sBack{i}(k+1)=ind(j);
                jbt1sBack{i}(k)=ind(j-1);
                k=k+1;
            end
        end
        jbt1sBack{i}(k)=ind(end);
        % Convert to sec
        jbt0sBack{i}=jbt(jbt0sBack{i});
        jbt1sBack{i}=jbt(jbt1sBack{i});
    else
        jbt0sBack{i}=[];
        jbt1sBack{i}=[];
    end
    %% ROLL
    jbroll=jbupdated(i).roll;
    jbt=jbupdated(i).t;
    ind=find(jbroll==1);
    if ~isempty(ind)
        jbt0sRoll{i}=[ind(1)];
        k=1;
        jbt1sRoll{i}=[];
        for j=2:length(ind)
            dif=ind(j)-ind(j-1);
            if dif~=1
                jbt0sRoll{i}(k+1)=ind(j);
                jbt1sRoll{i}(k)=ind(j-1);
                k=k+1;
            end
        end
        jbt1sRoll{i}(k)=ind(end);
        % Convert to sec
        jbt0sRoll{i}=jbt(jbt0sRoll{i});
        jbt1sRoll{i}=jbt(jbt1sRoll{i});
    else
        jbt0sRoll{i}=[];
        jbt1sRoll{i}=[];
    end
%% SMALL MOTION
    jbsmall=jbupdated(i).small_motion;
    jbt=jbupdated(i).t;
    ind=find(jbsmall==1);
    if ~isempty(ind)
        jbt0sSmall{i}=[ind(1)];
        k=1;
        jbt1sSmall{i}=[];
        for j=2:length(ind)
            dif=ind(j)-ind(j-1);
            if dif~=1
                jbt0sSmall{i}(k+1)=ind(j);
                jbt1sSmall{i}(k)=ind(j-1);
                k=k+1;
            end
        end
        jbt1sSmall{i}(k)=ind(end);
        % Convert to sec
        jbt0sSmall{i}=jbt(jbt0sSmall{i});
        jbt1sSmall{i}=jbt(jbt1sSmall{i});
    else
        jbt0sSmall{i}=[];
        jbt1sSmall{i}=[];
    end
end 
%row: animal
%column: beh
jb_beh=[jbt0sRun',jbt1sRun',jbt0sCast',jbt1sCast',jbt0sStop',jbt1sStop',jbt0sHunch',jbt1sHunch',jbt0sBack',jbt1sBack',jbt0sRoll',jbt1sRoll',jbt0sSmall',jbt1sSmall'];
end