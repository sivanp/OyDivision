function varargout = movie_editor2(varargin)
%%TODO should I check for addition of daghters when mother exist in the
%%same frame????

% MOVIE_EDITOR2 M-file for movie_editor2.fig
%      MOVIE_EDITOR2, by itself, creates a new MOVIE_EDITOR2 or raises the existing
%      singleton*.
%
%      H = MOVIE_EDITOR2 returns the handle to a new MOVIE_EDITOR2 or the handle to
%      the existing singleton*.
%
%      MOVIE_EDITOR2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVIE_EDITOR2.M with the given input arguments.
%
%      MOVIE_EDITOR2('Property','Value',...) creates a new MOVIE_EDITOR2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before movie_editor2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to movie_editor2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help movie_editor2

% Last Modified by GUIDE v2.5 18-Dec-2011 17:52:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @movie_editor2_OpeningFcn, ...
    'gui_OutputFcn',  @movie_editor2_OutputFcn, ...
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

% --- Executes just before movie_editor2 is made visible.
function movie_editor2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to movie_editor2 (see VARARGIN)

% Choose default command line output for movie_editor2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes movie_editor2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
addpath('C:\Users\sivan-nqb\Desktop\OyDivision\analysis scripts')
addpath('C:\Users\sivan-nqb\Desktop\OyDivision\motion')

set(handles.figure1,'KeyPressFcn',@keyFwd)
set(handles.btnGroup,'SelectionChangeFcn',@btnGroup_SelectionChangeFnc);


function keyFwd(src,evnt)
handles = guidata(src);
%get the value of the key that was pressed
%evnt.Key is the lowercase symbol on the key that was pressed
%so even if you tried "shift + 8", evnt.Key will return 8
k=( evnt.Key );
switch k
    case'n'
        fwdFrame(handles);
        callSelection(handles);
    case 'x'
        callSelection(handles);
    case 'b'
        callStaySelection(handles);
end
%% return  1 for addPoly, 2 for circle , 3 for magic wand and 0 for none.
function btn= whichSelectionBtnPressed(handles)
btn=0;
if(get(handles.addPoly_btn,'Value'))
    btn=1;
end
if(get(handles.addCircle_btn,'Value'))
    btn=2;
end
if(get(handles.magicWand_btn,'Value'))
    btn=3;
end


function res= callSelection(handles)
res=0;
btn=whichSelectionBtnPressed(handles);
switch btn
    case 1
        res=addPolyBtn(handles);
    case 2
        res=addCircle_btn(handles);
    case 3
        res=magicWandBtn(handles);
        
    otherwise
        
end

% --- Outputs from this function are returned to the command line.
function varargout = movie_editor2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browsebutton.
function browsebutton_Callback(hObject, eventdata, handles)
% hObject    handle to browsebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of browsebutton
project_dir = uigetdir('','Choose project directory');
set(handles.edit1,'String',project_dir);


function site_edit_Callback(hObject, eventdata, handles)
% hObject    handle to site_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site_edit as text
%        str2double(get(hObject,'String')) returns contents of site_edit as a double


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


function frame_edit_Callback(hObject, eventdata, handles)
% hObject    handle to frame_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_edit as text
%        str2double(get(hObject,'String')) returns contents of frame_edit as a double

% --- Executes during object creation, after setting all properties.
function frame_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Rwd_btn.
function Rwd_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Rwd_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[sitenum,curframe]=getSiteFrame(handles);
rwdframe=curframe-1;
set(handles.frame_edit,'String',num2str(rwdframe));
res=showImage(handles,1);
if(~res)
    set(handles.frame_edit,'String',num2str(rwdframe+1));
    return;
end
% setThreshSliderRange(handles);
showThreshold(handles);
% --- Executes on button press in Fwd_btn.
function Fwd_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Fwd_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fwdFrame(handles);

% res=1 if succeedd 0 otherwise
function res= fwdFrame(handles)
[sitenum,curframe]=getSiteFrame(handles);
fwdframe=curframe+1;
set(handles.frame_edit,'String',num2str(fwdframe));
res=showImage(handles,1);
if(~res)
    set(handles.contMode_btn,'Value',0);
    set(handles.frame_edit,'String',num2str(fwdframe-1));
    return;
end
setThreshSliderRange(handles);
showThreshold(handles);


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browsefile_btn.
function browsefile_btn_Callback(hObject, eventdata, handles)
% hObject    handle to browsefile_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of browsefile_btn
projectDir=get(handles.edit1 ,'String');
fileTemplate = uigetfile('*.tif','Choose file',projectDir);
i=regexp(fileTemplate,'_\d+_\d+.tif');
if(~isempty(i))
    fileTemplate=fileTemplate(1:i-1);
end
set(handles.edit5 ,'String',fileTemplate);


% --- Executes on button press in loadfile_btn.
function load_btn_Callback(hObject, eventdata, handles)
% hObject    handle to loadfile_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
showImage(handles,1);
setThreshSliderRange(handles);
showThreshold(handles);


%this will only work on a 12-bit image (0-4095 values)
function setThreshSliderRange(handles)
im=getImage(handles.axes1);
% maxVal=max(max(double(im)));
maxVal=2^16-1;
% maxVal=4095;
set(handles.thresh_slider, 'Max',maxVal);
set(handles.thresholdMax_slider, 'Max',maxVal);



% --- Executes on button press in zoom_btn.
function zoom_btn_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zoom_btn
val = get(hObject,'Value');
axes(handles.axes1);
if(val == 1)
    zoom on;
    pan off;
    set(handles.pan_btn,'Value',0);
else
    zoom off;
end
guidata(hObject, handles);

% --- Executes on button press in pan_btn.
function pan_btn_Callback(hObject, eventdata, handles)
% hObject    handle to pan_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pan_btn
val = get(hObject,'Value');
axes(handles.axes1);
if(val == 1)
    pan on;
    zoom off;
    set(handles.zoom_btn,'Value',0);
else
    pan off;
end
guidata(hObject, handles);



% --- Executes when selected object is changed in fate_groupBtn.
function fate_groupBtn_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in fate_groupBtn
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
lymphid=get(handles.id_edit,'String');
if(isempty(lymphid))
    return;
end
lymphid=str2num(lymphid);
movie=getCellStruct();
[lymph, siteind,lymphind]=getLymph(lymphid,movie);

switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'div_fate_btn'
        %execute this code when fontsize08_radiobutton is selected
        lymph.fate=1;
        
    case 'die_fate_btn'
        %execute this code when fontsize12_radiobutton is selected
        lymph.fate=2;
        
    case 'tillEnd_fate_btn'
        %execute this code when fontsize16_radiobutton is selected
        lymph.fate=0;
    case 'outOfFrame_fate_btn'
        lymph.fate=3;
end
movie.sites(siteind).lymphs(lymphind)=lymph;
assignin('base','movie',movie);



