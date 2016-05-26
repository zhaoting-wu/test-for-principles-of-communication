function varargout = jietiao(varargin)
% JIETIAO M-file for jietiao.fig
%      JIETIAO, by itself, creates a new JIETIAO or raises the existing
%      singleton*.
%
%      H = JIETIAO returns the handle to a new JIETIAO or the handle to
%      the existing singleton*.
%
%      JIETIAO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JIETIAO.M with the given input arguments.
%
%      JIETIAO('Property','Value',...) creates a new JIETIAO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before jietiao_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to jietiao_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jietiao

% Last Modified by GUIDE v2.5 18-Jan-2015 20:47:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jietiao_OpeningFcn, ...
                   'gui_OutputFcn',  @jietiao_OutputFcn, ...
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


% --- Executes just before jietiao is made visible.
function jietiao_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to jietiao (see VARARGIN)

% Choose default command line output for jietiao
handles.output = hObject;
set(handles.axes1,'Visible','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes jietiao wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = jietiao_OutputFcn(hObject, eventdata, handles) 
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
fs=2000;                            %采样频率
dt=1/fs;                             %采样间隔
f1=5;
f2=90;                             %两个载波信号的频率
a=[1 0 0 1 1 0 0 1 0 0];                 %产生原始数字随机信号
g1=a;   %原始信号1
g2=~a;  %原始信号2                    %将原始数字信号反转与g1反向
g11=(ones(1,2000))'*g1;              %进行抽样
g1a=g11(:)';
g21=(ones(1,2000))'*g2;
g2a=g21(:)';
t=0:dt:10-dt;                         %在0~10-dt之间取值，取值间隔为dt
t1=length(t);
fsk1=g1a.*cos(2*pi*f1.*t);             %得到频率为f1的fsk1已调信号
fsk2=g2a.*cos(2*pi*f2.*t);             %得到频率为f2的fsk2已调信号
fsk=fsk1+fsk2;
no=0.01*randn(1,t1);                 %产生的随机噪声
sn=fsk+no;
b1=fir1(101,[3/1000 7/1000]);
b2=fir1(101,[88/1000 92/1000]);       %设置带通滤波器的参数
H1=filter(b1,1,sn);
H2=filter(b2,1,sn);  
sw1=H1.*H1;                         %经过相乘器1的信号
sw2=H2.*H2;                         %经过相乘器2的信号%经过带通滤波器后的信号
bn=fir1(101,92/1000);          %设置低通滤波器的参数
st1=filter(bn,1,sw1);
st2=filter(bn,1,sw2);
h1=subplot(2,1,1);
plot(t,H1);                            %经过带通滤波器1的波形
title('经过带通滤波器f1后的波形')
ylabel('幅度')
h2=subplot(2,1,2);                   
plot(t,H2);                            %经过带通滤波器2的波形
title('经过带通滤波器f2后的波形')
axis([0 10 -1.5 1.5]);
ylabel('幅度')
xlabel('t')
handles.sn=sn;
handles.t=t;
handles.g1a=g1a;
handles.sw1=sw1;
handles.sw2=sw2;
handles.H1=H1;
handles.H2=H2;
handles.st1=st1;
handles.st2=st2;
handles.h1=h1;
handles.h2=h2;
handles.t=t;
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
        H1=handles.H1;
        H2=handles.H2;
        h1=subplot(2,1,1);
        plot(t,H1);                            %经过带通滤波器1的波形
        title('经过带通滤波器f1后的波形')
        ylabel('幅度')
        h2=subplot(2,1,2);                   
        plot(t,H2);                            %经过带通滤波器2的波形
        title('经过带通滤波器f2后的波形')
        axis([0 10 -1.5 1.5]);
        ylabel('幅度')
        xlabel('t');
        handles.h1=h1;
        handles.h2=h2;
    case 'radiobutton2'
        sw1=handles.sw1;
        sw2=handles.sw2;
        h1=subplot(2,1,1);
        plot(t,sw1);                          
        title('经过相乘器h1后的波形')
        ylabel('幅度')
        h2=subplot(2,1,2);
        plot(t,sw2);
        title('经过相乘器h2后的波形')
        ylabel('幅度')
        xlabel('t');
        handles.h1=h1;
        handles.h2=h2;
    case 'radiobutton3'
        st1=handles.st1;
        st2=handles.st2;
        h1=subplot(2,1,1);
        plot(t,st1);                            %经过低通滤波器1的波形
        title('经过低通滤波器sw1后的波形')
        ylabel('幅度')
        h2=subplot(2,1,2);
        plot(t,st2);                            %经过低通滤波器1的波形   
        title('经过低通滤波器sw2后的波形')
        ylabel('幅度')
        xlabel('t');
        handles.h1=h1;
        handles.h2=h2;
    case 'radiobutton4'
        st1=handles.st1;
        st2=handles.st2;
        for i=1:length(t)
            if(st1(i)>=st2(i))
                st(i)=1;
            else st(i)=0;
            end
        end
        g1a=handles.g1a;
        h1=subplot(2,1,1);
        plot(t,st);                             %经过抽样判决器后解调出的波形
        title('经过抽样判决器后解调出的波形')
        axis([0 10 -0.2 1.2]);
        ylabel('幅度')
        h2=subplot(2,1,2);
        plot(t,g1a);                           %原始的数字序列波形
        title('原始数字序列的波形')
        axis([0 10 -0.2 1.2]);
        ylabel('幅度');
        xlabel('t');
        handles.h1=h1;
        handles.h2=h2;
end
guidata(hObject,handles);

