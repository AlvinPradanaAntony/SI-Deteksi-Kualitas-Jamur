function varargout = GUI_gradingJamur(varargin)
% GUI_GRADINGJAMUR MATLAB code for GUI_gradingJamur.fig
%      GUI_GRADINGJAMUR, by itself, creates a new GUI_GRADINGJAMUR or raises the existing
%      singleton*.
% 
%      H = GUI_GRADINGJAMUR returns the handle to a new GUI_GRADINGJAMUR or the handle to
%      the existing singleton*.
%
%      GUI_GRADINGJAMUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_GRADINGJAMUR.M with the given input arguments.
%
%      GUI_GRADINGJAMUR('Property','Value',...) creates a new GUI_GRADINGJAMUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_gradingJamur_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_gradingJamur_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_gradingJamur

% Last Modified by GUIDE v2.5 01-Jan-2023 16:27:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_gradingJamur_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_gradingJamur_OutputFcn, ...
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


% --- Executes just before GUI_gradingJamur is made visible.
function GUI_gradingJamur_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_gradingJamur (see VARARGIN)

% Choose default command line output for GUI_gradingJamur
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,"center");

% UIWAIT makes GUI_gradingJamur wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_gradingJamur_OutputFcn(hObject, eventdata, handles)
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

        % 	Menyimpan nama file citra pada edit text
        set(handles.edit1, 'String', filename);

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

        % 	Menyimpan nama file citra pada edit text
        set(handles.edit1, 'String', filename);

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
    % set(handles.pushbutton2,'Enable','on')
else
    return;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
cam_device = webcamlist;
ListCam = (cam_device);
menu_cam = menus('Pilih Video Input:',ListCam);
if isempty(ListCam)||menu_cam==0
    clear('VidObj');
    msgbox({'Tidak ada Video Input yang terdeteksi'})
    return
end

VidObj = webcam(menu_cam);
handles.VidObj = VidObj;
axes(handles.axes1);
hImage=image(zeros(720,1280,1),'Parent', handles.axes1);
preview(handles.VidObj, hImage);
set(handles.pushbutton9,'Visible', 'On');
guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
Img = handles.edgesImg;
axes(handles.axes3);
cla reset
imshow(Img)
title('Deteksi Tepi','Color','w');
h = imellipse;
setColor(h,'b')
mask = createMask(h);
% bw = activecontour(Img,mask,1000);
I = imresize(Img,.5);  %-- make image smaller
m = imresize(mask,.5);  %     for fast computation
bw = region_seg(I, m, 800); %-- Run segmentation
bw = imfill(bw,'holes');
bw = bwareaopen(bw,500);
bw = imclearborder(bw);
axes(handles.axes4);
cla reset
imshow(bw)
title('Hasil','Color','w');
axis off
hold on
[c,~] = bwboundaries(bw,'noholes');

for k = 1:length(c)
    boundary = c{k};
    plot(boundary(:,2), boundary(:,1),'y','LineWidth',3)
