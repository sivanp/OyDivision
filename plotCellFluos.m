function plotCellFluos(lymph)
figure();
fnum=length(lymph.fluos);
    for i=1:length(lymph.fluos)
        flu=lymph.fluos{i};
        found1=regexp(flu.name,'KO', 'ignorecase');
        found1=found1{1};
        if(~isempty(found1))
            subplot(fnum,1,i)
            plotCellFluoresence(lymph,i,'r');
        end
        found2=regexp(flu.name,'GFP', 'ignorecase');
        found2=found2{1};
        if(~isempty(found2))
            subplot(fnum,1,i)
            plotCellFluoresence(lymph,i,'g');
        end
        if(isempty(found1)&& isempty(found2))
            subplot(fnum,1,i)
            plotCellFluoresence(lymph,i,'b');
        end        
    end
    suptitle(lymph.name);
end