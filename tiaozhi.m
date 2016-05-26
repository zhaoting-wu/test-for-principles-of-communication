function varargout = tiaozhi(varargin)
% TIAOZHI M-file for tiaozhi.fig
%      TIAOZHI, by itself, creates a new TIAOZHI or raises the existing
%      singleton*.
%
%      H = TIAOZHI returns the handle to a new TIAOZHI or the handle to
%      the existing singleton*.
%
%      TIAOZHI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIAOZHI.M with the given input arguments.
%
%      TIAOZHI('Property','Value',...) creates a new TIAOZHI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tiaozhi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tiaozhi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tiaozhi

% Last Modified by GUIDE v2.5 18-Jan-2015 21:49:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tiaozhi_OpeningFcn, ...
                   'gui_OutputFcn',  @tiaozhi_OutputFcn, ...
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


% --- Executes just before tiaozhi is made visible.
function tiaozhi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tiaozhi (see VARARGIN)

% Choose default command line output for tiaozhi
handles.output = hObject;
set(handles.axes1,'Visible','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tiaozhi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tiaozhi_OutputFcn(hObject, eventdata, handles) 
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
fs=2000;
f1=5;
f2=90;
dt=1/fs;
a=[1 0 0 1 1 0 0 1 0 0];                 %产生原始数字随机信号
g1=a;   %原始信号1
g2=~a;  %原始信号2                    %将原始数字信号反转与g1反向
g11=(ones(1,2000))'*g1;              %进行抽样
g1a=g11(:)';                         %将数字序列变成列向量
g21=(ones(1,2000))'*g2;
g2a=g21(:)';
t=0:dt:10-dt;                         %在0~10-dt之间取值，取值间隔为dt
t1=length(t);
fsk1=g1a.*cos(2*pi*f1.*t);             %得到频率为f1的fsk1已调信号
fsk2=g2a.*cos(2*pi*f2.*t);             %得到频率为f2的fsk2已调信号
fsk=fsk1+fsk2;                       %已产生2FSK信号
no=0.01*randn(1,t1);                 %产生的随机噪声
sn=fsk+no;
h1=subplot(411);
plot(t,g1a);                            %原始信号的波形
axis([0 10 -0.2 1.2]);
title('调制信号波形');
ylabel('幅度');
h2=subplot(412);
plot(t,g2a);                            %原始信号的波形
axis([0 10 -0.2 1.2]);
title('调制信号取非波形');
ylabel('幅度');
h3=subplot(413);
plot(t,fsk1);
axis([0 10 -1.2 1.2]);
title('已调信号一波形');
ylabel('幅度');
h4=subplot(414);
plot(t,fsk2);
axis([0 10 -1.2 1.2]);
title('已调信号二波形');
ylabel('幅度');
handles.h1=h1;
handles.h2=h2;
handles.h3=h3;
handles.h4=h4;
handles.t=t;
handles.g1a=g1a;
handles.g2a=g2a;
handles.fsk1=fsk1;
handles.fsk2=fsk2;
handles.fsk=fsk;
handles.no=no;
handles.sn=sn;
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
open('mainscreen.fig');


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
t=handles.t;
switch get(hObject,'tag')
    case 'radiobutton1'
        g1a=handles.g1a;
        g2a=handles.g2a;
        fsk1=handles.fsk1;
        fsk2=handles.fsk2;
        h1=subplot(411);
        plot(t,g1a);                            %原始信号的波形
        axis([0 10 -0.2 1.2]);
        title('调制信号波形');
        ylabel('幅度');
        h2=subplot(412);
        plot(t,g2a);                            %原始信号的波形
        axis([0 10 -0.2 1.2]);
        title('调制信号取非波形');
        ylabel('幅度');
        h3=subplot(413);
        plot(t,fsk1);
        axis([0 10 -1.2 1.2]);
        title('已调信号一波形');
        ylabel('幅度');
        h4=subplot(414);
        plot(t,fsk2);
        axis([0 10 -1.2 1.2]);
        title('已调信号二波形');
        ylabel('幅度');
        handles.h1=h1;
        handles.h2=h2;
        handles.h3=h3;
        handles.h4=h4;
    case 'radiobutton2'
        fsk=handles.fsk;
        no=handles.no;
        sn=handles.sn;
        h1=subplot(311);
        plot(t,fsk);                            %2FSK信号的波形
        title('2fsk信号波形')                   
        ylabel('幅度')
        axis([0 10 -1.5 1.5]);
        h2=subplot(3,1,2);
        plot(t,no);                            %随机噪声的波形
        axis([0 10 -0.05 0.05]);
        title('噪声波形')
        ylabel('幅度')
        h3=subplot(3,1,3);
        plot(t,sn);
        title('经过信道后的2fsk波形')
        ylabel('幅度')
        xlabel('t');
        handles.h1=h1;
        handles.h2=h2;
        handles.h3=h3;  
end
guidata(hObject,handles);