function btnGroup_SelectionChangeFnc(hObject, eventdata)
handles = guidata(hObject);
switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'addCircle_btn'
        %execute this code when fontsize08_radiobutton is selected
        addCircle_btn(handles);
        
    case 'addPoly_btn'
        %execute this code when fontsize12_radiobutton is selected
        addPolyBtn(handles);
        
    case 'magicWand_btn'
        %execute this code when fontsize16_radiobutton is selected
        magicWandBtn(handles);
        
    otherwise
        Code for when there is no match.
        
end
%updates the handles structure
guidata(hObject, handles);

function callStaySelection(handles)
fwdFrame(handles);
axes(handles.axes1);
zoom off

[sitenum, framenum]=getSiteFrame(handles);
lymphid=get(handles.id_edit,'String');
if(isempty(lymphid))
    return;
end
lymphid=str2num(lymphid);
movie=getCellStruct();
lymph=getLymph(lymphid,movie);
ind=find(lymph.frames==framenum-1);
if(isempty(ind))
    return;
end
prevloc=lymph.locations{ind};
xs=prevloc(:,1);
ys=prevloc(:,2);
hold on
plot(xs,ys,'.y','MarkerSize',1);
[res, lymphid]=addLymphMarkToWorkspace(xs,ys,handles);
if(res>0)
    updateLymphGui(lymphid, handles);
elseif(res==0)
    updateLymphGui('', handles);
end
showImage(handles,1);
showThreshold(handles);


% --- Executes on button press in addCircle_btn2.
% function addCircle_btn_Callback(hObject, eventdata, handles)
% % hObject    handle to addCircle_btn2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function res=addCircle_btn(handles)
axes(handles.axes1);
zoom off;
set(get(get(handles.axes1,'UIContextMenu'),'Children'),'Visible','off') 


% ploting the circle
[cx cy, btn] = ginput(1);
hold on;
plot(cx,cy,'xy','MarkerSize',15);
c = [cx cy];

if(btn==3)
    [ex ey] = ginput(1);
    plot(ex,ey,'.b','MarkerSize',15);
    e = [ex ey];
    
else
    %getting the radius from the last frame
    [sitenum, framenum]=getSiteFrame(handles);
    lymphid=get(handles.id_edit,'String');
    if(isempty(lymphid))
        return;
    end
    lymphid=str2num(lymphid);
    movie=getCellStruct();
    lymph=getLymph(lymphid,movie);
    ind=find(lymph.frames==framenum-1);
    if(isempty(ind))
        return;
    end
    prevloc=lymph.locations{ind};
    im=getImage(handles.axes1);
    bw=poly2mask(prevloc(:,1), prevloc(:,2), size(im,1),size(im,2));
    diam=regionprops(bw,'EquivDiameter');
    radius=diam.EquivDiameter/2;
    e=[cx+radius, cy];
end
r1 = (0:0.1:2*pi)';
circx = sin(r1);
circy = cos(r1);
radius = sqrt(sum((c-e).^2));
circx = circx*radius+c(1);
circy = circy*radius+c(2);
plot(circx,circy,'.y','MarkerSize',1);
[res, lymphid]=addLymphMarkToWorkspace(circx,circy,handles);
if(res>0)
    updateLymphGui(lymphid, handles);
elseif(res==0)
    updateLymphGui('', handles);
end
set(get(get(handles.axes1,'UIContextMenu'),'Children'),'Visible','on') 
showImage(handles,1);
showThreshold(handles);

% % % --- Executes on button press in magicWand_btn2.
% function magicWand_btn_Callback(hObject, eventdata, handles)
% % hObject    handle to magicWand_btn2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
function res=magicWandBtn(handles)
axes(handles.axes1);
hold on
[x y] = ginput(1);
res=magicWand(x,y,handles);
hold off


%
% % --- Executes on button press in addPoly_btn2.
% function addPoly_btn_Callback(hObject, eventdata, handles)
% % hObject    handle to addPoly_btn2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
function res=addPolyBtn(handles)
axes(handles.axes1);
hold on
h=impoly();
pos=wait(h);
% pos=getPosition(h);
[res, lymphid]=addLymphMarkToWorkspace(pos(:,1),pos(:,2),handles);
if(res>0)
    updateLymphGui(lymphid, handles);
elseif(res==0)
    updateLymphGui('', handles);
end
showImage(handles,1);
showThreshold(handles);




% --- Executes on button press in getCell_btn.
function getCell_btn_Callback(hObject, eventdata, handles)
% hObject    handle to getCell_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[cx cy] = ginput(1);
hold on;
plot(cx,cy,'xy','MarkerSize',15);
inlymph=isDotInLymph(handles, cx,cy);
if(inlymph)
    set(handles.id_edit, 'String',inlymph)
    updateLymphGui(inlymph,handles);
else
    set(handles.id_edit, 'String','')
end


function id_edit_Callback(hObject, eventdata, handles)
% hObject    handle to id_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of id_edit as text
%        str2double(get(hObject,'String')) returns contents of id_edit as a double
lymphid=get(handles.id_edit,'String');
if(~isempty(lymphid))
    lymphid=str2num(lymphid);
end
updateLymphGui(lymphid,handles);


% --- Executes during object creation, after setting all properties.
function id_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to id_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name_edit as text
%        str2double(get(hObject,'String')) returns contents of name_edit as a double
%TODO need to check stuff here
lymphid=get(handles.id_edit,'String');
if(~isempty(lymphid))
    lymphid=str2num(lymphid);
end
movie=getCellStruct();
lymph=getLymph(lymphid,movie);
if(isempty(lymph))
    msgbox('cannot find lymph')
    return;
end

lymphname=get(handles.name_edit,'String');
if(isempty(lymphname))
    msgbox('not a valid name')
    return;
end
lymph.name=lymphname;
movie=ame(lymphid, lymphname,movie);
if(~isempty(movie))
    assignin('base','movie',movie);
end

updateLymphGui(lymphid,handles);

% --- Executes during object creation, after setting all properties.
function name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function momid_edit_Callback(hObject, eventdata, handles)
% hObject    handle to momid_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of momid_edit as text
%        str2double(get(hObject,'String')) returns contents of momid_edit as a double


% --- Executes during object creation, after setting all properties.
function momid_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to momid_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function momname_edit_Callback(hObject, eventdata, handles)
% hObject    handle to momname_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of momname_edit as text
%        str2double(get(hObject,'String')) returns contents of momname_edit as a double




% --- Executes during object creation, after setting all properties.
function momname_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to momname_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%return a vector with all descendadnts ids
function [descendantsIds]=getDescenIds(movie,lymphid,descendantsIds)
% function [descendantsIds]=getDescenIds()
if(isempty(movie.momDaughTable))
    return
end
inds=find(movie.momDaughTable(:,1)==lymphid);
%find daughters ids
for i=1:length(inds)
    daughtid=movie.momDaughTable(inds(i),2);
    descendantsIds(end+1)=daughtid;
    descendantsIds=getDescenIds(movie,daughtid,descendantsIds);
end



