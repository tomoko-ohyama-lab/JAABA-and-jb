function save_fig(fig,front,genotype,timestamp)
outname=strcat(front,genotype,'_',timestamp);
filepath2=strcat('C:\Users\Ohyama_Dell\Documents\figures\',outname);
savefig(fig,filepath2)
%saveas(fig,filepath2,'pdf')
end