function timestamps=get_allTS(genotype)

timestamps={};
[driver,effector,tracker,protocol,times]=read_name(genotype);

TS=dir(strcat('C:\Users\Ohyama_Dell\Documents\jb-results\',tracker,'\',driver,'@',effector,'\',protocol,'@100'));
index=1;
for i=3:size(TS,1)
    timestamps{index}=TS(i).name;
    index=index+1;
end

end