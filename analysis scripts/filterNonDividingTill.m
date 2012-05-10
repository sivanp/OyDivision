function [filteredLymphs]=filterNonDividingTill(lymphs, endTime)
ind=1;
filteredLymphs=[];
for i=1:size(lymphs,2)
    if(lymphs(i).id==171)
        i
    end
    if(lymphs(i).times(end)==endTime)
        filteredLymphs(ind)=lymphs(i);
        ind=ind+1;
    end
end