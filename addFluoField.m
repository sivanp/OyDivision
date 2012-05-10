function fluomovie= addFluoField(movie,name)
fluomovie=[];
fluo.name=name;
for i=1:length(movie.sites)
    lymphs=movie.sites(i).lymphs;
    if(isempty(lymphs))
        continue;
    end
    for j=1:length(lymphs)               
        clear 'flymph'
        clear 'fluo'
        lymph=lymphs(j);
        if(isempty(lymph))
            continue;
        end
        %for each lymph, try and find the fluoresence file and take the
        %measurements.
        indf=1;
        flymph.name=lymph.name;
        flymph.id=lymph.id;
        flymph.remark=lymph.remark;
        flymph.frames=lymph.frames;
        flymph.locations=lymph.locations;
        flymph.fate=lymph.fate;
        if(~isempty(lymph.remark))
            flymph.remark=lymph.remark;
        else
            flymph.remark='';
        end
        for k=1:length(lymph.frames)
            framenum=lymph.frames(k);                                                
            fluo.Frames=[];
            fluo.Means=[];            
            fluo.Max=[];
            fluo.Min=[];
            fluo.Std=[];            
        end
        if(isempty(lymph.fluos))
            fluonum=1;
        else
            fluonum=length(lymph.fluos)+1;
            flymph.fluos=lymph.fluos;
        end
        if(~exist('fluo'))
            fluo=[];
        end
        fluo.name=name;
        fluo.path='';        
        flymph.fluos{fluonum}=fluo;
        fluomovie.sites(i).lymphs(j)=flymph;
    end
end
fluomovie.lineageInd=movie.lineageInd;
fluomovie.maxLymphId=movie.maxLymphId;
fluomovie.momDaughInd=movie.momDaughInd;
fluomovie.momDaughTable=movie.momDaughTable;
