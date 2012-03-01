%this function creates a new movie which holds the addition of the lymphs of movie2 in the given sties to movie1
function [movie]=addLymphsFromOneMovieStructToAnother(movie1,movie2,sites)
convIds=[-1,-1];
%first make sure maxLymphId is correct-assuming if max is not 0 its
%allright
movie=movie1;
if(movie.maxLymphId==0)
    for i=1:length(movie.sites)
        lymphs=movie.sites(i).lymphs;
        for j=1:length(lymphs)
            if(movie.maxLymphId<lymphs(j).id)
                movie.maxLymphId=lymphs(j).id;
            end
        end
    end
    %in this case we will also change momDaughInd to the same value
%     movie.momDaughInd=movie.maxLymphId;
end
%Second we add all cells

for s=1:length(sites)    
    site=sites(s);
    oldlymphs=movie2.sites(site).lymphs;
    newlymphs=[];
    %first we add the mothers
    for i=1:length(oldlymphs)
        lymph=oldlymphs(i);        
        newid=movie.maxLymphId+1;
        convIds(end+1,1:2)=[lymph.id,newid];
        [newlymph,movie, siteind,lymphind]=createNewLymphNoGui(newid,site,[],movie);
        [movie,newlymph]=addnewLymph(movie, lymph, newlymph);
    end
    
    %now we add the mother daughter mapping
    for i=1:length(oldlymphs)
        lymph=oldlymphs(i);
        lymphind=find(convIds(:,1)==lymph.id);
        newid=convIds(lymphind,2);      
        inds=find(movie2.momDaughTable(:,2)==lymph.id);
        if(movie2.momDaughTable(inds(1),1)~=-1) %have mothers
            for j=1:length(inds)
                oldmomid=movie2.momDaughTable(inds(j),1);
                momind=find(convIds(:,1)==oldmomid);
                newmomid=convIds(momind,2);           
                movie=addMomDaughterCouple(movie, newmomid, newid);
            end
%         else
%            movie=addMomDaughterCouple(movie, -1, newid); 
        end
    end
end


function [movie, newlymph]= addnewLymph(movie, oldlymph, newlymph)
[lymph,siteind,lymphind]=getLymph(newlymph.id,movie);
newlymph.frames=oldlymph.frames;
newlymph.locations=oldlymph.locations;
newlymph.fluos=oldlymph.fluos;
newlymph.remark=oldlymph.remark;
% newlymph.fate=oldlymph.fate;
movie.sites(siteind).lymphs(lymphind)=newlymph;
if(movie.maxLymphId<newlymph.id) %this is new movie structure or new cell created
    movie.maxLymphId=newlymph.id;
end
