function [generation] = getLymphGeneration(lymphid,movie)
generation=1;
while(1)
    inds=find(movie.momDaughTable(:,2)==lymphid);
    moms=movie.momDaughTable(inds,1);
    %if I have more than one mom I will always take the one with lower
    %index
    momind=find(moms~=-1,1);
    
    if(isempty(momind))
        
        return
    else
        generation=generation+1;
        lymphid=moms(momind);
    end
end


end