function varargout = movie_editor(varargin)
% MOVIE_EDITOR M-file for movie_editor.fig
%      MOVIE_EDITOR, by itself, creates a new MOVIE_EDITOR or raises the existing
%      singleton*.
%
%      H = MOVIE_EDITOR returns the handle to a new MOVIE_EDITOR or the handle to
%      the existing singleton*.
%
%      MOVIE_EDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVIE_EDITOR.M with the given input arguments.
%
%      MOVIE_EDITOR('Property','Value',...) creates a new MOVIE_EDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before movie_editor_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to movie_editor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help movie_editor

% Last Modified by GUIDE v2.5 22-May-2011 18:28:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @movie_editor_OpeningFcn, ...
                   'gui_OutputFcn',  @movie_editor_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before movie_editor is made visible.
function movie_editor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to movie_editor (see VARARGIN)

% Choose default command line output for movie_editor
handles.output = hObject;
axes(handles.img);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes movie_editor wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = movie_editor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Rwd_pushbutton.
function Rwd_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Rwd_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(handles.cur_frame_ind > 1)
    handles.prev_frame_ind = handles.cur_frame_ind;
    handles.cur_frame_ind = handles.cur_frame_ind - 1;
    handles.xlim = get(handles.img,'XLim');
    handles.ylim = get(handles.img,'YLim');
    zoom off;
    cur_frame = handles.settings.FRAMES(handles.cur_frame_ind);
    set(handles.frame_edit,'String',num2str(cur_frame));
    set(handles.from_edit,'String',num2str(cur_frame));
    set(handles.to_edit,'String','');
    site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
    edited_site_lib = site_lib;
    edited_site_lib(end)= '';
    edited_site_lib = strcat(edited_site_lib,'_edited/');
    labels_file = strcat(site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
    edited_labels_file = strcat(edited_site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
    try
        load(edited_labels_file);
    catch
        try
            load(labels_file);
        catch
            labels= zeros(size(handles.labels));
            handles.labels_array(handles.cur_frame_ind) = insert_empty_frame();
        end
    end
    handles.labels = LABELS;
    if(~isempty(handles.cur_id))
        next_id = find_next_id(handles);
        handles = update_cell_record(handles,next_id);
    end
    axes(handles.img);
    im=display_image(handles);
    if(get(handles.segment_togglebutton,'Value')==1)
        t = str2double(get(handles.thresh_edit,'String'));
        bw_thresh = im2bw(im,t);
        [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
        hold on;
        plot(Yb,Xb,'.r','MarkerSize',1);
        hold off;
        handles.bw_thresh = bw_thresh;
    end
end
guidata(hObject, handles);    


% --- Executes on button press in Fwd_pushbutton.
function Fwd_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Fwd_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(handles.cur_frame_ind < length(handles.settings.FRAMES))
    handles.prev_frame_ind = handles.cur_frame_ind;
    handles.cur_frame_ind = handles.cur_frame_ind + 1;
    handles.xlim = get(handles.img,'XLim');
    handles.ylim = get(handles.img,'YLim');
    zoom off;
    cur_frame = handles.settings.FRAMES(handles.cur_frame_ind);
    set(handles.frame_edit,'String',num2str(cur_frame));
    set(handles.from_edit,'String',num2str(cur_frame));
    set(handles.to_edit,'String','');
    site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
    edited_site_lib = site_lib;
    edited_site_lib(end)= '';
    edited_site_lib = strcat(edited_site_lib,'_edited/');
    labels_file = strcat(site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
    edited_labels_file = strcat(edited_site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
    try
        load(edited_labels_file);
    catch
        try
            load(labels_file);
        catch
            LABELS = zeros(size(handles.labels));
            handles.labels_array(handles.cur_frame_ind) = insert_empty_frame();
        end
    end
    handles.labels = LABELS;
    if(~isempty(handles.cur_id))
        next_id = find_next_id(handles);
        handles = update_cell_record(handles,next_id);
    end
    axes(handles.img);
    im=display_image(handles);
    if(get(handles.segment_togglebutton,'Value')==1)
        t = str2double(get(handles.thresh_edit,'String'));
        bw_thresh = im2bw(im,t);
        [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
        hold on;
        plot(Yb,Xb,'.r','MarkerSize',1);
        hold off;
        handles.bw_thresh = bw_thresh;
    end
end
guidata(hObject, handles);



function addThreshold(handles)
t = str2double(get(handles.thresh_edit,'String'));
bw_thresh = im2bw(im,t);
[Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
hold on;
plot(Yb,Xb,'.r','MarkerSize',1);

        
function site_edit_Callback(hObject, eventdata, handles)
% hObject    handle to site_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site_edit as text
%        str2double(get(hObject,'String')) returns contents of site_edit as a double
val = str2num(get(hObject,'String'));
if(val>0)
    handles.cur_site = val;
else
    disp('site is not a valid value')
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function site_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cell_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to cell_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell_name_edit as text
%        str2double(get(hObject,'String')) returns contents of cell_name_edit as a double

save_array_data(handles,'prev');
name = get(hObject,'String');
labels_array = handles.labels_array;
labels_array(handles.cur_frame_ind).cell_names{handles.cur_id} = name;
handles.labels_array = labels_array;
save_array_data(handles);
im=display_image(handles);
if(get(handles.segment_togglebutton,'Value')==1)
    t = str2double(get(handles.thresh_edit,'String'));
    bw_thresh = im2bw(im,t);
    [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
    hold on;
    plot(Yb,Xb,'.r','MarkerSize',1);
    hold off;
    handles.bw_thresh = bw_thresh;
end
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function cell_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function cell_id_edit_Callback(hObject, eventdata, handles)
% hObject    handle to cell_id_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cell_id_edit as text
%        str2double(get(hObject,'String')) returns contents of cell_id_edit as a double


% --- Executes during object creation, after setting all properties.
function cell_id_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cell_id_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pred_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pred_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pred_name_edit as text
%        str2double(get(hObject,'String')) returns contents of pred_name_edit as a double

save_array_data(handles,'prev');
pred_id_vec = [];
pred_id_arr = {};
pred_names = get(hObject,'String');
prev_names = handles.labels_array(handles.cur_frame_ind - 1).cell_names;
for i=1:1:length(pred_names)
    for j=1:1:length(prev_names)
        if(strcmp(pred_names{i},prev_names{j}))
            pred_id_vec(i) = j;
            pred_id_arr{i} = num2str(j);
            break;
        end
    end
end
    
set(handles.pred_id_edit,'String',pred_id_arr);
id = handles.cur_id;
labels_array = handles.labels_array;
labels_array(handles.cur_frame_ind).prev_label{id} = pred_id_vec;
handles.labels_array = labels_array;
save_array_data(handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pred_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pred_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pred_id_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pred_id_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pred_id_edit as text
%        str2double(get(hObject,'String')) returns contents of pred_id_edit as a double

save_array_data(handles,'prev');
pred_id_vec = [];
pred_names = {};
ans = get(hObject,'String');
if(ischar(ans))
    pred_id = split_str(get(hObject,'String'),' ');
elseif(iscell(ans))
    pred_id = ans;
end
prev_names = handles.labels_array(handles.cur_frame_ind - 1).cell_names;
for i=1:1:length(pred_id)
    pred_id_vec(i) = str2num(pred_id{i});
    if(pred_id_vec(i) == 0)
        pred_names{i} = '';
    else
        pred_names{i} = prev_names{str2num(pred_id{i})};
    end
end
set(handles.pred_name_edit,'String',pred_names);
id = handles.cur_id;
labels_array = handles.labels_array;
labels_array(handles.cur_frame_ind).prev_label{id} = pred_id_vec;
handles.labels_array = labels_array;
save_array_data(handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pred_id_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pred_id_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_poly_pushbutton.
function add_poly_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to add_poly_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
    edited_site_lib = site_lib;
    edited_site_lib(end)= '';
    edited_site_lib = strcat(edited_site_lib,'_edited/');
    red_filetmp = strcat(site_lib,sprintf(handles.settings.FILETEMP_RED,handles.cur_site));
    green_filetmp = strcat(site_lib,sprintf(handles.settings.FILETEMP_GREEN,handles.cur_site));
    edited_labels_file = strcat(edited_site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
    
    handles.xlim = get(handles.img,'XLim');
    handles.ylim = get(handles.img,'YLim');
    save_labels_data(handles,'prev');
    save_array_data(handles,'prev');
    axes(handles.img);
    zoom off;
    [BW xi yi] = roipoly();
    hold on;
    plot(xi,yi,'y');
    ids = handles.labels(sub2ind(size(handles.labels),floor(yi),floor(xi)));
    ids = unique(ids);
    id_ind = find(ids > 0);
    if(isempty(id_ind)) 
        new_id = max(max(handles.labels(:)),length(handles.labels_array(handles.cur_frame_ind).cell_names))+1;
        new_name = strcat('E',num2str(new_id));
    elseif(length(id_ind) > 1) %multiple labels
        new_id = max(max(handles.labels(:)),length(handles.labels_array(handles.cur_frame_ind).cell_names))+1;
        for i = 1:1:length(id_ind)
            id =ids(id_ind(i));
            BW(handles.labels==id) = 0;
            handles.labels(find(handles.labels==id)) = new_id;
            handles.labels_array = remove_label(handles.labels_array,[],[],[],id,handles.cur_frame_ind);
        end
        new_name = strcat('E',num2str(new_id));
    elseif(ids(id_ind) > length(handles.labels_array(handles.cur_frame_ind).cell_names) || isempty(handles.labels_array(handles.cur_frame_ind).cell_names{ids(id_ind)})) %unused existing label
        handles.labels(find(handles.labels==ids(id_ind))) = 0;
        new_id = max(max(handles.labels(:)),length(handles.labels_array(handles.cur_frame_ind).cell_names))+1;
        new_name = strcat('E',num2str(new_id));
    else %existing label
        new_id = ids(id_ind);
        labels_data = handles.labels_array(handles.cur_frame_ind);
        handles.prev = labels_data.prev_label{new_id};
        new_name = labels_data.cell_names{new_id};
    end
    handles.labels = handles.labels + int32(BW)*new_id;
    new_cent = regionprops(handles.labels, 'Centroid');
    new_cent = new_cent(new_id).Centroid;
    new_x = new_cent(1,1);
    new_y = new_cent(1,2);
    new_area = regionprops(handles.labels,'Area');
    new_area = new_area(new_id).Area;
    red_flu = NaN;
    green_flu = NaN;
    handles = insert_new_record(handles,new_id,new_name,new_x,new_y,new_area,red_flu,green_flu,handles.prev);
    handles = update_cell_record(handles,new_id);
    im=display_image(handles);
    if(get(handles.segment_togglebutton,'Value')==1)
        t = str2double(get(handles.thresh_edit,'String'));
        bw_thresh = im2bw(im,t);
        [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
        hold on;
        plot(Yb,Xb,'.r','MarkerSize',1);
        hold off;
        handles.bw_thresh = bw_thresh;
    end
    LABELS = handles.labels;
    save_labels_data(handles);
    save_array_data(handles);
    guidata(hObject, handles);


% --- Executes on button press in del_pushbutton.
function del_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to del_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
    edited_site_lib = site_lib;
    edited_site_lib(end)= '';
    edited_site_lib = strcat(edited_site_lib,'_edited/');
    edited_labels_file = strcat(edited_site_lib,'labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));

    handles.xlim = get(handles.img,'XLim');
    handles.ylim = get(handles.img,'YLim');
    save_array_data(handles,'prev');
    save_labels_data(handles,'prev');
    axes(handles.img);
    zoom off;
    [x y] = ginput(1);
    id = handles.labels(floor(y),floor(x));
    handles.labels(find(handles.labels==id)) = 0;
    handles.labels_array = remove_label(handles.labels_array,[],[],[],id,handles.cur_frame_ind);
    clear('x', 'y');
    handles = update_cell_record(handles,id);
    im=display_image(handles);
    if(get(handles.segment_togglebutton,'Value')==1)
        t = str2double(get(handles.thresh_edit,'String'));
        bw_thresh = im2bw(im,t);
        [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
        hold on;
        plot(Yb,Xb,'.r','MarkerSize',1);
        hold off;
        handles.bw_thresh = bw_thresh;
    end
    LABELS = handles.labels;
    save_labels_data(handles);
    save_array_data(handles);
    guidata(hObject, handles);

    
% --- Executes on button press in refresh_pushbutton.


% --- Executes on button press in get_pushbutton.
function get_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to get_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.img);
zoom off;
[x y] = ginput(1);
id = handles.labels(floor(y),floor(x));
if(id > 0)
    handles.cur_id = id;
    handles = update_cell_record(handles,id);
    guidata(hObject, handles);
end
clear('x', 'y');


    
    
    
function im = display_image(handles,varargin)
[framepath labelsfile ]=getPaths;

set(handles.img,'XLim',handles.xlim);
set(handles.img,'YLim',handles.ylim);
axes(handles.img);
imshow(im,[]);    

% phase_filetmp = strcat(handles.settings.PREFIX,sprintf(handles.settings.FILETEMP,handles.cur_site));
%     site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
%     edited_site_lib = site_lib;
%     edited_site_lib(end)= '';
%     edited_site_lib = strcat(edited_site_lib,'_edited/');
%     red_filetmp = sprintf(handles.settings.FILETEMP_RED,handles.cur_site);
%     green_filetmp = sprintf(handles.settings.FILETEMP_GREEN,handles.cur_site);
%     prev_frame = handles.settings.FRAMES(handles.prev_frame_ind);
%     cur_frame = handles.settings.FRAMES(handles.cur_frame_ind);
%     [acc_u acc_v]  = calc_shift(prev_frame,cur_frame,handles.mos);
%     phase_filename = sprintf(phase_filetmp, cur_frame);
%     output_filename = sprintf(output_filetmp, cur_frame);
%     im = imread(phase_filename);
%     im = im2double(im);
%     im = normalize_mat_by_range(im,max(im(:)),min(im(:)),[0 1]);
%     [im margin_mask] = translate_image(im,acc_u,acc_v,[],handles.settings.MARGIN,handles.settings.DIAM);
%     im_orig_RGB = zeros(size(im,1),size(im,2),3);
%     im_orig_RGB(:,:,1) = im;
%     im_orig_RGB(:,:,2) = im;
%     im_orig_RGB(:,:,3) = im;
%     try
%         red_filename = strcat(site_lib,sprintf(red_filetmp,cur_frame)); 
%         edited_red_filename = strcat(edited_site_lib,sprintf(red_filetmp,cur_frame)); 
%         green_filename = strcat(site_lib,sprintf(green_filetmp,cur_frame));
%         edited_green_filename = strcat(edited_site_lib,sprintf(green_filetmp,cur_frame));
%         if(exist(red_filename,'file') && exist(green_filename,'file'))
%             im_red_RGB = zeros(size(im,1),size(im,2),3);
%             im_green_RGB = zeros(size(im,1),size(im,2),3);
%             if(exist(edited_red_filename,'file'))
%                 im_red = imread(edited_red_filename);
%                 im_green = imread(edited_green_filename);
%             else
%                 im_red = imread(red_filename);
%                 im_green = imread(green_filename);
%             end
%             im_red_RGB(:,:,1) = normalize_mat_by_range(double(im_red),handles.params.max_red,handles.params.min_red,[0 1]);
%             im_green_RGB(:,:,2) = normalize_mat_by_range(double(im_green),handles.params.max_green,handles.params.min_green,[0 1]);
%             im_orig_RGB = imadd(im_orig_RGB,im_red_RGB);
%             im_orig_RGB = imadd(im_orig_RGB,im_green_RGB);
%         end
        
%% TODO NEED TO load the labels here?
%         BWper = bwperim(im2bw(double(handles.labels)));
% BWper=[];
% %         display_final_image(im_orig_RGB,[],handles.labels_array(handles.cur_frame_ind),cur_frame,BWper,'blue',10,handles.img,handles.cur_site);
%         display_final_image(im,[],[],cur_frame,BWper,'blue',10,handles.img,handles.cur_site);
%         if(~isempty(handles.ylim))
%             set(handles.img,'XLim',handles.xlim);
%             set(handles.img,'YLim',handles.ylim);
%         end
%         hold off;
%     catch
%         axes(handles.img);
%         imshow(im,[]),title(strcat('site: ', num2str(handles.cur_site),'frame: ',num2str(cur_frame)));
%         hold off;
%     end
    
    
function [acc_u acc_v]  = calc_shift(from,to,mos)
    
%     if(from > to)
%         start_f = to;
%         end_f = from;
%         direction = -1;
%     else
%         start_f = from;
%         end_f = to;
%         direction = 1;
%     end
%     acc_u = 0;
%     acc_v = 0;
%     
%     for j = start_f+1:1:end_f
%         % aligning the picture
%         acc_u = acc_u + mos(j, 1);
%         acc_v = acc_v + mos(j, 2);
%     end
%     acc_u = direction*acc_u;
%     acc_v = direction*acc_v;

    acc_u = 0;
    acc_v = 0;
    
    for j = 1:1:to
        % aligning the picture
        acc_u = acc_u + mos(j, 1);
        acc_v = acc_v + mos(j, 2);
    end
    
function    im  = crop_margins(im)
    global MARGIN;

    im = im(MARGIN+1:end-MARGIN,MARGIN+1:end-MARGIN) ;


function handles = update_cell_record(handles,id)
    
    labels_data = handles.labels_array(handles.cur_frame_ind);
    if(isempty(id)||id > length(labels_data.cell_names) || isempty(labels_data.cell_names{id}))
        set(handles.cell_id_edit,'String','');
        set(handles.cell_name_edit,'String','');
        set(handles.x_edit,'String','');
        set(handles.y_edit,'String','');
        set(handles.cell_status_listbox,'Value',1);
        set(handles.area_edit,'String','');
        set(handles.red_edit,'String','');
        set(handles.green_edit,'String','');
        handles.prev = handles.cur_id;
        set(handles.pred_id_edit,'String',num2str(handles.cur_id));
        prev_names = handles.labels_array(handles.prev_frame_ind).cell_names;
        if(handles.cur_id <= length(prev_names))
            set(handles.pred_name_edit,'String',prev_names{handles.cur_id});
        end
    else
        set(handles.cell_id_edit,'String',num2str(id));
        set(handles.cell_name_edit,'String',labels_data.cell_names{id});
        if(isempty(labels_data.cell_cent{id}))
            set(handles.x_edit,'String','');
            set(handles.y_edit,'String','');
        else
            set(handles.x_edit,'String',num2str(labels_data.cell_cent{id}(1,1)));
            set(handles.y_edit,'String',num2str(labels_data.cell_cent{id}(1,2)));
        end
        if(labels_data.just_born(id) == 1 || labels_data.just_born(id) == 2) %newborn
                set(handles.cell_status_listbox,'Value',4);
        elseif(labels_data.just_born(id) == -1) %orphan
                set(handles.cell_status_listbox,'Value',2);
        elseif(labels_data.just_born(id) == -2) %lost
                set(handles.cell_status_listbox,'Value',3);
        elseif(labels_data.just_born(id) == -3 ) %union
                set(handles.cell_status_listbox,'Value',5);
        elseif(labels_data.just_born(id) == 3) %newborn but classified as lost
               set(handles.cell_status_listbox,'Value',6);
        elseif(labels_data.just_born(id) == -5) %cell death
            set(handles.cell_status_listbox,'Value',7);
        else %status que (0) or just before union (-4)
               set(handles.cell_status_listbox,'Value',1);
        end

        try
            pred_ids = {};
            pred_names = {};
            prev_label = labels_data.prev_label{id};
            prev_names = handles.labels_array(handles.cur_frame_ind-1).cell_names;
            handles.prev = prev_label;
            for i=1:1:length(prev_label)
                pred_ids = [pred_ids num2str(prev_label(i))];
                pred_names = [pred_names prev_names{prev_label(i)}];
            end
            set(handles.pred_id_edit,'String',pred_ids);
            set(handles.pred_name_edit,'String',pred_names);
        catch
            handles.prev = [];
            set(handles.pred_id_edit,'String',[]);
            set(handles.pred_name_edit,'String',[]);
        end
        if(id <= length(labels_data.cell_area) && ~isempty(labels_data.cell_area(id)))
            area = labels_data.cell_area(id);
        else
            area = -1;
        end
        set(handles.area_edit,'String',num2str(area));
        try
            if(isnan(labels_data.red_flu(id)))
                set(handles.red_edit,'String','');
            else
                set(handles.red_edit,'String',num2str(labels_data.red_flu(id)));
            end
            if(isnan(labels_data.green_flu(id)))
                set(handles.green_edit,'String','');
            else
                set(handles.green_edit,'String',num2str(labels_data.green_flu(id)));
            end
        catch
            set(handles.red_edit,'String','');
            set(handles.green_edit,'String','');
        end
    end
    handles.cur_id = id;

% --- Executes on button press in zoom_togglebutton.
function zoom_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zoom_togglebutton
val = get(hObject,'Value');
if(val == 1)
    axes(handles.img);
    zoom on;
else
    axes(handles.img);
    zoom out;
    zoom off;
end
guidata(hObject, handles);

    
function handles = insert_new_record(handles,new_id,new_name,new_x,new_y,new_area,red_flu,green_flu,varargin)
    handles.cur_id = new_id;
    labels_data = handles.labels_array(handles.cur_frame_ind);
    labels_data.cell_names{new_id} = new_name;
    labels_data.cell_cent{new_id}(1,1) = new_x;
    labels_data.cell_cent{new_id}(1,2) = new_y;
    labels_data.just_born(new_id) = 0;
    labels_data.edited(new_id) = 1;
    if(~isempty(varargin))
        labels_data.prev_label{new_id} =  varargin{1};
    else
        labels_data.prev_label{new_id} = [];
    end
    labels_data.cell_area(new_id) = new_area;
    if(isfield(labels_data,'red_flu') && ~isempty(labels_data.red_flu))
        labels_data.red_flu(new_id) = red_flu;
        labels_data.green_flu(new_id) = green_flu;
    end
    handles.labels_array(handles.cur_frame_ind) = labels_data;

function next_id = find_next_id(handles)
    try
        label_data = handles.label2course{handles.prev_frame_ind}{handles.cur_id};
        end_frame = label_data(1,1);
        course_ind = label_data(1,2);
        label_ind = label_data(1,3);
        course = handles.endpoint_frames{end_frame}{course_ind};
        [net_course parent children] = trim_edge_info(course);
        gap = handles.cur_frame_ind - handles.prev_frame_ind;
        if(label_ind+gap <= length(net_course) && label_ind + gap >=1)
            next_id = net_course(label_ind + gap);
        else
            next_id = [];
        end
    catch
        next_id = [];
    end
    


% --- Executes on button press in add_circle_pushbutton.
function add_circle_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to add_circle_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.img);
zoom off;
im=display_image(handles); %% TODO why is this here????

% ploting the circle
[cx cy] = ginput(1);
hold on;
plot(cx,cy,'xy','MarkerSize',15);
c = [cx cy];
[ex ey] = ginput(1);
plot(ex,ey,'.b','MarkerSize',15);
e = [ex ey];
r1 = (0:0.1:2*pi)';
circx = sin(r1);
circy = cos(r1);
radius = sqrt(sum((c-e).^2));
circx = circx*radius+c(1);
circy = circy*radius+c(2);
plot(circx,circy,'.y','MarkerSize',1);
[BW xi yi] = roipoly(im,circx,circy);
plot(xi,yi,'y');


%xi and yi are vectors of the same size of the coordinates of the
%polygon/circle of the selected cell perimeter.
function [labelsIDs]= checkLabelClashes(BW, xi,yi, handles)
[im labels ]=getFrameAndLabels(handles);
ids =labels(sub2ind(size(labels),floor(yi),floor(xi)));
ids = unique(ids);
id_ind = find(ids > 0);
if(isempty(id_ind)) 
    %need to issue a new cells
%     new_id = max(max(handles.labels(:)),length(handles.labels_array(handles.cur_frame_ind).cell_names))+1;
%     new_name = strcat('E',num2str(new_id));
elseif(length(id_ind) > 1) %multiple labels
%     new_id = max(max(handles.labels(:)),length(handles.labels_array(handles.cur_frame_ind).cell_names))+1;
%     for i = 1:1:length(id_ind)
%         id =ids(id_ind(i));
%         BW(handles.labels==id) = 0;
%         handles.labels(find(handles.labels==id)) = new_id;
%         handles.labels_array = remove_label(handles.labels_array,[],[],[],id,handles.cur_frame_ind);
%     end
%     new_name = strcat('E',num2str(new_id));
% elseif(ids(id_ind) >
% length(handles.labels_array(handles.cur_frame_ind).cell_names) ||
% isempty(handles.labels_array(handles.cur_frame_ind).cell_names{ids(id_ind
% )})) %unused existing label- this is probably due to some kind of mistake
% in the data structure
%         handles.labels(find(handles.labels==ids(id_ind))) = 0;
%         new_id = max(max(handles.labels(:)),length(handles.labels_array(handles.cur_frame_ind).cell_names))+1;
%         new_name = strcat('E',num2str(new_id));
else %existing label
%     new_id = ids(id_ind);
%     labels_data = handles.labels_array(handles.cur_frame_ind);
%     handles.prev = labels_data.prev_label{new_id};
%     new_name = labels_data.cell_names{new_id};
end

%changing the labels structure
labels = int32(labels) + int32(BW)*new_id;
% new_cent = regionprops(handles.labels, 'Centroid');
% new_cent = new_cent(new_id).Centroid;
% new_x = new_cent(1,1);
% new_y = new_cent(1,2);
% new_area = regionprops(handles.labels,'Area');
% new_area = new_area(new_id).Area;
% red_flu = NaN;
% green_flu = NaN;
% handles = insert_new_record(handles,new_id,new_name,new_x,new_y,new_area,red_flu,green_flu,handles.prev);
% handles = update_cell_record(handles,new_id);
im=display_image(handles);
if(get(handles.segment_togglebutton,'Value')==1)
    t = str2double(get(handles.thresh_edit,'String'));
    display_thresh(handles,t);
end
% save_labels_data(handles);
% save_array_data(handles);
% guidata(hObject, handles);


% --- Executes on slider movement.
function thresh_slider_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
t = get(hObject,'Value');
if(t >= get(hObject,'Min') && t<= get(hObject,'Max'))
display_thresh(handles,t);
else
    disp('threshold value out of bounds')
end
set(handles.thresh_edit,'String',num2str(t));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function thresh_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function thresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh_edit as text
%        str2double(get(hObject,'String')) returns contents of thresh_edit as a double
t = str2double(get(hObject,'String'));
display_thresh(handles,t);
set(handles.thresh_slider,'Value',t);
guidata(hObject,handles);

function display_thresh(handles,t)
handles.xlim = get(handles.img,'XLim');
handles.ylim = get(handles.img,'YLim');
im = display_image(handles);
bw_thresh = im2bw(im,t);
[Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
hold on;
plot(Yb,Xb,'.r','MarkerSize',1);
hold off;



% --- Executes during object creation, after setting all properties.
function thresh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in segment_togglebutton.
function segment_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to segment_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of segment_togglebutton

val = get(hObject,'Value');
% handles.xlim = get(handles.img,'XLim');
% handles.ylim = get(handles.img,'YLim');
% im = display_image(handles);
if(val == 0)
    set(handles.add_thresh_pushbutton,'Enable','off');
    set(handles.thresh_edit,'Enable','off');
    set(handles.thresh_slider,'Enable','off');
    handles.bw_thresh = [];
else
%     t = graythresh(im);
%     bw_thresh = im2bw(im,t);
%     [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%     hold on;
%     plot(Yb,Xb,'.r','MarkerSize',1);
%     hold off;
    set(handles.add_thresh_pushbutton,'Enable','on');
    set(handles.thresh_edit,'Enable','on');
    set(handles.thresh_slider,'Enable','on');
    set(handles.thresh_edit,'String',num2str(t));
    set(handles.thresh_slider,'Value',t);
%     handles.bw_thresh = bw_thresh;
    addThreshold(handles);
end
guidata(hObject,handles);

function labels_data = insert_empty_frame()
    labels_data.prev_label = {};
    labels_data.cell_cent = {};
    labels_data.cell_area = [];
    labels_data.cell_circ = [];
    labels_data.cell_names = {};
    labels_data.just_born = [];
    labels_data.green_flu = [];
    labels_data.raw_green_flu = [];
    labels_data.red_flu = [];
    labels_data.raw_red_flu = [];
    labels_data.edited = [];




   
function from_edit_Callback(hObject, eventdata, handles)
% hObject    handle to from_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of from_edit as text
%        str2double(get(hObject,'String')) returns contents of from_edit as a double


% --- Executes during object creation, after setting all properties.
function from_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to from_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function to_edit_Callback(hObject, eventdata, handles)
% hObject    handle to to_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to_edit as text
%        str2double(get(hObject,'String')) returns contents of to_edit as a double


% --- Executes during object creation, after setting all properties.
function to_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Internal functions
function [cell]= createNewCell(id)
cell.id=id;
cell.frames2labels=[];
cell.parent=[];
cell.name='';

function [cell]=addFrameLabel(cell, frame,label)
cell.frames2labels(end+1,:)=[frame label];

%%TODO remember to clear the label from LABELS as well.
function [cell]=deleteCellFrameLabel(cell,frame,label)
inds=find(cell.frames2labels(1,:), frame);
for i=1:length(inds)
    if(cell.frames2label(inds(i),2)==label)
        cell.frames2label(inds(i),:)=[];
    end
end

function [labels]=getLabels(dir,site, frame)
labels=[];
labelsName=[dir '_' site '_' frame];
try
    load(labelsName);
catch
   disp('could not find labels creating empty')
   labels = zeros(size(im));
end

function [im labels]=getFrameAndLabels(handles)
frame=str2num(get(handles.frame_edit,'String'));
fileTemp=get(handles.fileTemp_edit,'String');
dirPath=get(handles.browse_edit,'String');
site=str2num(get(handles.site_edit,'String'));
framepath = sprintf('%s\\%s_%d_%d.tif', dirPath, fileTemp, site ,frame);
labelspath = sprintf('%s\\labels_%s_%d_%d.tif', dirPath, fileTemp, site ,frame);
try
im = imread(framepath);
catch
    disp('cannot load frame');
end
im = im2double(im);
try
    load(labelspath); %suppose to have a variables named labels
 catch
    disp('cannot find labels - creating empty one');    
    labels = zeros(size(im));
end   


% --- Executes on button press in browseFile.
function browseFile_Callback(hObject, eventdata, handles)
% hObject    handle to browseFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileTemplate = uigetfile('','Choose file');
set(handles.fileTemp_edit,'String',fileTemplate);

function fileTemp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fileTemp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileTemp_edit as text
%        str2double(get(hObject,'String')) returns contents of fileTemp_edit as a double
handles.filepath=get(hObject,'String');



% --- Executes during object creation, after setting all properties.
function fileTemp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileTemp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% function name_del_edit_Callback(hObject, eventdata, handles)
% % hObject    handle to name_del_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of name_del_edit as text
% %        str2double(get(hObject,'String')) returns contents of name_del_edit as a double
% site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
% edited_site_lib = site_lib;
% edited_site_lib(end)= '';
% edited_site_lib = strcat(edited_site_lib,'_edited/');
% edited_labels_file = strcat(edited_site_lib,'labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
% 
% handles.xlim = get(handles.img,'XLim');
% handles.ylim = get(handles.img,'YLim');
% save_array_data(handles,'prev');
% save_labels_data(handles,'prev');
% axes(handles.img);
% zoom off;
% cell_name = get(hObject,'String');
% names = handles.labels_array(handles.cur_frame_ind).cell_names;
% id = 0;
% for i=1:1:length(names)
%     if(strcmp(names{i},cell_name))
%         id = i;
%         break;
%     end
% end
% if(id)
%     handles.labels(find(handles.labels==id)) = 0;
%     handles.labels_array = remove_label(handles.labels_array,[],[],[],id,handles.cur_frame_ind);
%     clear('x', 'y');
%     handles = update_cell_record(handles,id);
%     im=display_image(handles);
%     if(get(handles.segment_togglebutton,'Value')==1)
%         t = str2double(get(handles.thresh_edit,'String'));
%         bw_thresh = im2bw(im,t);
%         [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%         hold on;
%         plot(Yb,Xb,'.r','MarkerSize',1);
%         hold off;
%         handles.bw_thresh = bw_thresh;
%     end
%     LABELS = handles.labels;
%     save_labels_data(handles);
%     save_array_data(handles);
% else
%     set(hObject,'String','');
% end
% guidata(hObject, handles);
% 
% 
% % --- Executes during object creation, after setting all properties.
% function name_del_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to name_del_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 


% % --- Executes on button press in refresh_flur_pushbutton.
% function refresh_flur_pushbutton_Callback(hObject, eventdata, handles)
% % hObject    handle to refresh_flur_pushbutton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% handles.xlim = get(handles.img,'XLim');
% handles.ylim = get(handles.img,'YLim');
% save_array_data(handles,'prev');
% handles = update_flur(handles);
% im=display_image(handles);
% if(get(handles.segment_togglebutton,'Value')==1)
%     t = str2double(get(handles.thresh_edit,'String'));
%     bw_thresh = im2bw(im,t);
%     [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%     hold on;
%     plot(Yb,Xb,'.r','MarkerSize',1);
%     hold off;
%     handles.bw_thresh = bw_thresh;
% end
% save_array_data(handles);
% guidata(hObject, handles);

% % --- Executes on button press in reset_frame_pushbutton.
% function reset_frame_pushbutton_Callback(hObject, eventdata, handles)
% % hObject    handle to reset_frame_pushbutton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
% edited_site_lib = site_lib;
% edited_site_lib(end)= '';
% edited_site_lib = strcat(edited_site_lib,'_edited/');
% labels_array_file = strcat(site_lib,'/labels_array_final_',handles.settings.DATE,'_',num2str(handles.cur_site),'.mat');
% edited_labels_array_file = strcat(edited_site_lib,'/labels_array_final_',handles.settings.DATE,'_',num2str(handles.cur_site),'.mat');
% 
% handles.xlim = get(handles.img,'XLim');
% handles.ylim = get(handles.img,'YLim'); 
% from_frame = str2num(get(handles.from_edit,'String'));
% from_frame_ind = find(handles.settings.FRAMES == from_frame);
% to_frame = str2num(get(handles.to_edit,'String'));
% if(isempty(to_frame))
%     to_frame_ind = from_frame_ind;
% else
%     to_frame_ind = find(handles.settings.FRAMES == to_frame);
% end
% load(labels_array_file);
% 
% for i=from_frame_ind:1:to_frame_ind
%     try
%         if(i==from_frame_ind)
%             labels_file = strcat(site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,i));
%             load(labels_file);
%             handles.labels = LABELS;
%         end
%         edited_labels_file = strcat(edited_site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,i));
%         delete(edited_labels_file);
%     catch
% 
%     end
%     orig_labels_data = labels_array_final(i);
%     orig_labels_data.edited = [];
%     handles.labels_array(i) = orig_labels_data;
% end
% clear('labels_array_final','LABELS');
% save_array_data(handles);
% save_labels_data(handles);
% im=display_image(handles);
% if(get(handles.segment_togglebutton,'Value')==1)
%     t = str2double(get(handles.thresh_edit,'String'));
%     bw_thresh = im2bw(im,t);
%     [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%     hold on;
%     plot(Yb,Xb,'.r','MarkerSize',1);
%     hold off;
%     handles.bw_thresh = bw_thresh;
% end
% guidata(hObject,handles);
% % --- Executes on button press in add_thresh_pushbutton.
% function add_thresh_pushbutton_Callback(hObject, eventdata, handles)
% % hObject    handle to add_thresh_pushbutton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
%     site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
%     edited_site_lib = site_lib;
%     edited_site_lib(end)= '';
%     edited_site_lib = strcat(edited_site_lib,'_edited/');
%     red_filetmp = strcat(site_lib,sprintf(handles.settings.FILETEMP_RED,handles.cur_site));
%     green_filetmp = strcat(site_lib,sprintf(handles.settings.FILETEMP_GREEN,handles.cur_site));
%     edited_labels_file = strcat(edited_site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
%     
%     handles.xlim = get(handles.img,'XLim');
%     handles.ylim = get(handles.img,'YLim');
%     save_array_data(handles,'prev');
%     save_labels_data(handles,'prev');
%     axes(handles.img);
%     zoom off;
%     [x y] = ginput(1);
%     BW = bwselect(handles.bw_thresh,floor(x),floor(y),8);
%     BW = imfill(BW,'holes');
%     if(isempty(find(BW(:) > 0)))
%         return;
%     end
% %     BW = bwmorph(BW,'thicken');
%     BWper = bwperim(BW);
%     [Xp,Yp] = ind2sub(size(BWper),find(BWper==1));
%     hold on;
%     plot(Yp,Xp,'.y');
%     ids = handles.labels(find(BW > 0));
%     ids = unique(ids);
%     id_ind = find(ids > 0);
%     if(isempty(id_ind)) 
%         new_id = max(max(handles.labels(:)),length(handles.labels_array(handles.cur_frame_ind).cell_names))+1;
%         new_name = strcat('E',num2str(new_id));
%     elseif(length(id_ind) > 1) %multiple labels
%         new_id = max(max(handles.labels(:)),length(handles.labels_array(handles.cur_frame_ind).cell_names))+1;
%         for i = 1:1:length(id_ind)
%             id =ids(id_ind(i));
%             BW(handles.labels==id) = 0;
%             handles.labels(find(handles.labels==id)) = new_id;
%             handles.labels_array = remove_label(handles.labels_array,[],[],[],id,handles.cur_frame_ind);
%         end
%         new_name = strcat('E',num2str(new_id));
%     elseif(ids(id_ind) > length(handles.labels_array(handles.cur_frame_ind).cell_names) || isempty(handles.labels_array(handles.cur_frame_ind).cell_names{ids(id_ind)})) %unused existing label
%         handles.labels(find(handles.labels==ids(id_ind))) = 0;
%         new_id = max(max(handles.labels(:)),length(handles.labels_array(handles.cur_frame_ind).cell_names))+1;
%         new_name = strcat('E',num2str(new_id));
%     else %existing label
%         new_id = ids(id_ind);
%         labels_data = handles.labels_array(handles.cur_frame_ind);
%         handles.prev = labels_data.prev_label{new_id};
%         new_name = labels_data.cell_names{new_id};
%     end
%     handles.labels = int32(handles.labels) + int32(BW)*new_id;
%     new_cent = regionprops(handles.labels, 'Centroid');
%     new_cent = new_cent(new_id).Centroid;
%     new_x = new_cent(1,1);
%     new_y = new_cent(1,2);
%     new_area = regionprops(handles.labels,'Area');
%     new_area = new_area(new_id).Area;
%     red_flu = NaN;
%     green_flu = NaN;
%     handles = insert_new_record(handles,new_id,new_name,new_x,new_y,new_area,red_flu,green_flu,handles.prev);
%     handles = update_cell_record(handles,new_id);
%     im=display_image(handles);
%     if(get(handles.segment_togglebutton,'Value')==1)
%         t = str2double(get(handles.thresh_edit,'String'));
%         bw_thresh = im2bw(im,t);
%         [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%         hold on;
%         plot(Yb,Xb,'.r','MarkerSize',1);
%         hold off;
%         handles.bw_thresh = bw_thresh;
%     end
%     LABELS = handles.labels;
%     save_labels_data(handles);
%     save_array_data(handles);
%     guidata(hObject, handles);
% 
% % --- Executes on button press in undo_pushbutton.
% function undo_pushbutton_Callback(hObject, eventdata, handles)
% % hObject    handle to undo_pushbutton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
%  site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
%  edited_site_lib = site_lib;
%  edited_site_lib(end)= '';
%  edited_site_lib = strcat(edited_site_lib,'_edited/');
%  prev_labels_array_file = strcat(edited_site_lib,'/prev_array.mat');
%  prev_labels_file = strcat(edited_site_lib,'/prev_labels.mat');
% 
%  handles.xlim = get(handles.img,'XLim');
%  handles.ylim = get(handles.img,'YLim');
%  try
%     load(prev_labels_array_file);
%     load(prev_labels_file);
%     handles.labels = LABELS;
%     handles.labels_array = labels_array_final;
%     clear('LABELS','labels_array_final');
%  catch
%  end
% save_labels_data(handles);
% save_array_data(handles);
% im=display_image(handles);
% if(get(handles.segment_togglebutton,'Value')==1)
%     t = str2double(get(handles.thresh_edit,'String'));
%     bw_thresh = im2bw(im,t);
%     [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%     hold on;
%     plot(Yb,Xb,'.r','MarkerSize',1);
%     hold off;
%     handles.bw_thresh = bw_thresh;
% end
% guidata(hObject,handles);
% 
% 
% function handles =init_by_site(handles)
% site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
%     
%     edited_site_lib = site_lib;
%     edited_site_lib(end)= '';
%     edited_site_lib = strcat(edited_site_lib,'_edited/');
%     create_lib(edited_site_lib,0);
%%     Need to create Labels (masks) or read previous file. and initialize
%%     all parameters
%     source_mos_file = strcat(site_lib,'/mos2_',handles.settings.DATE,'_',num2str(handles.cur_site),'.mat');
%     dest_mos_file = strcat(edited_site_lib,'/mos2_',handles.settings.DATE,'_',num2str(handles.cur_site),'.mat');
%     copyfile(source_mos_file,dest_mos_file);
%     load(dest_mos_file);
%     handles.mos = mos2;
%      labels_file = strcat(site_lib,'labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
%     edited_labels_file = strcat(edited_site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
%     try
%         load(edited_labels_file);
%     catch
%         load(labels_file);
%     end
%     handles.labels = LABELS;
%     source_params_file = strcat(site_lib,'/params_',handles.settings.DATE,'_',num2str(handles.cur_site),'.mat');
%     dest_params_file = strcat(edited_site_lib,'/params_',handles.settings.DATE,'_',num2str(handles.cur_site),'.mat');
%     copyfile(source_params_file,dest_params_file);
%     load(dest_params_file);
%      handles.params = params;
%      labels_array_file = strcat(site_lib,'/labels_array_final_',handles.settings.DATE,'_',num2str(handles.cur_site),'.mat');
%      edited_labels_array_file = strcat(edited_site_lib,'/labels_array_final_',handles.settings.DATE,'_',num2str(handles.cur_site),'.mat');
%      try
%          load(edited_labels_array_file);
%      catch
%         load(labels_array_file);
%         for i=1:1:length(labels_array_final)
%             labels_array_final(i).edited = [];
%         end
%      end
%     handles.labels_array = labels_array_final;
%     handles.endpoint_frames = build_life_course(handles.labels_array,handles.settings.FRAMES);
%     handles.label2course = map_label2course(handles.endpoint_frames,handles.settings.FRAMES);

% function [im flur_intensity raw_flur_intensity] = calc_flur(filename,frame_ind,acc_u,acc_v,LABELS,handles)
%     flur_intensity = [];
%     raw_flur_intensity = [];
% 
%     try
%         im = imread(filename);
%         orig_im = translate_image(im,acc_u,acc_v,[],handles.settings.MARGIN,handles.settings.DIAM);
%         im = calibrate_flur(im,handles.settings.CAMERA_BKG,handles.settings.CALIB_FILE);
%         im = translate_image(im,acc_u,acc_v,[],handles.settings.MARGIN,handles.settings.DIAM);
%         if(find(~isnan(im) & im > 0))
%             im = remove_background(im,LABELS,handles.labels_array(frame_ind).cell_names,4,handles.settings.MARGIN);
%         end
%     catch
%         disp(sprintf('no flur data for file: %s',filename));
%         im = [];
%         orig_im = im;
%         return;
%     end
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%     EXISTING_LABELS = unique(sort(LABELS(:)));
%     for BACT_LABEL = EXISTING_LABELS'
%         if (BACT_LABEL == 0)
%             continue
%         end
%         flur_intensity(BACT_LABEL) = sum(im(LABELS==BACT_LABEL));
%         raw_flur_intensity(BACT_LABEL) = sum(orig_im(LABELS==BACT_LABEL));
%     end


% function handles = update_flur(handles)
% site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
% edited_site_lib = site_lib;
% edited_site_lib(end)= '';
% edited_site_lib = strcat(edited_site_lib,'_edited/');
% edited_labels_file = strcat(edited_site_lib,'labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
% phase_filetmp = strcat(handles.settings.PREFIX,sprintf(handles.settings.FILETEMP,handles.cur_site));
% red_filetmp = strcat(handles.settings.PREFIX,sprintf(handles.settings.FILETEMP_RED,handles.cur_site));
% edited_red_filetmp = strcat(edited_site_lib,sprintf(handles.settings.FILETEMP_RED,handles.cur_site));
% green_filetmp = strcat(handles.settings.PREFIX,sprintf(handles.settings.FILETEMP_GREEN,handles.cur_site));
% edited_green_filetmp = strcat(edited_site_lib,sprintf(handles.settings.FILETEMP_GREEN,handles.cur_site));
% 
% 
% file_template = strcat('labels_mat_',handles.settings.DATE,'_',num2str(handles.cur_site),'_','(\d+).mat');
% files = dir(edited_site_lib);
% progress_bar = waitbar(0,'starting refresh!!!!!!');
% waitbar(0, progress_bar,'updating flur data ...');
% frame_inds = [];
% labels_names = {};
% for i=1:1:length(files)
%     name = files(i).name;
%     [mat tok] = regexp(name,file_template,'match','tokens');
%     if(isempty(mat))
%         continue;
%     else
%         frame_ind = str2num(cell2mat(tok{1}));
%         frame_inds = [frame_inds frame_ind];
%         labels_names = [labels_names name];
%     end
% end
% [frame_inds ix] = sort(frame_inds);
% labels_names = labels_names(ix);
% for i=1:1:length(frame_inds)
%     frame_ind = frame_inds(i);
%     name = labels_names{i};
%     load(strcat(edited_site_lib,name));
%     [acc_u acc_v]  = calc_shift(handles.settings.FRAMES(1),handles.settings.FRAMES(frame_ind),handles.mos);
%     red_filename = sprintf(red_filetmp,handles.settings.FRAMES(frame_ind)); 
%     [red_im flur_intensity raw_flur_intensity] = calc_flur(red_filename,frame_ind,acc_u,acc_v,LABELS,handles);
%     handles.labels_array(frame_ind).red_flu=flur_intensity;
%     handles.labels_array(frame_ind).raw_red_flu=raw_flur_intensity;
%     if(isempty(red_im))
%        handles.labels_array(frame_ind).green_flu=flur_intensity;
%        handles.labels_array(frame_ind).raw_green_flu=raw_flur_intensity;
%        waitbar(i/length(frame_inds), progress_bar,sprintf('no flur data for frame %d - skipping',handles.settings.FRAMES(frame_ind)));
%        continue;
%     end
%     imwrite(red_im,sprintf(edited_red_filetmp,handles.settings.FRAMES(frame_ind)),'tif');
%     green_filename = sprintf(green_filetmp,handles.settings.FRAMES(frame_ind));
%     [green_im flur_intensity raw_flur_intensity] = calc_flur(green_filename,frame_ind,acc_u,acc_v,LABELS,handles);
%     handles.labels_array(frame_ind).green_flu=flur_intensity;
%     handles.labels_array(frame_ind).raw_green_flu=raw_flur_intensity;
%     imwrite(green_im,sprintf(edited_green_filetmp,handles.settings.FRAMES(frame_ind)),'tif');
%     waitbar(i/length(frame_inds), progress_bar,sprintf('updating flur data for frame %d ...',handles.settings.FRAMES(frame_ind)));
% end    
% close(progress_bar);
%     

% --- Executes on selection change in site_listbox.
% function site_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to site_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns site_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from site_listbox
%     val = get(handles.site_listbox,'Value');
%     handles.cur_site = handles.settings.SITES(val);
%     handles = init_by_site(handles);
%     cur_frame = handles.settings.FRAMES(handles.cur_frame_ind);
%     set(handles.frame_edit,'String',num2str(cur_frame));
%     set(handles.from_edit,'String',num2str(cur_frame));
%     set(handles.to_edit,'String','');
%     guidata(hObject, handles);
%     im=display_image(handles);
%     if(get(handles.segment_togglebutton,'Value')==1)
%         t = str2double(get(handles.thresh_edit,'String'));
%         bw_thresh = im2bw(im,t);
%         [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%         hold on;
%         plot(Yb,Xb,'.r','MarkerSize',1);
%         hold off;
%         handles.bw_thresh = bw_thresh;
%     end
%     zoom reset;
% 
% % --- Executes during object creation, after setting all properties.
% function site_listbox_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to site_listbox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: listbox controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% function refresh_pushbutton_Callback(hObject, eventdata, handles)
% % hObject    handle to refresh_pushbutton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% handles.xlim = get(handles.img,'XLim');
% handles.ylim = get(handles.img,'YLim');
% save_array_data(handles,'prev');
% progress_bar = waitbar(0,'starting refresh!!!!!!');
% waitbar(0, progress_bar,'updating lineage names ...');
% handles.labels_array = update_children_names(handles.labels_array,handles.settings.FRAMES);
% waitbar(1/3, progress_bar,'rebuilding life courses ...');
% handles.endpoint_frames = build_life_course(handles.labels_array,handles.settings.FRAMES);
% waitbar(2/3, progress_bar,'re-mapping labels to courses ...');
% handles.label2course = map_label2course(handles.endpoint_frames,handles.settings.FRAMES);
% waitbar(1, progress_bar,'refresh is about to complete!');
% close(progress_bar);
% im=display_image(handles);
% if(get(handles.segment_togglebutton,'Value')==1)
%     t = str2double(get(handles.thresh_edit,'String'));
%     bw_thresh = im2bw(im,t);
%     [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%     hold on;
%     plot(Yb,Xb,'.r','MarkerSize',1);
%     hold off;
%     handles.bw_thresh = bw_thresh;
% end
% save_array_data(handles);
% guidata(hObject, handles);
% function save_array_data(handles,varargin)
%% TODO find out  what is this good for.....
%     site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
%     edited_site_lib = site_lib;
%     edited_site_lib(end)= '';
%     edited_site_lib = strcat(edited_site_lib,'_edited/');
%     if(~isempty(varargin))
%         labels_array_file = strcat(edited_site_lib,'/prev_array.mat');
%     else
%         labels_array_file = strcat(edited_site_lib,'/labels_array_final_',handles.settings.DATE,'_',num2str(handles.cur_site),'.mat');
%     end
%     labels_array_final = handles.labels_array;
%     try
%         save(labels_array_file,'labels_array_final');
%     catch
%         disp 'ERROR: cannot save data!!!!!!';
%     end
    
% function save_labels_data(handles,varargin)
%     site_lib = strcat(handles.settings.PREFIX,sprintf(handles.settings.SITE_LIBTEMP,handles.cur_site,handles.settings.FRAMES(1),handles.settings.FRAMES(end)));
%     edited_site_lib = site_lib;
%     edited_site_lib(end)= '';
%     edited_site_lib = strcat(edited_site_lib,'_edited/');
%     if(~isempty(varargin))
%         labels_file = strcat(edited_site_lib,'/prev_labels.mat');
%     else
%     	labels_file = strcat(edited_site_lib,'/labels_mat_',handles.settings.DATE,sprintf('_%d_%d.mat',handles.cur_site,handles.cur_frame_ind));
%     end
%     LABELS = handles.labels;
%     try
%         save(labels_file,'LABELS');
%     catch
%     end


% function frame_edit_Callback(hObject, eventdata, handles)
% hObject    handle to frame_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% Hints: get(hObject,'String') returns contents of frame_edit as text
%        str2double(get(hObject,'String')) returns contents of frame_edit as a double
% 
% new_frame = str2num(get(handles.frame_edit,'String'));
% handles.cur_frame_ind = new_frame;    
%     zoom off;
% display_image(handles);
%     try
%         load(labels_file);
%     catch %if there's no labels file
%         labels = zeros(size(im));
%     end    
%     handles.labels = LABELS;
%     axes(handles.img);
%     im=display_image(handles);
% 
% title(sprintf('site: %d frame: %d', site,frame));%,'InitialMagnification','fit'); pause(1/100);
% hold on;
% 
% if(get(handles.segment_togglebutton,'Value')==1)
%     addThreshold(handles);
% end
% 
% guidata(hObject, handles);

% % --- Executes during object creation, after setting all properties.
% function frame_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to frame_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% % --- Executes during object creation, after setting all properties.
% function browse_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to browse_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
%  
% % --- Executes on button press in browse_pushbutton.
% function browse_pushbutton_Callback(hObject, eventdata, handles)
% % hObject    handle to browse_pushbutton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% project_dir = uigetdir('','Choose project directory');
% set(handles.browse_edit,'String',project_dir);
% cellsFile=[project_dir '\' 'cells.mat'];
% try
%     load( cellsFile);
% catch
%     disp 'cannot load cell ids file- creating new';
%     cellMaxID=0;
%     sites=[];
%     maxName=0;
% end
% try
%     site=handles.cur_site;
%     frame=handles.cur_frame_ind;
%     im=display_image(handles);
% catch
%     disp ('check if site filepath  and frame are correct');
% end
%     if(get(handles.segment_togglebutton,'Value')==1)
%         t = str2double(get(handles.thresh_edit,'String'));
%         bw_thresh = im2bw(im,t);
%         [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%         hold on;
%         plot(Yb,Xb,'.r','MarkerSize',1);
%         hold off;
%     end
%     zoom reset;
% 
%    
% 
% function browse_edit_Callback(hObject, eventdata, handles)
% % hObject    handle to browse_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of browse_edit as text
% %        str2double(get(hObject,'String')) returns contents of browse_edit as a double
% 
% project_dir = get(handles.browse_edit,'String');
% settings_file = [project_dir '\' 'settings.mat'];
% 
% try
%     handles = init_handles(handles,settings_file);
%     guidata(hObject, handles);
%     im=display_image(handles);
%     if(get(handles.segment_togglebutton,'Value')==1)
%         t = str2double(get(handles.thresh_edit,'String'));
%         bw_thresh = im2bw(im,t);
%         [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%         hold on;
%         plot(Yb,Xb,'.r','MarkerSize',1);
%         hold off;
%         handles.bw_thresh = bw_thresh;
%     end
% catch
%     disp 'cannot load settings file'!;
% end
% function x_edit_Callback(hObject, eventdata, handles)
% % hObject    handle to x_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of x_edit as text
% %        str2double(get(hObject,'String')) returns contents of x_edit as a double
% 
% save_array_data(handles,'prev');
% x = str2num(get(hObject,'String'));
% labels_array = handles.labels_array;
% labels_array(handles.cur_frame_ind).cell_cent{handles.cur_id}(1,1) = x;
% handles.labels_array = labels_array;
% save_array_data(handles);
% guidata(hObject,handles);
% 
% 
% 
% % --- Executes during object creation, after setting all properties.
% function x_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to x_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% function area_edit_Callback(hObject, eventdata, handles)
% % hObject    handle to area_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of area_edit as text
% %        str2double(get(hObject,'String')) returns contents of area_edit as a double
% save_array_data(handles,'prev');
% area = str2double(get(hObject,'String'));
% labels_array = handles.labels_array;
% labels_array(handles.cur_frame_ind).cell_area(handles.cur_id) = area;
% handles.labels_array = labels_array;
% save_array_data(handles);
% guidata(hObject,handles);
% 
% 
% 
% % --- Executes during object creation, after setting all properties.
% function area_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to area_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function red_edit_Callback(hObject, eventdata, handles)
% % hObject    handle to red_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of red_edit as text
% %        str2double(get(hObject,'String')) returns contents of red_edit as a double
% 
% save_array_data(handles,'prev');
% red = str2double(get(hObject,'String'));
% labels_array = handles.labels_array;
% labels_array(handles.cur_frame_ind).red_flud(handles.cur_id) = red;
% handles.labels_array = labels_array;
% save_array_data(handles);
% guidata(hObject,handles);
% 
% 
% % --- Executes during object creation, after setting all properties.
% function red_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to red_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function green_edit_Callback(hObject, eventdata, handles)
% % hObject    handle to green_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of green_edit as text
% %        str2double(get(hObject,'String')) returns contents of green_edit as a double
% 
% save_array_data(handles,'prev');
% green = str2double(get(hObject,'String'));
% labels_array = handles.labels_array;
% labels_array(handles.cur_frame_ind).red_flud(handles.cur_id) = green;
% handles.labels_array = labels_array;
% save_array_data(handles);
% guidata(hObject,handles);
% 
% 
% 
% % --- Executes during object creation, after setting all properties.
% function green_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to green_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% function y_edit_Callback(hObject, eventdata, handles)
% % hObject    handle to y_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of y_edit as text
% %        str2double(get(hObject,'String')) returns contents of y_edit as a double
% 
% save_array_data(handles,'prev');
% y = str2num(get(hObject,'String'));
% labels_array = handles.labels_array;
% labels_array(handles.cur_frame_ind).cell_cent{handles.cur_id}(1,2) = y;
% handles.labels_array = labels_array;
% save_array_data(handles);
% guidata(hObject,handles);
% 
% 
% % --- Executes during object creation, after setting all properties.
% function y_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to y_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% % --- Executes on selection change in cell_status_listbox.
% function cell_status_listbox_Callback(hObject, eventdata, handles)
% % hObject    handle to cell_status_listbox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: contents = get(hObject,'String') returns cell_status_listbox contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from cell_status_listbox
% 
% save_array_data(handles,'prev');
% status_val = get(hObject,'Value');
% labels_array = handles.labels_array;
% if(status_val == 1) %normal
%     labels_array(handles.cur_frame_ind).just_born(handles.cur_id) = 0;
% elseif(status_val == 2)%orphan
%     labels_array(handles.cur_frame_ind).just_born(handles.cur_id) = -1;
% elseif(status_val == 3) %lost
%     labels_array(handles.cur_frame_ind).just_born(handles.cur_id) = -2;
% elseif(status_val == 4) %newborn
%     labels_array(handles.cur_frame_ind).just_born(handles.cur_id) = 1;
% elseif(status_val == 5) %union
%     labels_array(handles.cur_frame_ind).just_born(handles.cur_id) = -3;
% elseif(status_val == 6) %newborn lost
%     labels_array(handles.cur_frame_ind).just_born(handles.cur_id) = 3;
% elseif(status_val == 7) %cell death
%    labels_array(handles.cur_frame_ind).just_born(handles.cur_id) = -5; 
% end
% 
% handles.labels_array = labels_array;
% save_array_data(handles);
% im=display_image(handles);
% if(get(handles.segment_togglebutton,'Value')==1)
%     t = str2double(get(handles.thresh_edit,'String'));
%     bw_thresh = im2bw(im,t);
%     [Xb,Yb] = ind2sub(size(bw_thresh),find(bw_thresh==1));
%     hold on;
%     plot(Yb,Xb,'.r','MarkerSize',1);
%     hold off;
%     handles.bw_thresh = bw_thresh;
% end
% guidata(hObject,handles);
% 
% % --- Executes during object creation, after setting all properties.
% function cell_status_listbox_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to cell_status_listbox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: listbox controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
