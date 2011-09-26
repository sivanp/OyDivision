%excepct movie object, and (fluoresence) ntemplate. and (fluoresence) name.
%for each lymph in the struct
%ntemplate is the part represented by * in the full path - *_%d_%d.tif
function fluomovie= extractFluoFromMovie(movie,ntemplate, name)
fluomovie=[];
fluo.name=name;
for i=1: length(movie.sites)
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
        
        for k=1:length(lymph.frames)
            framenum=lymph.frames(k);
             path=sprintf('%s_%d_normalized_%d.tif', ntemplate, i, framenum);            
            if(~exist(path, 'file'))
            path=sprintf('%s_%d_%d.tif', ntemplate, i, framenum);   
                if(~exist(path, 'file'))
                    continue;
                end
            end
            im=imread(path);
            [r,c]=size(im);
            xs=lymph.locations{k}(:,1);
            ys=lymph.locations{k}(:,2);
            mask=poly2mask(xs,ys,r,c);
            inds=(find(mask>0));
            fluo.Frames(indf)=framenum;
            fluo.Means(indf)=mean(im(inds));
            indf=indf+1;
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
        fluo.path=ntemplate;        
        flymph.fluos{fluonum}=fluo;
        fluomovie.sites(i).lymphs(j)=flymph;
    end
end
fluomovie.lineageInd=movie.lineageInd;
fluomovie.maxLymphId=movie.maxLymphId;
fluomovie.momDaughInd=movie.momDaughInd;
fluomovie.momDaughTable=movie.momDaughTable;
