function lymphs=getLymphsFromSites(movie, sites)
dumLymph.id=0;
dumLymph.frames=[];
dumLymph.locations=[];
dumLymph.fluos=[];
dumLymph.name='';
dumLymph.remark=[];
dumLymph.fate=[];
lymphs=dumLymph;
for i=1:length(sites)
    slymphs=movie.sites(sites(i)).lymphs;
    for j=1:length(slymphs)
        if(~isempty(slymphs(j)))
            lymphs(end+1)=slymphs(j);
        end
    end     
end
lymphs(1)=[];