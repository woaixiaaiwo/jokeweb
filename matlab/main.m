
function varargout = main(varargin)
% MAIN M-file for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 19-Nov-2013 23:20:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
gauyction main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InP=0;OutP=0;AllP=0;
imaqmem(30000000);               %申请内存空间
axes(handles.axes1);
winvideoinfo=imaqhwinfo('winvideo');
usbvid=videoinput('winvideo', 1, 'YUY2_640x480');
usbvidRes=get(usbvid,'videoResolution');
nBands=get(usbvid,'NumberOfBands');
hImage=image(zeros(usbvidRes(2),usbvidRes(1),nBands));
h=preview(usbvid,hImage);
% start(usbvid);
pause(0.5);
muban=double(ycbcr2rgb(getsnapshot(usbvid))) ;
for i=1:10
    muban=muban*0.9+double(ycbcr2rgb(getsnapshot(usbvid))*0.1);
    pause(0.1);
end
axes(handles.axes2);
[m,n,dim]=size(muban);
m1=m/3;m2=2*m/3;yzx=n/2;yP=0;n1=1:n;n2=1:n;

set(handles.text1,'String',strcat('进入的人数是：',num2str(InP),', 出去的人数是：',num2str(OutP),', 内有总人数为：',num2str(AllP)));


while ishandle(h)     %判断是否有效的图像对象句柄
    NowP=double(ycbcr2rgb(getsnapshot(usbvid)));     % 捕获图像
    flushdata(usbvid);     %清除数据获取引擎的所有数据、置属性SamplesAvailable为0
    err=rgb2gray(uint8(abs(NowP-muban)));
    erzhi=err>30;
    imshow(erzhi);
    err0=sum(sum(erzhi))/(m*n);
    if err0<0.005
         muban=muban*0.98+NowP*0.02;
    end 
    x=0;y=0;
    if err0>0.03
        for i=1:m
            for j=1:n
               x=x+erzhi(i,j)*i;
               y=y+erzhi(i,j)*j;
            end
        end
        x=fix(x/(sum(sum(erzhi))));
        y=fix(y/(sum(sum(erzhi)))); 

        if abs(yP-y)>(n/2)
            yP=y;
        end
        if (yP<yzx) && (y>yzx)
            AllP=AllP+1;
            InP=1;
            OutP=0;
        end
        if y<yzx &&yP>yzx
            OutP=1;
            InP=0;
            AllP=AllP-1;
        end
        yP=y;
        hold on
        plot(y,x,'r*')     
        set(handles.text1,'String',strcat('进入的人数是：',num2str(InP),', 出去的人数是：',num2str(OutP),', 内有总人数为：',num2str(AllP)));  
    end
    rectangle('Position',[y-30 x-30 60 60],'EdgeColor','r');
%     plot(m1,n1,'g-');
%     plot(m2,n2,'g-')
    hold off
    ForeP=NowP;
    pause(0.01);
end;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

