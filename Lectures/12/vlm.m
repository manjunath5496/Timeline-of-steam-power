function varargout = VLM(varargin)
% ================================= Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLM_OpeningFcn, ...
                   'gui_OutputFcn',  @VLM_OutputFcn, ...
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
% =================================== End initialization code - DO NOT EDIT
function VLM_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = VLM_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% ============================================================== Run Button
function Run_Callback(hObject, eventdata, handles)
global U c N CL Alpha TOC;
U = 1;      c = 1;          % Free Stream Velocity and Chord Length
N = str2double(get(handles.N,'String'));
CL = str2double(get(handles.CL,'String'));
Alpha = str2double(get(handles.Alpha,'String'));
TOC = str2double(get(handles.TOC,'String'));
[xt,CPU, CPL, CLNum] = Main;
% ================================================================ Plotting
set(handles.CLNum,'String',num2str(CLNum));
axes(handles.PressureCoeff);
plot(xt,CPU,'-r','LineWidth',2);  hold on;
plot(xt,CPL,'-b','LineWidth',2);  hold off;
grid on;    xlim([0 1]);    xlabel('X/C');  ylabel('-Cp');
legend('Upper Surface','Lower Surface');
clear;
% ============================================================ Print Button
function Print_Callback(hObject, eventdata, handles)
printpreview;
% ============================================================= Exit Button
function Exit_Callback(hObject, eventdata, handles)
clc;    clear;      close all;
% ================================================ Editable Text Components
function N_Callback(hObject, eventdata, handles)        % Number of Panels
function N_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'),...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function CL_Callback(hObject, eventdata, handles)       % Ideal Lift Coeff
function CL_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'),...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Alpha_Callback(hObject, eventdata, handles)    % Angle of Attack
function Alpha_CreateFcn(hObject, eventdata, handles)   
if ispc && isequal(get(hObject,'BackgroundColor'),...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function TOC_Callback(hObject, eventdata, handles)  % Thickness/Chord Ratio
function TOC_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'),...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end