% --- Executes on button press in addMom_btn.
%asks the user for mother id and inserts the lymph with the given id as its
%duaghter. if the mother id doesnt exist or is allready writen as its
%mother nothing and error message appers and nothing happens.
function addMom_btn_Callback(hObject, eventdata, handles)
% % hObject    handle to addMom_btn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
lymphid=get(handles.id_edit,'String');
if(isempty(lymphid))
    msgbox('couldn''t find lymph');
    return
else
    lymphid=str2num(lymphid)
end
momid=inputdlg('what is the mother''s id?');
momid=momid{1};
if(isempty(momid))
    msgbox('couldn''t find mom');
    return;
end
momid=str2num(momid);
movie=getCellStruct();
movie=addMomDaughterCouple(movie, momid, lymphid);
%if this addition is the only mother, change the name
if(momid==-1)
    return
end
inds=find(movie.momDaughTable(:,2)==lymphid);
if(length(inds)==1)
    mom=getLymph(momid,movie);
    ds=find(movie.momDaughTable(:,1)==momid);
    name=sprintf('%s_%d', mom.name, length(ds));
    movie= ame(lymphid, name, movie);
end
if(~isempty(movie))
    assignin('base','movie',movie);
end







% --- Executes on button press in cellDiv_btn.
function cellDiv_btn_Callback(hObject, eventdata, handles)
% hObject    handle to cellDiv_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
momid=get(handles.id_edit,'String');
lymphid=getNextAvailableId(handles);
set(handles.momid_edit,'String',momid);
set(handles.id_edit,'String',lymphid);
set(handles.name_edit,'String',[]);
set(handles.momname_edit,'String',[]);


% % --- Executes on button press in deleteCell_btn.
function deleteCell_btn_Callback(hObject, eventdata, handles)
% hObject    handle to deleteCell_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lymphid=str2num(get(handles.id_edit,'String'));
movie=getCellStruct();
[lymph, siteind,lymphind]=getLymph(lymphid,movie);

button = questdlg('what to delete','delete','entire cell','cell mark in frame','cell mark from this frame onward','cell mark in frame');
switch button
    case 'entire cell' %if we delete Cell
        inds=find(movie.momDaughTable(:,2)==lymphid);
        for i=1:length(inds)
            movie.momDaughTable(inds(i),:)=[];
            movie.momDaughInd=movie.momDaughInd-1;
        end
        % getting rid of all children in the table- connecting them to -1
        inds=find(movie.momDaughTable(:,1)==lymphid);
        if(~isempty(inds))
            msgbox('cell has daughters-associating them with -1')
            movie.momDaughTable(inds,1)=-1;
        end
        movie.sites(siteind).lymphs(lymphind)=[];
        %also delete from monitor list
        removeFromList(lymphid);
    case 'cell mark in frame'
        [sitenum, framenum]=getSiteFrame(handles);
        ind=find(lymph.frames==framenum);
        if(~isempty(ind))
            lymph.frames(ind)=[];
            lymph.locations(ind)=[];
        end
        movie.sites(siteind).lymphs(lymphind)=lymph;
    case 'cell mark from this frame onward'
        [sitenum, framenum]=getSiteFrame(handles);
        inds=find(lymph.frames>=framenum);
        if(~isempty(inds))
            lymph.frames(inds)=[];
            lymph.locations(inds)=[];
        end
        movie.sites(siteind).lymphs(lymphind)=lymph;
end
assignin('base','movie',movie);
updateLymphGui('',handles)




% --- Executes on button press in goToStart_btn.
function goToStart_btn_Callback(hObject, eventdata, handles)
% hObject    handle to goToStart_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
goToStart(handles);

function goToStart(handles)
lymphid=str2num(get(handles.id_edit,'String'));
movie=getCellStruct();
lymph=getLymph(lymphid,movie);
startFrame=min(lymph.frames);
set(handles.frame_edit,'String',startFrame);
showImage(handles,1);
showThreshold(handles);


function [lymphid]= getNextAvailableId(handles)
[sitenum, framenum]=getSiteFrame(handles)
lymphid=1;
try
    movie=evalin('base', 'movie');
catch
    return;
end
lymphid=movie.maxLymphId+1;


function [sitenum, framenum]=getSiteFrame(handles)
sitenum=str2num(get(handles.site_edit,'String'));
framenum=str2num(get(handles.frame_edit,'String'));



function [overlapFreq]=overlap(loc1, loc2)
%translate locations to BW
maxes=max([loc1;loc2]);
bw1=zeros(maxes);
bw1(round(loc1))=1;
bw2=zeros(maxes);
bw2(round(loc2))=1;
bw=bw1+bw2;
overlaps=length(find(bw==2));
totals=length(find(bw>0));
overlapFreq=overlaps/totals;




function [lymph,movie, siteind,lymphind]=createNewLymph(lymphid,handles,movie)
siteind=0;
lymphind=0;
lymph.id=lymphid;
lymph.frames=[];
lymph.locations=[];
lymph.fluos=[];
lymph.name='';
lymph.remark=[];
lymph.fate=0; %fate 1=div, fate 2=die   default: 0 =till end- out of frame or focus/nor dividing nor dying.
[sitenum,framenum]=getSiteFrame(handles);
if(lymphid==1 ||  sitenum>length(movie.sites))
    ind=1;
else
    ind=length(movie.sites(sitenum).lymphs)+1;
end
movie.sites(sitenum).lymphs(ind)=lymph;
siteind=sitenum;
lymphind=ind;
%add to mother-daughter table
momid=get(handles.momid_edit,'String');
if(isempty(momid))
    movie=addMomDaughterCouple(movie,-1,lymphid);
    lymph.name=num2str( movie.lineageInd);
    momid=-1;
else
    momid=str2num(momid);
    movie=addMomDaughterCouple(movie,momid,lymphid);
end
if(momid==-1) %adding lineage
    lymph.name=num2str( movie.lineageInd);
else
    mom=getLymph(momid,movie);
    numOfSisters=length(find(movie.momDaughTable(:,1)==momid));
    lymph.name=sprintf('%s_%d', mom.name, numOfSisters);
end

%return 0 if was unsuccesful, 1 otherwise
function res=showImage(handles, keepzoom)
res=0;
fileTemplate=get(handles.edit5 ,'String');
projectDir=get(handles.edit1 ,'String');
[sitenum,framenum]=getSiteFrame(handles);
path=sprintf('%s\\%s_%d_%d.tif',projectDir,fileTemplate,sitenum,framenum);
try
    im=imread(path);
catch
    return
end
xzoom=xlim(handles.axes1);
yzoom=ylim(handles.axes1);
axes(handles.axes1);
imprev=getImage(handles.axes1);
if(isempty(imprev))
    keepzoom=0;
end
im=imshow(im,[]);
if(keepzoom)
    xlim(xzoom);
    ylim(yzoom);
end
if(isDispOutlinesChecked(handles))
    displayOutlinesPerFrame(handles)
end
res=1;
cmenu=get(handles.axes1,'UIContextMenu');
set(im,'UIContextMenu',cmenu);



