offs=-20:4:20;
ind=1;
for i=1:length(movie.sites)
    lymphs=movie.sites(i).lymphs;
    
    for j=1:length(lymphs)
        lymph=lymphs(j);
        fluo=[];
        if(max(lymph.frames)~=1013)
            continue
        end
        for k=1:length(lymph.fluos)
            if(lymph.fluos{k}.Max==255)
                fluo=[];                
                break;
            end
            fluo(k)=lymph.fluos{k}.Means;           
        end
        
         if(max(fluo)>40)%don't get very dim cells- probably at G1...
              fluo=fluo/max(fluo);
        if(~isempty(fluo))
            
            Fs(ind,1:k)=fluo;
            ids(ind)=lymph.id;
            sites(ind)=i;
            FmaxDivF4(ind)=fluo(7)/max(fluo);
            dF4p(ind)=((fluo(8)-fluo(7))/4)/max(fluo);
            dF4m(ind)=((fluo(6)-fluo(7))/4)/max(fluo);
            ind=ind+1;
            end
        end
    end
end

%plot sites
for i=1:5
    figure()
    inds=find(sites==i);
    SiteFs=Fs(inds,:);
    plot(offs,SiteFs,'x-')
    title(sprintf('Site %d fluos ',i))
    xlabel('offset')
    ylabel('mean fluo')
    
end







for i=1:size(Fs,1)
    ind=find(Fs(i,:)==max(Fs(i,:)));
    if(length(ind)>1 && max(Fs(i,:))==255)
        ind=0;
    end
    maxoff(i)=ind;
    maxval(i)=max(Fs(i,:));
end

hist(maxoff, [1:1:11]);
%absolut distance from +4 which is the most frequenct best focus in this
%experiment.
plot(maxoff,maxval,'x')
xlabel('maximal index')
ylabel('maximal fluo')

relmaxoff=maxoff*4-20;





