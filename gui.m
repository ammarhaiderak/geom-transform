function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 05-Jun-2020 23:26:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;
handles.d='hello';
handles.imgpath='';
handles.transformedImg=[];
handles.origPts=[];
handles.destPts=[];
handles.done=0;
handles.n=1;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fname, fpath] = uigetfile('*');
imgpath=fullfile(fpath, fname);
disp(imgpath);

%orig=handles.orignal;
%imshow(imgpath);

handles.imgpath=imgpath;
handles.done=0;


myimg = imread(imgpath);
set(handles.orignal,'Units','pixels');
resizePos = get(handles.orignal,'Position');
myImage= imresize(myimg, [resizePos(3) resizePos(3)]);
axes(handles.orignal);
imshow(myImage);
set(handles.orignal,'Units','normalized');
msg='Image Loaded Successfully!';
set(handles.msg,'String',msg);

guidata(hObject, handles);

% --- Executes on button press in transform.
function transform_Callback(hObject, eventdata, handles)
% hObject    handle to transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp(handles);
i=imread(handles.imgpath);

opt=get(handles.nnbtn,'value');
option=2;
% if opt==0
%     opt=get(handles.avgbtn,'value');
%     option=2;
% end
% if opt==0
%     opt=get(handles.bibtn,'value');
%     option=3;
% end

if get(handles.simplebtn,'value')==1
    set(handles.msg,'String','Processing...');
    [transformedImg,origPts,destPts]=simpleTransform(i,option);
    handles.transformedImg=transformedImg;
    handles.origPts=origPts;
    handles.destPts=destPts;

    myimg = transformedImg;
    set(handles.transformed,'Units','pixels');
    resizePos = get(handles.transformed,'Position');
    myImage= imresize(myimg, [resizePos(3) resizePos(3)]);
    axes(handles.transformed);
    imshow(myImage);
    set(handles.orignal,'Units','normalized');
    set(handles.msg,'String','Done!');

elseif get(handles.meshbtn,'value')==1
    n=get(handles.meshsize,'value')+1;
    if n<=2
        set(handles.msg,'String','Choose the correct Mesh Size!');
    else
        set(handles.msg,'String','Processing...');
        [T,distBuffx,distBuffy,origBuffx,origBuffy]=meshTransform(i,n,option);
        handles.transformedImg=T;
        handles.distBuffx=distBuffx;
        handles.distBuffy=distBuffy;
        handles.origBuffx=origBuffx;
        handles.origBuffy=origBuffy;
        handles.n=n;
        
        set(handles.msg,'String','Done!');
        
        
    myimg = T;
    set(handles.transformed,'Units','pixels');
    resizePos = get(handles.transformed,'Position');
    myImage= imresize(myimg, [resizePos(3) resizePos(3)]);
    axes(handles.transformed);
    imshow(myImage);
    set(handles.orignal,'Units','normalized');
    set(handles.msg,'String','Done!');
        
        
    end

end

guidata(hObject, handles);

% --- Executes on button press in restore.
function restore_Callback(hObject, eventdata, handles)
% hObject    handle to restore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.done==0
        opt=get(handles.nnbtn,'value');
        option=2;
%         if opt==0
%             opt=get(handles.avgbtn,'value');
%             option=2;
%         end
%         if opt==0
%             opt=get(handles.bibtn,'value');
%             option=3;
%         end
    
    
        myimg = handles.transformedImg;
        set(handles.orignal,'Units','pixels');
        resizePos = get(handles.orignal,'Position');
        myImage= imresize(myimg, [resizePos(3) resizePos(3)]);
        axes(handles.orignal);
        imshow(myImage);
        set(handles.orignal,'Units','normalized');
    
    
    if get(handles.simplebtn,'value')==1
       

        restored=simpleTransformInv(myimg,handles.destPts,option);

        myimg = restored;
        
        set(handles.transformed,'Units','pixels');
        resizePos = get(handles.transformed,'Position');
        myImage= imresize(myimg, [resizePos(3) resizePos(3)]);
        axes(handles.transformed);
        imshow(myImage);
        set(handles.transformed,'Units','normalized');

        handles.done=1;
        guidata(hObject, handles);
        set(handles.msg,'String','Restored!');
        
    
    elseif get(handles.meshbtn,'value')==1
       
        restored=meshTransformInv(myimg,handles.distBuffx,handles.distBuffy,handles.origBuffx,handles.origBuffy,handles.n,option);

        myimg = restored;
        
        set(handles.transformed,'Units','pixels');
        resizePos = get(handles.transformed,'Position');
        myImage= imresize(myimg, [resizePos(3) resizePos(3)]);
        axes(handles.transformed);
        imshow(myImage);
        set(handles.transformed,'Units','normalized');

        handles.done=1;
        guidata(hObject, handles);
        set(handles.msg,'String','Restored!');
    end
        
    
    
    else
        set(handles.msg,'String','Already Restored! Load another image to Transform!');
end



% --- Executes on selection change in meshsize.
function meshsize_Callback(hObject, eventdata, handles)
% hObject    handle to meshsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns meshsize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from meshsize

% disp(get(hObject,'value'));
% n=get(hObject,'value')+1;
%   if n==2
%     set(handles.msg,'String','Incorrect Option Chosen!');
%   else
%     handles.n=n;
%     guidata(hObject, handles);
%   end

% --- Executes during object creation, after setting all properties.
function meshsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meshsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in meshbtn.
function meshbtn_Callback(hObject, eventdata, handles)
% hObject    handle to meshbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of meshbtn
set(handles.meshsize,'visible','on');
set(handles.msg,'String','Please Select mesh size!');


% --- Executes on button press in simplebtn.
function simplebtn_Callback(hObject, eventdata, handles)
% hObject    handle to simplebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of simplebtn
set(handles.meshsize,'visible','off');



