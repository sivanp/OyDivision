%this function returns a struct array of the given lymphs whith the given properties
%gens= the allowed generations
%complete = if this is 1 just lymphs with mom and duaghter (i,.e
%'complete') , if  -1 lymphs all. if 0 only non complete, if 2- just lymphs with known
%fates (either complete of dead)
%sites= from the requested sites
%lymphMappingMat mapping of the lymphs id in column 2 ,site at column 3. if is complete at column 4
function [filteredLymphs]=filterLymphs(lymphs,gens,complete,sites,lymphMappingMat)
ind=1;

for i=1:length(lymphs)
    skip=0;
    lymph=lymphs(i);
    if(lymph.id==101)
        i
    end
    gen=regexp(lymph.name,'_');
    gen=length(gen)+1;
    if(~ismember(gen,gens))
        continue;
    end
    %find movie
    lind=find(lymphMappingMat(:,2)==lymph.id);
    site=lymphMappingMat(lind,3);
    if(~ismember(site,sites))
        continue;
    end
    if((complete==1 ||complete==0) && complete~=lymphMappingMat(lind,4))
        skip=1;
    end
   
    if(complete==2 && ~(lymph.fate==2 || lymphMappingMat(lind,4)==1))
        skip=1;
    end
    if(~skip)
        filteredLymphs(ind)=lymph;
        ind=ind+1;
    end
end

end
