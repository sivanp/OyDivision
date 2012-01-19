%this function creates a new movie which holds the addition of the lymphs of movie2 in the given sties to movie1
function [movie]=addLymphsFromOneMovieStructToAnother(movie1,movie2,sites)
convIds=[-1,-1];
%first we add the mothers than the daughters
% momsinds=find(movie2.momDaughTable(:,1)==-1);
% oldmomids=movie2.momDaughTable(momsinds,2);

for s=1:length(sites)
    movie=movie1;
    site=sites(s);
    oldlymphs=movie2.sites(site).lymphs;
    newlymphs=[];
    %first we add the mothers
    for i=1:length(oldlymphs)
        lymph=oldlymphs(i);
        inds=find(movie2.momDaughTable(:,2)==lymph.id);
        if(movie2.momDaughTable(inds(1),1)==-1) %assuming we have -1 only once if any.
            newid=movie.maxLymphId+1;
            convIds(end+1,1:2)=[lymph.id,newid];
            [newlymph,movie, siteind,lymphind]=createNewLymphNoGui(newid,site,[],movie);
            [movie,newlymph]=addnewLymph(movie, lymph, newlymph);
            %             movie.sites(site).lymphs(end+1)=newlymph;
        end
    end
    
    %now we add the the daughters
    for i=1:length(oldlymphs)
        lymph=oldlymphs(i);
        inds=find(movie2.momDaughTable(:,2)==lymph.id);
        if(movie2.momDaughTable(inds(1),1)~=-1) %have mothers
            newid=movie.maxLymphId+1;
            convIds(end+1,1:2)=[lymph.id,newid];
            oldmomid=movie2.momDaughTable(inds(1),1);
            momind=find(convIds(:,1)==oldmomid);
            newmomid=convIds(momind,2);
            [newlymph,movie, siteind,lymphind]=createNewLymphNoGui(newid,site,num2str(newmomid),movie);
            [movie,newlymph]=addnewLymph(movie, lymph, newlymph);
            for m=2:length(inds) %% more mothers
                oldmomid=movie2.momDaughTable(inds(m),1);
                momind=find(convIds(:,1)==oldmomid);
                newmomid=convIds(momind,2);
                movie=addMomDaughterCouple(movie, newmomid, newid);
            end
        end
    end
end


function [movie, newlymph]= addnewLymph(movie, oldlymph, newlymph)
[lymph,siteind,lymphind]=getLymph(newlymph.id,movie);
newlymph.frames=oldlymph.frames;
newlymph.locations=oldlymph.locations;
newlymph.fluos=oldlymph.fluos;
newlymph.remark=oldlymph.remark;
newlymph.fate=oldlymph.fate;
movie.sites(siteind).lymphs(lymphind)=newlymph;
if(movie.maxLymphId<newlymph.id) %this is new movie structure or new cell created
    movie.maxLymphId=newlymph.id;
end
