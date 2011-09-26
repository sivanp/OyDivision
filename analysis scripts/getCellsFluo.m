%assumes that the first frame number is 1001.
%returns time and fluoresence vectors- sorted according to time.
function [times, fluo]=getCellsFluo(lymphid,fluonum, movie)
times=[];
fluo=[];
lymph=getLymph(lymphid, movie);
if(isempty(lymph) || isempty(lymph.fluos{fluonum}) || isempty(lymph.frames))
    return;
end
if(~isfield(lymph.fluos{fluonum},'Frames'))
    return;
end
frames=lymph.fluos{fluonum}.Frames;
fluo=lymph.fluos{fluonum}.Means;
[frames, inds]= sort(frames);
frames=frames-1000;
fluo=fluo(inds);
times=movie.times(frames);
end