function alignImages(projectDir, filePrefix, sitenum,outputDir)
projectDirSwitched=switchSlashes(projectDir);
baseImageName=sprintf('%s/%s_%d_%s.tif',projectDirSwitched,filePrefix,sitenum,'%d');
frames=findAllFramesPerSite(projectDir, filePrefix,sitenum);
motions=fullCalcMotions(baseImageName,frames,'trans');
margin=round(max(abs(motions(:))));
acc_u=0;
acc_v=0;

for i=1:length(frames)
    acc_u=acc_u-round(motions(i,1));
    acc_v=acc_v-round(motions(i,2));
    im=imread(sprintf('%s/%s_%d_%d.tif',projectDir,filePrefix,sitenum,frames(i)));
    imnew=zeros(size(im,1)+2*margin,size(im,2)+2*margin,'uint16');
    imnew(margin+1+acc_v:margin+size(im,1)+acc_v,margin+1+acc_u:margin+size(im,2)+acc_u)=im;
    filename=sprintf('%s/%s_%d_%d.tif',outputDir,filePrefix,sitenum,frames(i));
    imwrite(imnew,filename,'tif')
end
end