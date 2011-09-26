%this creates a normalized fluoresence images from the images in the given FileDir, which
%startes with the fileNameTemplate
%the assumption is that the names of the 2 channels used is:
%red: fileNameTemplate_filter_1_expo(d*)_offset10_d*_d*.tif
%green: fileNameTemplate_filter_3_expo(d*)_offset10_d*_d*.tif
%All image files matching these names will be normalized according to the
%bg variable and the given calibration slide.
function createNormalizedFluo(projectDir)

[fileName, FileDir]= uigetfile('*.tif', 'choose fluoresence file type',projectDir);
nameTokens=regexp(fileName,'(.+)_(\d+_\d+.tif)','tokens');
if(isempty(nameTokens))
    msgbox('file name cannot be parsed');
    return;
end
[calibrationPath,calibrationDir]= uigetfile('*.tif', 'calibration slide',projectDir);
calib=im2double(imread(fullfile(calibrationDir, calibrationPath)));

backg= inputdlg('what is the camera background?');
bg=str2num(backg{1});
if(isempty(bg))
    msgbox('background is not numeric');
    return;
end

fluoExp = sprintf('%s*',nameTokens{1}{1});
fluoOutput = dir(fullfile(FileDir, fluoExp));
fluoFileVec   = {fluoOutput.name}';

%going over all files

for j=1:length(fluoFileVec)
    rname=fullfile(FileDir,fluoFileVec{j});
    nameTokens=regexp(rname,'(.+)_(\d+_\d+.tif)','tokens');
    fluo=imread(rname);
    %need to find the number of the site and enter the word
    %"normalized" before on the output file.    
    outName=sprintf('%s_normalized_%s',nameTokens{1}{1},nameTokens{1}{2});
    fluo=fluo-bg;
    fluo=im2double(fluo);
    fluo=fluo./calib;
    imwrite(fluo,outName);
    
end
end