function [movie]=getCellStruct()
try
    movie=evalin('base', 'movie');
catch
    movie=[];
end


function [monitorList]=getMonitorList()
try
    monitorList=evalin('base', 'monitorList');
catch
    monitorList=[];
end



function displayOutlinesPerFrame(handles)
axes(handles.axes1);
hold on
movie=getCellStruct();
[sitenum,framenum]=getSiteFrame(handles);
if(isempty(movie) ||length(movie.sites)<sitenum || length(movie.sites(sitenum).lymphs)==0) %% no lymphs exists for this site
    return;
end
cmenu=get(handles.axes1,'UIContextMenu');
lymphs=movie.sites(sitenum).lymphs;
for i=1:length(lymphs)
    lymph=lymphs(i);
    ind=find(lymph.frames==framenum);
    if(isempty(ind))
        continue;
    end
    locations=lymph.locations(ind);
    xs=lymph.locations{ind}(:,1);
    ys=lymph.locations{ind}(:,2);
    cx=mean(xs);
    cy=mean(ys);
    if(isInMonitorList(lymph.id))
        plot(xs,ys,'-c','UIContextMenu',cmenu)
    else
        plot(xs,ys,'-b','UIContextMenu',cmenu)
    end
    text(cx,cy,lymph.name,'UIContextMenu',cmenu);
end
%mark the current cell in green
lymphid=get(handles.id_edit,'String');
if(isempty(lymphid))
    return;
end
lymphid=str2num(lymphid);
lymph=getLymph(lymphid,movie);
if(isempty(lymph))
    return;
end
ind=find(lymph.frames==framenum);
if(isempty(ind))
    return;
end
locations=lymph.locations(ind);
xs=lymph.locations{ind}(:,1);
ys=lymph.locations{ind}(:,2);
plot(xs,ys,'-g','UIContextMenu',cmenu)

hold off

%returns 0 if not in lymph, or the lymph id that it is inside
function [inlymph]=isDotInLymph(handles, x,y)
inlymph=0;
movie=getCellStruct();
[sitenum,framenum]=getSiteFrame(handles);
if(isempty(movie) ||length(movie.sites)<sitenum || length(movie.sites(sitenum).lymphs)==0) %% no lymphs exists for this site
    return;
end
lymphs=movie.sites(sitenum).lymphs;
for i=1:length(lymphs)
    lymph=lymphs(i);
    ind=find(lymph.frames==framenum);
    if(isempty(ind))
        continue;
    end
    locations=lymph.locations(ind);
    xs=locations{1}(:,1);
    ys=locations{1}(:,2);
    if(inpolygon(x,y,xs,ys))
        inlymph=lymph.id;
    end
end;


function updateLymphGui(lymphid,handles)
if(isempty(lymphid))
    set(handles.id_edit,'String',[]);
    set(handles.momid_edit,'String',[]);
    set(handles.name_edit,'String',[]);
    set(handles.momname_edit,'String',[]);
    set(handles.remark_edit,'String',[]);
    set(handles.momid_edit, 'BackgroundColor', [1,1,1]);
    return;
end
movie=getCellStruct();
lymph=getLymph(lymphid,movie);
if(isempty(lymph))
    set(handles.id_edit,'String',[]);
    set(handles.momid_edit,'String',[]);
    set(handles.name_edit,'String',[]);
    set(handles.momname_edit,'String',[]);
    set(handles.remark_edit,'String',[]);
    set(handles.momid_edit, 'BackgroundColor', [1,1,1]);
    return;
end
set(handles.id_edit,'String',lymphid);
set(handles.name_edit,'String',lymph.name);
momid=findMom(lymphid);
if(length(momid)==1)
    set(handles.momid_edit, 'BackgroundColor', [1,1,1]);
elseif(length(momid>1))
    momid=momid(1);
    set(handles.momid_edit, 'BackgroundColor', [0.17,0.5,0.35]);
end
mom=getLymph(momid,movie);
set(handles.remark_edit,'String',lymph.remark);
if(momid==-1)
    set(handles.momid_edit,'String',momid);
    set(handles.momname_edit,'String',-1);
else
    set(handles.momname_edit,'String',mom.name);
    set(handles.momid_edit,'String',momid);
end
switch lymph.fate
    case 0
        set(handles.tillEnd_fate_btn,'Value',1);
    case 1
        set(handles.div_fate_btn,'Value',1);
    case 2
        set(handles.die_fate_btn,'Value',1);
end
% set(handles.fate_groupBtn,'SelectedObject',)

function momid=findMom(lymphid)
momid=-1;
movie=getCellStruct();
if(~isempty(movie) && isfield(movie, 'momDaughTable'))
    ind=find(movie.momDaughTable(:,2)==lymphid);
    if(~isempty(ind))
        momid=movie.momDaughTable(ind,1);
    end
end


% --- Executes on slider movement.
function thresh_slider_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
showThreshold(handles);
% if(t >= get(hObject,'Min') && t<= get(hObject,'Max'))

% --- Executes on slider movement.
function thresholdMax_slider_Callback(hObject, eventdata, handles)
% hObject    handle to thresholdMax_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
showThreshold(handles);


% --- Executes during object creation, after setting all properties.
function thresholdMax_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresholdMax_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function thresh_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in reset_btn.
function reset_btn_Callback(hObject, eventdata, handles)
% hObject    handle to reset_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.thresh_slider,'Value',0);
set(handles.thresholdMax_slider, 'Value',0);

showImage(handles,1);

% --- Executes on button press in autoThresh_btn.
function autoThresh_btn_Callback(hObject, eventdata, handles)
% hObject    handle to autoThresh_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
autoThresh(handles);

function autoThresh(handles)
showImage(handles,1);
im=getImage(handles.axes1);
th=graythresh(im);
th=(2^16-1)*th;
set(handles.thresh_slider,'Value',th);
maxVal=get(handles.thresh_slider,'Max');
set(handles.thresholdMax_slider,'Value',maxVal);

showImage(handles,1);
showThreshold(handles);


function threshim= thresholdImage(handles)
threshim=[];
im=getImage(handles.axes1);
thmin= get(handles.thresh_slider,'Value');
thmax= get(handles.thresholdMax_slider,'Value');
threshim=(im>=thmin & im<=thmax);



function showThreshold(handles)
axes(handles.axes1);
hold off
showImage(handles,1);
axes(handles.axes1);
hold on
im=getImage(handles.axes1);
thmin= get(handles.thresh_slider,'Value');
thmax= get(handles.thresholdMax_slider,'Value');

bwthresh= thresholdImage(handles);
inds=find(bwthresh>0);
[xs,ys]=ind2sub(size(im),inds);
cmenu=get(handles.axes1,'UIContextMenu');
plot(ys, xs,'r.', 'MarkerSize',1,'UIContextMenu',cmenu);
% thim=uint16(zeros([size(bwthresh), 3]));
% thim(:,:,1)=uint16(bwthresh*(2^16-1));
% thim(:,:,1)=thim(:,:,1) + im;
% thim(:,:,2)=im;
% thim(:,:,3)=im;
% imshow(thim);
hold off;
if(isDispOutlinesChecked(handles))
    displayOutlinesPerFrame(handles)
