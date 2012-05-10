function [lymphs]=getLymphFromIds(lymphsids,lymphMappingMat,allLymphs)
for i=1:length(lymphsids)
    ind=find(lymphMappingMat(:,2)==lymphsids(i));
    l=allLymphs(lymphMappingMat(ind,1));
    lymphs(i)=l(1);
end