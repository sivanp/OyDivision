function [completeFilteredLymphs]=filterShortCells(minLifeTime, lymphs)
ind=1;
for i=1:size(lymphs,2)
    if(lymphs(i).times(end)-lymphs(i).times(1)>=minLifeTime)
        completeFilteredLymphs(ind)=lymphs(i);
        ind=ind+1;
    end
end