function [lymph,siteind,lymphind]= getLymph(lymphid,movie)
lymph=[];
siteind=0;
lymphind=0;
% movie=getCellStruct();
if(isempty(movie))
    reutrn;
end
if(~isfield(movie,'sites') || isempty(movie.sites))
    return
end
for i=1:length(movie.sites)
    if(isempty(movie.sites(i).lymphs))
        continue;
    end
    lymphs=movie.sites(i).lymphs;
    for j=1:length(lymphs)
        if(lymphs(j).id==lymphid)
            lymph=lymphs(j);
            siteind=i;
            lymphind=j;
            return;
        end
    end
end
