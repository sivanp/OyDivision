%this function returns a vector with the frame numbers of the image files in path, with
%filePrefix of the type:'_\d+_\d+.tif', where the first integer is site.
function [frames] = findAllFramesPerSite(projectDir, filePrefix,sitenum)
frames=[];
fpath=sprintf('%s_%d_%s.tif',filePrefix,sitenum,'*');
dirOutput = dir(fullfile(projectDir, fpath));
FileVec   = {dirOutput.name}';
if(isempty(FileVec))    
    return;
end
DateList  = {dirOutput.date}';
datenumList = datenum(DateList);
[VecDate, ind] = sort(datenumList);
FileVec = FileVec(ind);
for i=1:length(FileVec)
    fname=FileVec{i};
    j=regexp(fname,'\d+.tif');
    k=regexp(fname,'.tif');
    if(isempty(j))
        msgbox('problem with filename')
        return;
    end
    frames(i)=str2num(fname(j:k-1));
end
end