end



function [res, lymphid, centroid, boundingBox]=magicWand(x,y,handles)
centroid=[];
bwthresh=thresholdImage(handles);
L=bwlabel(bwthresh);
labelnum=L(round(y),round(x));
if(labelnum==0)
    return;
end
L=(L==labelnum);
centroid = regionprops(L, 'centroid');
centroid=centroid.Centroid;
boundingBox=regionprops(L,'boundingBox');
boundingBox=boundingBox.BoundingBox;
[B]=bwboundaries(L);
B=B{1}; %assuming we have one and only one  object here
xs=B(:,2);
ys=B(:,1);
plot(xs,ys,'.y','MarkerSize',1);
[res, lymphid]=addLymphMarkToWorkspace(xs,ys,handles);
if(res>0)
    updateLymphGui(lymphid, handles);
elseif(res==0)
    updateLymphGui('', handles);
end
showImage(handles,1);
showThreshold(handles);

% --- Executes on button press in contMode_btn.
function contMode_btn_Callback(hObject, eventdata, handles)
% hObject    handle to contMode_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of contMode_btn
isPressed = get(hObject,'Value');
if(~isPressed)
    return
end
% axes(handles.axes1);
% hold on
% [x y] = ginput(1);
% [res, lymphid,centroid,bBox]=magicWand(x,y,handles);
monitorList=getMonitorList();
%first time- collect all centroids
for l=1:length(monitorList)
    lymphid=monitorList(l);
    [centroid,bBox]=getLymphCentroid(lymphid,handles);
    centroids(l)=centroid;
    bBoxes(l)=bBox;
end
res=1;
while(isPressed && res)
    fwdFrame(handles);
    for l=1:length(monitorList)        
        bwthresh=thresholdImage(handles);
        L=bwlabel(bwthresh);
        lymphid=monitorList(l);
        centroid=centroids(l).Centroid;
        updateLymphGui(lymphid, handles);
        uniqVal=L(round(centroid(2)),round(centroid(1)));
        if(uniqVal==0)
            [xs, ys]=find(L>0);
            bBox=bBoxes(l).BoundingBox;
            posXs=find(xs>=bBox(2)  & xs<bBox(2)+bBox(4));
            posYs=find(ys>=bBox(1)  & ys<bBox(1)+bBox(3));
            posXYs=intersect(posXs,posYs);
            if(isempty(posXYs))
                set(hObject,'Value',0);
                reses(l)=0;
                res=0;
                continue;
            end
            xs=xs(posXYs);
            ys=ys(posXYs);
            vals=L(xs,ys);
            uniqVal=unique(vals);
            uniqVal=setdiff(uniqVal,0);
            if(length(uniqVal)>1)   % more than one label- can't decid- abortting
                set(hObject,'Value',0);
                reses(l)=0;
                res=0;
                continue;
            end
        end
        %here uniqVal should be the label number
        L=(L==uniqVal);
        [B]=bwboundaries(L);
        B=B{1}; %assuming we have one and only one  object here
        xs=B(:,2);
        ys=B(:,1);
        centroid = regionprops(L, 'centroid');
%         centroid=centroid.Centroid;
        centroids(l)=centroid; %updating the new centorid 
        [r, lymphid]=addLymphMarkToWorkspace(xs,ys,handles);
        if(r>0)
            updateLymphGui(lymphid, handles);
            reses(l)=1;
        elseif(r==0)
            updateLymphGui('', handles);
            reses(l)=0;
            res=0;
            
        end
        showImage(handles,1);
        showThreshold(handles);        
        isPressed = get(hObject,'Value');
        
    end
    pause(0.1);
end



%return 0 if not added, 1 if did, 2-if new cell was created.
function [wasAdded, lymphid]=addLymphMarkToWorkspace(xs,ys,handles)
[sitenum,framenum]=getSiteFrame(handles);
wasAdded=0;
movie=getCellStruct();
if (isempty(movie)) %create new movie object
    movie.momDaughTable=[];
    movie.maxLymphId=0;
    movie.momDaughInd=0;
    movie.lineageInd=0;
    assignin('base','movie',movie);
    monitorList=[];
    assignin('base','monitorList',monitorList);
end

if(isfield(movie,'sites') && length(movie.sites)>=sitenum && isfield(movie.sites(sitenum), 'lymphs') && ~isempty(movie.sites(sitenum).lymphs))
    lymphs=movie.sites(sitenum).lymphs;
end
lymphid=get(handles.id_edit, 'String');
if(isempty(lymphid))
    lymphid=getNextAvailableId(handles);
else
    lymphid=str2num(lymphid);
end
[lymph,siteind, lymphind]=getLymph(lymphid,movie);
if(isempty(lymph ))%create new lymph
    wasAdded=2;
    [lymph,movie, siteind,lymphind]=createNewLymph(lymphid,handles,movie);
end
ind=find(lymph.frames==framenum);
if(~isempty(ind)) %lymph allready has this frame marked
    %check if they are close if not-> should issue a warning
    if(overlap(lymph.locations{ind}, [xs,ys])>0.25)
        lymph.locations{ind}=[xs,ys];
    else
        button = questdlg('too far- do you want to  exit and create a new cell?','?','yes','no','yes');
        if(button(1)=='y')
            wasAdded=0;
            return;
        else
            lymph.locations{ind}=[xs,ys];
        end
    end
else %insert new frame and location
    ind=length(lymph.frames)+1;
    lymph.locations{ind}=[xs,ys];
    lymph.frames(ind)=framenum;
end
if(movie.maxLymphId<lymphid) %this is new movie structure or new cell created
    movie.maxLymphId=lymphid;
end
lymphs(lymphind)=lymph;
movie.sites(sitenum).lymphs=lymphs;
if(wasAdded~=2)
    wasAdded=1;
end
assignin('base','movie',movie);


%Inserts a mother daughter couple to the movie table, and advances the
%table index- returns the changed movie structure. if momid=-1 increases
%the lineage index as well
function movie= addMomDaughterCouple(movie, momid, lymphid)
% check if any of the lymph descendants are mom.

if(~isempty(movie.momDaughTable))
    inds=find(movie.momDaughTable(:,1)==momid & movie.momDaughTable(:,2)==lymphid);
    if(~isempty(inds))
        msgbox('mom-daughter couple allready exist');
        return
    end
end
mom=getLymph(momid,movie);

if(isempty(mom)&& momid~=-1)
    msgbox(' could not find mother cell in struct');
    return
end
lymph=getLymph(lymphid,movie);
if(isempty(lymph))
    msgbox(' could not find daughter cell in struct');
    return
end
[descenIds]=getDescenIds(movie,lymphid,[]);
for i=1:length(descenIds)
    if(descenIds(i)==momid)
        msgbox('mom is a descendants- beware of CIRCLES!!!');
        return;
    end