end
hold off
%set(handles.edit3,'String',[]);
%set(handles.edit4,'String',[]');
handles.bw = bw;
guidata(hObject, handles)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
bw = handles.bw;
[tinggi, lebar] = size(bw);
hasil = 0;
for p = 1 : tinggi
    for q = 1 : lebar
        if bw(p, q) == 1
            hasil = hasil + 1;
        end
    end
end
area_bw = hasil;
% s  = regionprops(bw, 'area', 'EquivDiameter');
% area_bw = s.Area;
%perim_bw = s.Perimeter;
diameter_bw = sqrt(4 * area_bw / pi);
% diameter_bww = s.EquivDiameter;

res = 1.362; % resolusi spasial 1.362 pixel/mm
area = area_bw/(res^2)/100;
%perimeter = perim_bw/res/10;
diameterr = diameter_bw/res/10;
% diameterrr = diameter_bww/res/10;
handles.diameter = diameterr;
guidata(hObject, handles)

set(handles.edit3,'String',[num2str(area),' cm2']);
set(handles.edit4,'String',[num2str(diameterr),' cm']);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
diameterr = handles.diameter;
if diameterr < 5
    set(handles.edit2,'String',' Grade C');
elseif diameterr >= 5 && diameterr <= 10
    set(handles.edit2,'String',' Grade B');
else
    set(handles.edit2,'String',' Grade A');
    set(handles.edit2,'ForegroundColor',[0.01, 0.48, 0.28]);
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
try
    delete(handles.VidObj);
catch
end

axes(handles.axes1)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
set(gca, 'Color', '#28293d');
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
axes(handles.axes4);
cla('reset');
set(gca,'XTick',[]);
set(gca,'YTick',[]);
set(gca,'color','#28293d');
set(handles.pushbutton9,'Visible', 'Off');

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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.img_gray;
%fill = imfill(Img_Gray,'holes');
%se = strel('disk', 7);
%open = imopen(fill,se);

%Value for Thresholding
T_Low = 0.075;
T_High = 0.175;

%Gaussian Filter Coefficient
B = [2, 4, 5, 4, 2; 4, 9, 12, 9, 4;5, 12, 15, 12, 5;4, 9, 12, 9, 4;2, 4, 5, 4, 2 ];
B = 1/159.* B;

%Convolution of image by Gaussian Coefficient
A=conv2(img, B, 'same');

%Filter for horizontal and vertical direction
KGx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
KGy = [1, 2, 1; 0, 0, 0; -1, -2, -1];

%Convolution by image by horizontal and vertical filter
Filtered_X = conv2(A, KGx, 'same');
Filtered_Y = conv2(A, KGy, 'same');

%Calculate directions/orientations
arah = atan2 (Filtered_Y, Filtered_X);
arah = arah*180/pi;

pan=size(A,1);
leb=size(A,2);

%Adjustment for negative directions, making all directions positive
for i=1:pan
    for j=1:leb
        if (arah(i,j)<0)
            arah(i,j)=360+arah(i,j);
        end
    end
end

arah2=zeros(pan, leb);

%Adjusting directions to nearest 0, 45, 90, or 135 degree
for i = 1  : pan
    for j = 1 : leb
        if ((arah(i, j) >= 0 ) && (arah(i, j) < 22.5) || (arah(i, j) >= 157.5) && (arah(i, j) < 202.5) || (arah(i, j) >= 337.5) && (arah(i, j) <= 360))
            arah2(i, j) = 0;
        elseif ((arah(i, j) >= 22.5) && (arah(i, j) < 67.5) || (arah(i, j) >= 202.5) && (arah(i, j) < 247.5))
            arah2(i, j) = 45;
        elseif ((arah(i, j) >= 67.5 && arah(i, j) < 112.5) || (arah(i, j) >= 247.5 && arah(i, j) < 292.5))
            arah2(i, j) = 90;
        elseif ((arah(i, j) >= 112.5 && arah(i, j) < 157.5) || (arah(i, j) >= 292.5 && arah(i, j) < 337.5))
            arah2(i, j) = 135;
        end
    end
end

%figure, imagesc(arah2); colorbar;

%Calculate magnitude
magnitude = (Filtered_X.^2) + (Filtered_Y.^2);
magnitude2 = sqrt(magnitude);

BW = zeros (pan, leb);

%Non-Maximum Supression
for i=2:pan-1
    for j=2:leb-1
        if (arah2(i,j)==0)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i,j+1), magnitude2(i,j-1)]));
        elseif (arah2(i,j)==45)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j-1), magnitude2(i-1,j+1)]));
        elseif (arah2(i,j)==90)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j), magnitude2(i-1,j)]));
        elseif (arah2(i,j)==135)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j+1), magnitude2(i-1,j-1)]));
        end
    end
end

BW = BW.*magnitude2;
%figure, imshow(BW);

%Hysteresis Thresholding
T_Low = T_Low * max(max(BW));
T_High = T_High * max(max(BW));

T_res = zeros (pan, leb);

for i = 1  : pan
    for j = 1 : leb
        if (BW(i, j) < T_Low)
            T_res(i, j) = 0;
        elseif (BW(i, j) > T_High)
            T_res(i, j) = 1;
            %Using 8-connected components
        elseif ( BW(i+1,j)>T_High || BW(i-1,j)>T_High || BW(i,j+1)>T_High || BW(i,j-1)>T_High || BW(i-1, j-1)>T_High || BW(i-1, j+1)>T_High || BW(i+1, j+1)>T_High || BW(i+1, j-1)>T_High)
            T_res(i,j) = 1;
        end
    end
end

edge_final = uint8(T_res.*255);
% Tampilkan gambar
axes(handles.axes3)
cla('reset')
imshow(edge_final)
% title('Citra Hasil Deteksi Tepi','Color','white')
title('Deteksi Tepi','Color','w');
handles.edgesImg = edge_final;
guidata(hObject, handles)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
cam = handles.VidObj;
img = snapshot(cam);
counter = 1;
baseDir = '../Grading Jamur/Data_learning';
baseName = 'Dataset_'; %Nakk is the name i have chosen for the image files
newName = fullfile(baseDir, sprintf('%s%d.jpg', baseName, counter));
while exist(newName,'file')
    counter = counter + 1;
    newName = fullfile(baseDir, sprintf('%s%d.jpg', baseName, counter));
end
imwrite(img, newName);

try
    delete(handles.VidObj);
catch
end
axes(handles.axes1);
imshow(img)
set(handles.pushbutton9,'Visible', 'Off');

% Grayscale

guidata(hObject,handles);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 %melakukan ekstraksi ciri tekstur menggunakan metode GLCM
    pixel_dist = 1;
    %membentuk matriks kookurensi
    glcm = graycomatrix(filename,'Offset',[0 pixel_dist; -pixel_dist pixel_dist; pixel_dist 0; -pixel_dist -pixel_dist]);
    stats = graycoprops(glcm,'Correlation','Energy');
   
    Correlation = mean(stats.Correlation);
    Energy = mean(stats.Energy);

    %menyusun variabel data learning
    data_learning(1,1) = Correlation;
    data_learning(1,2) = Energy;

    %memanggil variabel mdl hasil pelatihan
    load Mdl

    %membaca kelas keluaran hasil penglearningan
    kelas_keluaran = predict(Mdl,data_learning);

    %menampilkan citra asli dan kelas keluaran hasil penglearningan
    figure, imshow(Img)
     title({['Nama File: ',filename],['Kelas Keluaran : ',kelas_keluaran{1}]}) 
    %jika tidak ada nama file yg dipilih maka akan kembali
    return
