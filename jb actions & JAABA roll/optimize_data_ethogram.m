function [etho_JAABA,etho_jb]=optimize_data_ethogram(JAABAt0s,JAABAt1s,jb_beh)

JAABA_M=[];
JAABA_T=[];
jb_run=[];
jb_runT=[];
jb_cast=[];
jb_castT=[];
jb_stop=[];
jb_stopT=[];
jb_hunch=[];
jb_hunchT=[];
jb_back=[];
jb_backT=[];
jb_roll=[];
jb_rollT=[];
jb_small=[];
jb_smallT=[];
for i=1:length(JAABAt0s)
    JAABA_MM=JAABAt0s{i}';
    JAABA_MM(:,2)=JAABAt1s{i}';
    JAABA_TT=zeros(size(JAABA_MM));
    JAABA_TT(:,:)=i+0.1;
    JAABA_M=vertcat(JAABA_M,JAABA_MM);
    JAABA_T=vertcat(JAABA_T,JAABA_TT);
    %% RUN
    if ~isempty(jb_beh{i,1})
    jb_MM=jb_beh{i,1};
    jb_MM(:,2)=jb_beh{i,2};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=i;
    jb_run=vertcat(jb_run,jb_MM);
    jb_runT=vertcat(jb_runT,jb_TT);
    end
    %% CAST
    if ~isempty(jb_beh{i,3})
    jb_MM=jb_beh{i,3};
    jb_MM(:,2)=jb_beh{i,4};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=i;
    jb_cast=vertcat(jb_cast,jb_MM);
    jb_castT=vertcat(jb_castT,jb_TT);
    end
    %% STOP
    if ~isempty(jb_beh{i,5})
    jb_MM=jb_beh{i,5};
    jb_MM(:,2)=jb_beh{i,6};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=i;
    jb_stop=vertcat(jb_stop,jb_MM);
    jb_stopT=vertcat(jb_stopT,jb_TT);
    end
    %% HUNCH
    if ~isempty(jb_beh{i,7})
    jb_MM=jb_beh{i,7};
    jb_MM(:,2)=jb_beh{i,8};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=i;
    jb_hunch=vertcat(jb_hunch,jb_MM);
    jb_hunchT=vertcat(jb_hunchT,jb_TT);
    end
    %% BACK
    if ~isempty(jb_beh{i,9})
    jb_MM=jb_beh{i,9};
    jb_MM(:,2)=jb_beh{i,10};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=i;
    jb_back=vertcat(jb_back,jb_MM);
    jb_backT=vertcat(jb_backT,jb_TT);
    end
    %% ROLL
    if ~isempty(jb_beh{i,11})
    jb_MM=jb_beh{i,11};
    jb_MM(:,2)=jb_beh{i,12};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=i;
    jb_roll=vertcat(jb_roll,jb_MM);
    jb_rollT=vertcat(jb_rollT,jb_TT);
    end
    %% SMALL MOTION
    if ~isempty(jb_beh{i,13})
    jb_MM=jb_beh{i,13};
    jb_MM(:,2)=jb_beh{i,14};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=i;
    jb_small=vertcat(jb_small,jb_MM);
    jb_smallT=vertcat(jb_smallT,jb_TT);
    end
end
etho_JAABA=[JAABA_M,JAABA_T];
etho_jb={jb_run,jb_runT,jb_cast,jb_castT,jb_stop,jb_stopT,jb_hunch,jb_hunchT,jb_back,jb_backT,jb_roll,jb_rollT,jb_small,jb_smallT};

end