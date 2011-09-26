function display_final_image(im,range,labels_data,i,BWper,default_color,label_font,varargin)
    global SITE;
    
    if(isempty(varargin))
        figure(1);
    else
        axes(varargin{1});
    end

    if(length(varargin) == 2)
        SITE = varargin{2};
    end
    
    if(find(~isnan(im) & im > 0))
        imshow(im,range);
    else
        imshow(im);
    end
    title(strcat('site: ', num2str(SITE),'frame: ',num2str(i)));%,'InitialMagnification','fit'); pause(1/100);
    [Xp,Yp] = ind2sub(size(BWper),find(BWper==1));
    hold on;
    plot(Yp,Xp,'.','color','blue','MarkerSize',1)
    set(gca,'YDir','reverse');
%     %TODO add display cell names
%     for n = 1:length(labels_data.cell_names)
%         if(isempty(labels_data.cell_names{n}))
%             continue;
%         end
%         x = labels_data.cell_cent{n}(1,1);
%         y = labels_data.cell_cent{n}(1,2);
%         if(labels_data.just_born(n) == 1 || labels_data.just_born(n) == 2) %newborn
%             text(x,y,labels_data.cell_names{n},'Color','yellow','FontSize',label_font);
%         elseif(labels_data.just_born(n) == -1) %orphan
%             text(x,y,labels_data.cell_names{n},'Color',[1 0.5 0],'FontSize',label_font);
%         elseif(labels_data.just_born(n) == -2 || labels_data.just_born(n) == -3 ) %lost child or union
%             text(x,y,labels_data.cell_names{n},'Color','red','FontSize',label_font);
%         elseif(labels_data.just_born(n) == 3) %newborn but classified as lost
%             text(x,y,labels_data.cell_names{n},'Color','magenta','FontSize',label_font);
%         elseif(labels_data.just_born(n) == -5) %cell death
%             text(x,y,strcat(labels_data.cell_names{n},' died!'),'Color','red','FontSize',label_font);
%         else %status que (0) or just before union (-4)
%             text(x,y,labels_data.cell_names{n},'Color',default_color,'FontSize',label_font);
%         end
%     end
    hold off;