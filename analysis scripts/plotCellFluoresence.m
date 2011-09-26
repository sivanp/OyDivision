function plotCellFluoresence(lymph,fluoNum,color)
flu=lymph.fluos{fluoNum};
[sframes,inds]=sort(flu.Frames);
sMeans=flu.Means(inds);
plot(sframes,sMeans,color);
title(flu.name);
end


 