end
ind=movie.momDaughInd()+1;
movie.momDaughTable(ind,1:2)=[momid,lymphid];
movie.momDaughInd=ind;
if(momid==-1)
    movie.lineageInd=movie.lineageInd+1;
else %delete a line which has -1 as mom of the lymph
    ind=find(movie.momDaughTable(:,1)==-1 & movie.momDaughTable(:,2)==lymphid);
    if(~isempty(ind))
        movie.momDaughTable(ind,:)=[];
        movie.momDaughInd=movie.momDaughInd-1;
    end
end
%if this is the only mom- and lymp name has allready been initizlized, and
%is different than mom
inds=find(movie.momDaughTable(:,2)==lymphid);
if(length(inds)==1 && movie.momDaughTable(inds,1)~=-1 && ~isempty(lymph.name))
    lymphLin=regexp(lymph.name, '(\d+)','tokens');
    lymphLin=lymphLin{1}{1};
    momLin=regexp(mom.name, '(\d+)','tokens');
    momLin=momLin{1}{1};
    if(~strcmp(momLin,lymphLin))
        movie= ame(momid, mom.name, movie);
    end
end



function remark_edit_Callback(hObject, eventdata, handles)
% hObject    handle to remark_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rem=get(hObject, 'String');
lymphid=get(handles.id_edit,'String');
if(isempty(lymphid))
    set(handles.remark_edit,'String',[]);
    return;
end
lymphid=str2num(lymphid);
movie=getCellStruct();
[lymph,siteind,lymphind]=getLymph(lymphid,movie);
if(isempty(lymph))
    set(handles.remark_edit,'String',[]);
    return;
end
lymph.remark=rem;
movie.sites(siteind).lymphs(lymphind)=lymph;
assignin('base','movie',movie);
% Hints: get(hObject,'String') returns contents of remark_edit as text
%        str2double(get(hObject,'String')) returns contents of remark_edit as a double


% --- Executes during object creation, after setting all properties.
function remark_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to remark_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in play_btn.
function play_btn_Callback(hObject, eventdata, handles)
% hObject    handle to play_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of play_btn
res=1;
val=get(handles.play_btn,'Value');
while(res && val)
    res=fwdFrame(handles);
    val=get(handles.play_btn,'Value');
    pause(0.01);
end
set(handles.play_btn, 'Value',0);



% --- Executes on button press in deleteMom_btn.
function deleteMom_btn_Callback(hObject, eventdata, handles)
% hObject    handle to deleteMom_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lymphid=get(handles.id_edit,'String');
if(isempty(lymphid))
    msgbox('not valid lymph id')
    return;
end
lymphid=str2num(lymphid);
movie=getCellStruct();
inds=find(movie.momDaughTable(:,2)==lymphid);
mominds=find(movie.momDaughTable(inds,1)>-1);
if(isempty(mominds))
    msgbox('no mothers exist table')
    return;
end
if(length(mominds)==1)
    momid=movie.momDaughTable(inds(mominds),1);
else
    momid=inputdlg('what is the mother''s id?');
    momid=momid{1};
    if(isempty(momid))
        msgbox('couldn''t find mom');
        return;
    end
    momid=str2num(momid);
end
movie=deleteMom(movie, lymphid, momid);
assignin('base','movie',movie);

%delete the line of momid,lymphid from the momdaughters table. If this is the only mom
%Change mother to -1  while creating a new lineage of the daughter.
%Returns the updated movie structure.
function movie=deleteMom(movie, lymphid, momid)
inds=find(movie.momDaughTable(:,2)==lymphid);
if(isempty(inds))
    msgbox('not valid lymph in table')
    return;
end
mominds=find(movie.momDaughTable(inds,1)>-1);
momind=find(movie.momDaughTable(inds,1)==momid);
if(~momind)
    msgbox('momid is not a mom of lymph')
    return;
end
momind=inds(momind);

if(length(mominds)==1) % if this is the only mother
    momind=inds(mominds);
    movie.momDaughTable(momind,1)=-1;
    %change the cell name and its predecessors
    movie.lineageInd=movie.lineageInd+1;
    linname=num2str(movie.lineageInd);
    movie= ame(lymphid, linname, movie);
elseif(length(mominds>1))
    movie.momDaughTable(momind,:)=[];
end


%changes the ancestor cell and its predecessors name to the one begining in
%name. (this works recursively in DFS...)
function movie = ame(lymphid, name, movie)
[lymph,siteind,lymphind]=getLymph(lymphid, movie);
if(isempty(lymph))
    return;
end
lymph.name=name;
movie.sites(siteind).lymphs(lymphind)=lymph;
predInds=find(movie.momDaughTable(:, 1)==lymphid);
for i=1:length(predInds)
    predId=movie.momDaughTable(predInds(i),2);
    predName = sprintf('%s_%d', name, i);
    movie= ame(predId, predName, movie);
end



% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_struct_menubtn_Callback(hObject, eventdata, handles)
% hObject    handle to load_struct_menubtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loadCellsStruct(handles);




function loadCellsStruct(handles)
projectDir=get(handles.edit1 ,'String');
[filename,projectDir]= uigetfile('*.mat', 'load movie struct',projectDir);
path=sprintf('%s\\%s', projectDir, filename);
load(path,'movie');
assignin('base','movie',movie);


% --------------------------------------------------------------------
function saveCellsStruct_menubtn_Callback(hObject, eventdata, handles)
% hObject    handle to saveCellsStruct_menubtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveCellsStruct(handles);

function saveCellsStruct(handles)
try
    movie=evalin('base', 'movie');
    projectDir=get(handles.edit1 ,'String');
    path=sprintf('%s\\movie', projectDir);
    uisave('movie', path);
    %     save(path,'movie');
catch
    msgbox('no data structure to save');
end



% --------------------------------------------------------------------
function extractFluo_menubtn_Callback(hObject, eventdata, handles)
% hObject    handle to extractFluo_menubtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Note that whether normalized or unnormalized paths are placed, the default
%is to use normalized pictures i.e names such as:
%L1210Fucci9_filter_1_expo4000_offset10_1_normalized_1439.
projectDir=get(handles.edit1 ,'String');
[filename,projectDir]= uigetfile('*.tif', 'pick fluoresence type file',projectDir);
i=regexp(filename,'_\d+_normalized_\d+.tif');
if(~isempty(i))
    %     i=regexp(filename,'_\d+_normalized_', 'end');
    fileTemplate=filename(1:i-1);
else
    i=regexp(filename,'_\d+_\d+.tif');
    if(~isempty(i))
        fileTemplate=filename(1:i-1);
    else
        msgbox('cannot extract fluoresence');
        return;
    end
end
fileTemplate=sprintf('%s\\%s', projectDir, fileTemplate);
fluoname= inputdlg('what is the fluocesence name?');
movie=getCellStruct();
movie=extractFluoFromMovie(movie,fileTemplate, fluoname);
if(~isempty(movie))
    assignin('base','movie',movie);
    saveCellsStruct(handles);
