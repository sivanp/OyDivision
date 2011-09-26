function retcells=clearNoFluoCells(cells)
retcells=cells;
toDel=[];
for i=1:length(cells)
    if(length(cells(i).KO2)==0)
        toDel(end+1)=i;
            end
end
for i=length(toDel):-1:1
    retcells(toDel(i))=[];
end