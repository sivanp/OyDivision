%return a vector with all descendadnts ids
function [descendantsIds]=getDescenIds(movie,lymphid,descendantsIds)
% function [descendantsIds]=getDescenIds()
if(isempty(movie.momDaughTable))
    return
end
inds=find(movie.momDaughTable(:,1)==lymphid);
%find daughters ids
for i=1:length(inds)
    daughtid=movie.momDaughTable(inds(i),2);
    descendantsIds(end+1)=daughtid;
    descendantsIds=getDescenIds(movie,daughtid,descendantsIds);
end

