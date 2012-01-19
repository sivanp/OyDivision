%Inserts a mother daughter couple to the movie table, and advances the
%table index- returns the changed movie structure. if momid=-1 increases
%the lineage index as well
function movie= addMomDaughterCouple(movie, momid, lymphid)
% check if any of the lymph descendants are mom.

if(~isempty(movie.momDaughTable))
    inds=find(movie.momDaughTable(:,1)==momid & movie.momDaughTable(:,2)==lymphid);
    if(~isempty(inds))
        msgbox('mom-daughter couple allready exist');
        return
    end
end
mom=getLymph(momid,movie);

if(isempty(mom)&& momid~=-1)
    msgbox(' could not find mother cell in struct');
    return
end
lymph=getLymph(lymphid,movie);
if(isempty(lymph))
    msgbox(' could not find daughter cell in struct');
    return
end
[descenIds]=getDescenIds(movie,lymphid,[]);
for i=1:length(descenIds)
    if(descenIds(i)==momid)
        msgbox('mom is a descendants- beware of CIRCLES!!!');
        return;
    end
end
ind=movie.momDaughInd()+1;
movie.momDaughTable(ind,1:2)=[momid,lymphid];
movie.momDaughInd=ind;
if(momid==-1)
    movie.lineageInd=movie.lineageInd+1;
else %delete a line which has -1 as mom of the lymph
    ind=find(movie.momDaughTable(:,1)==-1 & movie.momDaughTable(:,2)==lymphid);
    if(~isempty(ind))
        movie.momDaughTable(ind,:)=[];
        movie.momDaughInd=movie.momDaughInd-1;
    end
end
%if this is the only mom- and lymph name has allready been initizlized, and
%is different than mom
inds=find(movie.momDaughTable(:,2)==lymphid);
if(length(inds)==1 && movie.momDaughTable(inds,1)~=-1 && ~isempty(lymph.name))
    lymphLin=regexp(lymph.name, '(\d+)','tokens');
    lymphLin=lymphLin{1}{1};
    momLin=regexp(mom.name, '(\d+)','tokens');
    momLin=momLin{1}{1};
    if(~strcmp(momLin,lymphLin))
        movie= ame(momid, mom.name, movie);
    end
end
