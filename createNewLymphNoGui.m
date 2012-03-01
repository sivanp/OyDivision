function [lymph,movie, siteind,lymphind]=createNewLymphNoGui(lymphid,sitenum,momid,movie)
siteind=0;
lymphind=0;
lymph.id=lymphid;
lymph.frames=[];
lymph.locations=[];
lymph.fluos=[];
lymph.name='';
lymph.remark=[];
lymph.fate=0; %fate 1=div, fate 2=die   default: 0 =till end- out of frame or focus/nor dividing nor dying.
if(lymphid==1)
    if(~isfield(movie,'sites') || sitenum>length(movie.sites) || isempty(movie.sites(sitenum).lymphs ))
        ind=1;
    end
end
if(~isfield(movie,'sites')|| sitenum>length(movie.sites))    
    ind=1;
else
    ind=length(movie.sites(sitenum).lymphs)+1;
end
movie.sites(sitenum).lymphs(ind)=lymph;
siteind=sitenum;
lymphind=ind;
%add to mother-daughter table
if(isempty(momid))
    movie=addMomDaughterCouple(movie,-1,lymphid);
    lymph.name=num2str(movie.lineageInd);
    momid=-1;
else
    momid=str2num(momid);
    movie=addMomDaughterCouple(movie,momid,lymphid);
end
if(momid==-1) %adding lineage
    lymph.name=num2str( movie.lineageInd);
else
    mom=getLymph(momid,movie);
    numOfSisters=length(find(movie.momDaughTable(:,1)==momid));
    lymph.name=sprintf('%s_%d', mom.name, numOfSisters);
end