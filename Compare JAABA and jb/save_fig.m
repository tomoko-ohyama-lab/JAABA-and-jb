function save_fig(fig,front,genotype)
outname=strcat(front,genotype);
filepath2=strcat('C:\Users\Ohyama_Dell\Documents\figures\',outname);
savefig(fig,filepath2)
%saveas(fig,filepath2,'pdf')
end