function varargout = GUI_acara29_deteksiTepi(varargin)
% GUI_ACARA29_DETEKSITEPI MATLAB code for GUI_acara29_deteksiTepi.fig
%      GUI_ACARA29_DETEKSITEPI, by itself, creates a new GUI_ACARA29_DETEKSITEPI or raises the existing
%      singleton*.
%
%      H = GUI_ACARA29_DETEKSITEPI returns the handle to a new GUI_ACARA29_DETEKSITEPI or the handle to
%      the existing singleton*.
%
%      GUI_ACARA29_DETEKSITEPI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ACARA29_DETEKSITEPI.M with the given input arguments.
%
%      GUI_ACARA29_DETEKSITEPI('Property','Value',...) creates a new GUI_ACARA29_DETEKSITEPI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_acara29_deteksiTepi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_acara29_deteksiTepi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_acara29_deteksiTepi

% Last Modified by GUIDE v2.5 31-Oct-2022 03:33:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_acara29_deteksiTepi_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_acara29_deteksiTepi_OutputFcn, ...
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


% --- Executes just before GUI_acara29_deteksiTepi is made visible.
function GUI_acara29_deteksiTepi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_acara29_deteksiTepi (see VARARGIN)

% Choose default command line output for GUI_acara29_deteksiTepi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject, "center");

% UIWAIT makes GUI_acara29_deteksiTepi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_acara29_deteksiTepi_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[filename,pathname] = uigetfile( ...
    {'*.bmp;*.jpg;*.tif;*.png','Files of type (*.bmp,*.jpg,*.tif,*.png)';
    '*.bmp','File Bitmap (*.bmp)';...
    '*.jpg','File jpeg (*.jpg)';
    '*.tif','File Tif (*.tif)';
    '*.png','File PNG (*.png)'},...
    'Open Image');
if ~isequal(filename,0)
    handles.img = imread(fullfile(pathname,filename));
    [rows, columns, channel] = size(handles.img);
    if channel > 1
        handles.img_gray = rgb2gray(handles.img);
        axes(handles.axes1);
        cla('reset');
        imshow(handles.img);
        title('Citra Asli', 'Color','w');
        axes(handles.axes2);
        cla('reset');
        imshow(handles.img_gray);
        title('Citra Grayscale', 'Color','w');
    else
        handles.img_gray = handles.img;
        axes(handles.axes1);
        cla('reset');
        imshow(handles.img);
        title('Citra Asli', 'Color','w');
        uiwait(msgbox("Citra sudah grayscale","Notice","modal"));
        axes(handles.axes2);
        cla('reset');
        imshow(handles.img);
        title('Citra Grayscale', 'Color','w');
    end
    axes(handles.axes3);
    cla('reset');
    set(gca,'XTick',[]);
    set(gca,'YTick',[]);
    set(gca,'color','#28293d');
    guidata(hObject,handles);
    set(handles.pushbutton2,'Enable','on')
else
    return;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
Img_Gray = handles.img_gray;
% Method
method = get(handles.method_group, 'SelectedObject');
result1 = get(method,'String');

if result1 == "Sobel Edge Detection"
    edge_detection = edge(Img_Gray, "sobel");
    bw = imfill(edge_detection, 'holes');
    edge_detection = bwareaopen(bw,120);
elseif result1 == "Prewit Edge Detection"
    edge_detection = edge(Img_Gray, "prewitt");
        bw = imfill(edge_detection, 'holes');
    edge_detection = bwareaopen(bw,120);
elseif result1 == "Canny Edge Detection"
    edge_detection = edge(Img_Gray, "canny");
        bw = imfill(edge_detection, 'holes');
    edge_detection = bwareaopen(bw,120);
elseif result1 == "Robert Edge Detection"
    edge_detection = edge(Img_Gray, "roberts");
        bw = imfill(edge_detection, 'holes');
    edge_detection = bwareaopen(bw,120);
end

axes(handles.axes3);
cla('reset');
imshow(edge_detection);
title(result1, 'Color','w');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla('reset');
set(gca,'XTick',[]);
set(gca,'YTick',[]);
set(gca,'color','#28293d');
axes(handles.axes2);
cla('reset');
set(gca,'XTick',[]);
set(gca,'YTick',[]);
set(gca,'color','#28293d');
axes(handles.axes3);
cla('reset');
set(gca,'XTick',[]);
set(gca,'YTick',[]);
set(gca,'color','#28293d');
set(handles.pushbutton2,'Enable','off');
set(handles.radiobutton1,'Value',1);
