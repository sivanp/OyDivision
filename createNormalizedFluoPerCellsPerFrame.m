%this creates a normalized fluoresence images from the images in the given FileDir, which
%startes with the fileNameTemplate.
%Each frame is eliminating the masking of cells and filling them with the
%background.
%the assumption is that the names of the 2 channels used is:
%fluo: fileNameTemplate_filter_3_expo(d*)_offset10_d*_normzliazed_d*.tif
%All image files matching these names will be normalized according to the
%bg variable and the given calibration slide.
function createNormalizedFluoPerCellsPerFrame(projectDir,movie)
[fileName, FileDir]= uigetfile('*.tif', 'choose fluoresence file type (including site)',projectDir);
nameTokens=regexp(fileName,'(.+)_(\d+)_normalized_(\d+.tif)','tokens');
if(isempty(nameTokens))
    msgbox('file name cannot be parsed');
    return;
end
se = strel('disk',10);
fluoExp = sprintf('%s_%s_normalized*',nameTokens{1}{1},nameTokens{1}{2});
fluoOutput = dir(fullfile(FileDir, fluoExp));
fluoFileVec   = {fluoOutput.name}';
sitenum=str2num(nameTokens{1}{2});
%going over all files
for j=1:length(fluoFileVec)
    rname=fullfile(FileDir,fluoFileVec{j});
    nameTokens=regexp(rname,'(.+)_(filter.+_\d+)_normalized_(\d+).tif','tokens');
    fluo=imread(rname);
    fluoHoles=fluo;
    %need to find the number of the site and enter the word
    %"normalized" before on the output file.
    framenum=str2num(nameTokens{1}{3});  
    
    outName=sprintf('%s_normalizedPerCell_%s_%d.tif',nameTokens{1}{1},nameTokens{1}{2},framenum);
    
    lymphs=movie.sites(sitenum).lymphs;
    
    for i=1:length(lymphs)
        lymph=lymphs(i);
        ind=find(lymph.frames==framenum);
        if(isempty(ind))
            continue;
        end
        locations=lymph.locations(ind);
        cellMask=poly2mask(lymph.locations{ind}(:,1),lymph.locations{ind}(:,2),size(fluo,1),size(fluo,2));
        [xs,ys]=find(cellMask==1);
        fluoHoles(xs,ys)=0;
    end
    bwthresh=ones(size(fluoHoles));
    inds=find(fluoHoles==0);
    bwthresh(inds)=0;
    bwthresh=imerode(bwthresh,se);
    %     inds=find(bwthresh==0);
    %     fluoHoles(inds)=0;
    fluoHoles=roifill(fluoHoles,1-bwthresh);
    newfluo=fluo-fluoHoles;
%     figure()
%     imshow(fluo,[]);
%     figure()
%     imshow(newfluo,[]);
        imwrite(newfluo,outName);
end
end
