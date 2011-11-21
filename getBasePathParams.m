function [baseTemplate,lastFrame,firstFrame]=getBasePathParams(FileDir,basepath)
baseTemplate=[];
lastFrame=[];
firstFrame=[];
nameTokens=regexp(basepath,'(.+)_expo.+(\d+)','tokens');
baseTemplate=nameTokens{1}{1};

templateName= sprintf('%s*',baseTemplate);
fOutput = dir(fullfile(FileDir,templateName));
fileVec   = {fOutput.name}';
DateList  = {fOutput.date}';
datenumList = datenum(DateList);
[VecDate, ind] = sort(datenumList);
lastFile = fileVec(ind(end));
nameTokens=regexp(lastFile,'.+_expo.+_(\d+).tif','tokens');
lastFrame=str2num(nameTokens{1}{1}{1});
firstFile = fileVec(ind(1));
nameTokens=regexp(firstFile,'.+_expo.+_(\d+).tif','tokens');
firstFrame=str2num(nameTokens{1}{1}{1});

end

