%default is to do the first fluoresence in red and the second in green. and
%that is.
function plotCellsFucci(first, last, movie)
for i=first:last
    drugT=954;
    lymph=getLymph(i,movie);
    if(isempty(lymph))
        continue;
    end
    
    
    [timesKO, ko]=getCellsFluo(i,1,movie);
    [timesGFP,gfp]=getCellsFluo(i,2,movie);
    if(isempty(ko) ||isempty(gfp))
        continue;
    end
    figure()
    hold on;
    [AX,H1,H2] = plotyy(timesKO,ko,timesGFP,gfp);
    set(H1,'LineWidth',3)
    set(H1,'Color','r')
    set(AX(1),'YColor','r')
    set(H2,'LineWidth',3)
    set(H2,'Color','g')
    set(AX(2),'YColor','g')
    set(get(AX(1),'Ylabel'),'String','mKO')
    set(get(AX(2),'Ylabel'),'String','mAG')
    set(AX(1),'FontSize',12)
    set(AX(2),'FontSize',12)
    if(~isempty(find(timesKO>drugT)) && ~isempty(find(timesKO<drugT)))
        plot(ones(2,1)*drugT,[min(ko),max(ko)],'k-')
    end
    name =  lymph.name;
    rem=lymph.remark;
    name=sprintf('%s %s',name,rem);
    title(name,'FontSize', 12);
end
end