end


% --------------------------------------------------------------------
function addContinuesMark_menubtn_Callback(hObject, eventdata, handles)
% hObject    handle to addContinuesMark_menubtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
movie=getCellStruct();
recipientId=inputdlg('what is the recipient cell id?');
if(isempty(recipientId))
    msgbox('not a valid lymph');
    return;
end
recipientId=str2num(recipientId{1});
[recipient,recSiteind,recInd]=getLymph(recipientId, movie);
if(isempty(recipient))
    msgbox('not a valid lymph');
    return;
end
donorId=inputdlg('what is the donor cell id?');
if(isempty(donorId))
    msgbox('not a valid lymph');
    return;
end
donorId=str2num(donorId{1});
[donor, donorSiteind,donorInd]=getLymph(donorId, movie);
if(isempty(donor))
    msgbox('not a valid lymph');
    return;
end
framenum=inputdlg('from which frame?');
if(isempty(framenum))
    msgbox('no frame number');
    return;
end
framenum=str2num(framenum{1});
recInds=find(recipient.frames>=framenum);
donorInds=find(donor.frames>=framenum);
if(isempty(donorInds))
    msgbox('no frames exist');
    return;
end

button = questdlg('which procees to perform?','','copy recipient to donor and earse donor','switch','switch');
tempFrames=recipient.frames(recInds);
tempLocs=recipient.locations(recInds);
recipient.frames(recInds)=[];
recipient.locations(recInds)=[];
ind=length(recipient.frames);
len=length(donorInds);
recipient.frames(ind+1:ind+len)=donor.frames(donorInds);
recipient.locations(ind+1:ind+len)=donor.locations(donorInds);
donor.frames(donorInds)=[];
donor.locations(donorInds)=[];

dDaughtersIDS=find(movie.momDaughTable(:,1)==donor.id);
%delete donor's daughters from donor and copy to recepient
for i=1:length(dDaughtersIDS)
    movie=deleteMom(movie,dDaughtersIDS(i), donor.id);
    movie=addMomDaughterCouple(movie, recipient.id, dDaughtersIDS(i));
end
switch button
    case 'copy recipient to donor and earse donor'
        %check if donor is empty delete cells
        %         dMomsIDs=find(movie.momDaughTable(:,2)==donor.id);
        %         %copy mothers to recepients
        %         for i=1:length(dMomsIDs)
        %             movie=addMomDaughterCouple(movie,  dMomsIDs(i),recipient.id);
        %         end
        %if entire donor was moved to recipeint earse, elsr
        if(length(donor.frames)==0)
            movie.sites(donorSiteind).lymphs(donorInd)=[];
            
        else
            movie.sites(donorSiteind).lymphs(donorInd)=donor;
        end
    case 'switch'
        ind=length(tempFrames);
        len=length(recInds);
        donor.frames(ind+1:ind+len)=tempFrames;
        donor.locations(ind+1:ind+len)=tempLocs;
        %copy recepients's daughters to donor earse daughters from
        %recipeints
        
        rDaughtersIDs=find(movie.momDaughTable(:,1)==recipient.id);
        for i=1:length(rDaughtersIDs)
            movie=deleteMom(movie,rDaughtersIds(i), recipient.id);
            movie=addMomDaughterCouple(movie, donor.id, rDaughtersIds(i));
        end
        movie.sites(donorSiteind).lymphs(donorInd)=donor;
end
movie.sites(recSiteind).lymphs(recInd)=recipient;
assignin('base','movie',movie);
msgbox('note you may need to add mothers to receient');




% --------------------------------------------------------------------
function tools_menu_Callback(hObject, eventdata, handles)
% hObject    handle to tools_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function getTimes_menubtn_Callback(hObject, eventdata, handles)
% hObject    handle to getTimes_menubtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
projectDir=get(handles.edit1 ,'String');
[filename,projectDir]= uigetfile('*.tif', 'load phase path',projectDir);
% i=regexp(filename,'_\d+_\d+.tif');
s2=regexp(filename, '_', 'split');
i=regexp(filename,s2{end})
if(~isempty(i))
    fileTemplate=filename(1:i-1);
end
fileTemplate=sprintf('%s*', fileTemplate);
[TimeAxis, FileVec] = makeTimeAxis(projectDir,fileTemplate);
if(~isempty(TimeAxis))
    movie=getCellStruct();
    movie.times=TimeAxis;
    assignin('base','movie',movie);
end


% --------------------------------------------------------------------
function dispOutlines_menubtn_Callback(hObject, eventdata, handles)
% hObject    handle to dispOutlines_menubtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'Checked'),'on')
    set(hObject, 'Checked', 'off');
else
    set(hObject, 'Checked', 'on');
end
showImage(handles,1);


function [isChecked]=isDispOutlinesChecked(handles)
if strcmp(get(handles.dispOutlines_menubtn, 'Checked'),'on')
    isChecked=1;
else
    isChecked=0;
end


% --------------------------------------------------------------------
function analysis_meun_Callback(hObject, ~, handles)
% hObject    handle to analysis_meun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function plotFluo_Callback(hObject, eventdata, handles)
% hObject    handle to plotFluo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lymphid=get(handles.id_edit,'String');
lymphid=str2num(lymphid);
movie=getCellStruct();
lymph=getLymph(lymphid,movie);
if(isempty(lymph))
    msgbox('Not a valid lymph');
    return;
end
plotCellFluos(lymph);


% --------------------------------------------------------------------
function normalizeFluo_Callback(hObject, eventdata, handles)
% hObject    handle to normalizeFluo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
projectDir=get(handles.edit1 ,'String');
createNormalizedFluo(projectDir);


% --------------------------------------------------------------------
function alignImg_Callback(hObject, eventdata, handles)
% hObject    handle to alignImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filePrefix=get(handles.edit5 ,'String');
projectDir=get(handles.edit1 ,'String');
[sitenum,framenum]=getSiteFrame(handles);
outputDir=uigetdir('','Choose project directory');
alignImages(projectDir, filePrefix, sitenum,outputDir);


% --------------------------------------------------------------------
function normalizeFluoPerCellPerFrame_Callback(hObject, eventdata, handles)
% hObject    handle to normalizeFluoPerCellPerFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
projectDir=get(handles.edit1 ,'String');
loadCellsStruct(handles);
movie=evalin('base', 'movie');
createNormalizedFluoPerCellsPerFrame(projectDir,movie);


% --------------------------------------------------------------------
function changeFileTemplateBtn_Callback(hObject, eventdata, handles)
% hObject    handle to changeFileTemplateBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%This is to concatenate 2 movie paths.
projectDir=get(handles.edit1 ,'String');
[basename,baseDir]= uigetfile('*.tif', 'load base path',projectDir);
[secname,secDir]= uigetfile('*.tif', 'load path to convert',projectDir);
[baseTemplate,lastFrame]=getBasePathParams(baseDir,basename);
basenum= inputdlg('','convertion begins at which frame? ',1,{sprintf('%d',lastFrame+1)});
basenum=str2num(basenum{1});
[secTemplate,lastFrame,secFrame]=getBasePathParams(secDir,secname);
num2add=basenum-secFrame;
secOutput = dir(fullfile(secDir,sprintf('%s*',secTemplate)));
secfileVec   = {secOutput.name}';
for i=1:length(secfileVec)
    nameTokens=regexp(secfileVec{i},'.+(_expo.+_)(\d+).tif','tokens');
    currFrame=str2num(nameTokens{1}{2});
    newSecName=sprintf('%s%s%d.tif',baseTemplate,nameTokens{1}{1},currFrame+num2add);
    fileToConvert=fullfile(secDir,secfileVec{i});
    newPath=fullfile(baseDir,newSecName);
    copyfile(fileToConvert,newPath);
end






% --------------------------------------------------------------------
function compile_movie_Callback(hObject, eventdata, handles)
% hObject    handle to compile_movie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%all lymphs is a struct-array containing all lymphs
%lymphMappingMat is a Nx4 matirx, where each line corresponde to a specific
%lymphocyte. first column has the lymph inds in the allLymphs array, second
%column the lymph id, thirs the lymph site and fourth 1 if has both mother
%and duaghtres (i.e. 'complete') and 0 otherwise.
%in column 5 the lineage ancestor name is given
%this also sorts all the frames and values of locations etc.
projectDir=get(handles.edit1 ,'String');
[filename,projectDir]= uigetfile('*.mat', 'load movie struct',projectDir);
path=sprintf('%s\\%s', projectDir, filename);
load(path,'movie');
assignin('base','movie',movie);
allLymphs=[];
lymphMappingMat=[];
ind=1;
matInd=1;
%TODO check if fate -divide mathces the movie.MomDaughtTable
for i=1:length(movie.sites)
    lymphs=movie.sites(i).lymphs;
    for j=1:length(lymphs)
        l=lymphs(j);
        %sortLymph
        lymph.id=l.id;
        lymph.name=l.name;
        lymph.fate=l.fate;
        [sframes,sinds]=sort(l.frames);
        lymph.frames=sframes;
        lymph.times=movie.times(sframes-1000);
        lymph.locations=l.locations(sinds);
        for f=1:length(l.fluos)
            fluo=l.fluos{f};
            nfluo.name=fluo.name;
            nfluo.path=fluo.path;
            [sframes,sinds]=sort(fluo.Frames);
            nfluo.Frames=sframes;
            nfluo.Means=fluo.Means(sinds);
            nfluo.Max=fluo.Max(sinds);
            nfluo.Min=fluo.Min(sinds);
            nfluo.Std=fluo.Std(sinds);
            lymph.fluos{f}=nfluo;
        end
        %
        allLymphs{ind}=lymph;
        lymphMappingMat(matInd,1)=ind;
        lymphMappingMat(matInd,2)=lymph.id;
        lymphMappingMat(matInd,3)=i;
        mid=find(movie.momDaughTable(:,2)==lymph.id,1);
        if(movie.momDaughTable(mid,1)~=-1 && ~isempty(find(movie.momDaughTable(:,1)==lymph.id,1)))
            lymphMappingMat(matInd,4)=1;
        else
            lymphMappingMat(matInd,4)=0;
        end
        g=regexp(lymph.name,'_');
        if(isempty(g))
            lymphMappingMat(matInd,5)=str2num(lymph.name);
        else
            lymphMappingMat(matInd,5)=str2num(lymph.name(1:g(1)-1));
        end
        matInd=matInd+1;
        ind=ind+1;
    end
    assignin('base','allLymphs',allLymphs);
    assignin('base','lymphMappingMat',lymphMappingMat);
end


% --------------------------------------------------------------------
function addCell2List_Callback(hObject, eventdata, handles)
% hObject    handle to addCell2List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=getappdata(handles.cellContextMenu,'currPoint');
cx=p(1,1);
cy=p(1,2);
lymphid=isDotInLymph(handles, cx,cy);
monitorList=getMonitorList();
if(lymphid)
    monitorList= addLymphidToMonitorList(monitorList,lymphid);
else %ask if want to add new lymph
    res=inputdlg('add new lymph? y/n');
    if (strcmp(res,'y'))
        [r, lymphid]=magicWand(cx,cy,handles);
        if(lymphid)
            monitorList=addLymphidToMonitorList(monitorList,lymphid);
        end
    end
end
assignin('base','monitorList',monitorList);

% --------------------------------------------------------------------
function removeCellFromList_Callback(hObject, eventdata, handles)
% hObject    handle to removeCellFromList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=getappdata(handles.cellContextMenu,'currPoint');
cx=p(1,1);
cy=p(1,2);
lymphid=isDotInLymph(handles, cx,cy);
res= removeFromList(lymphid);
if(res==3)
        msgbox('no such lymph in list')   
elseif(res==2)
    msgbox('no such lymph in movie')
end


% --------------------------------------------------------------------
function clearList_Callback(hObject, eventdata, handles)
% hObject    handle to clearList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
res=inputdlg('Sure you want to clear list? y/n');
monitorList=getMonitorList();
if(strcmp(res,'y'))
    monitorList=[];
    assignin('base','monitorList',monitorList);
end
monitorList=getMonitorList();

%return 1 if removed succesfully, 2 if no such lymph id, 3 if not in list
function res= removeFromList(lymphid)
monitorList=getMonitorList();
if(lymphid)
    ind=find(monitorList==lymphid);
    if(isempty(ind))
        res=2;
    else
        monitorList(ind)=[];
        assignin('base','monitorList',monitorList);
        res=1;
    end
else
    res=3;
end



function cellContextMenu_Callback(hObject, eventdata, handles)
% hObject    handle to cellContextMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currpoint=get(gca,'Currentpoint');
setappdata(handles.cellContextMenu,'currPoint',currpoint);% guidata(handles,handles)

%adds the lymphid to the list if not allready exist
function [monitorList]= addLymphidToMonitorList(monitorList,lymphid)
if(isempty(find(monitorList==lymphid,1)))
    monitorList(end+1)=lymphid;
end

%if lymphid is in list return 1 else 0
function [inList]= isInMonitorList(lymphid)
monitorList=getMonitorList();
if(~isempty(find(monitorList==lymphid,1)))
    inList=1;
else
    inList=0;
end

function [centroid,boundingBox]=getLymphCentroid(lymphid,handles)
movie=getCellStruct();
[lymph, siteind,lymphind]=getLymph(lymphid,movie);
[sitenum,curframe]=getSiteFrame(handles);
ind=find(lymph.frames==curframe);
locations=lymph.locations{ind};
im=getImage(handles.axes1);
bw=poly2mask(locations(:,1), locations(:,2), size(im,1),size(im,2));
centroid=regionprops(bw,'Centroid');
boundingBox=regionprops(bw,'boundingBox');
if(length(centroid)>1)
    centroid=centroid(1);
    boundingBox=boundingBox(1);
end

