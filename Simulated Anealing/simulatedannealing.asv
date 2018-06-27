function varargout = simulatedannealing(varargin)
% SIMULATEDANNEALING M-file for simulatedannealing.fig
%      SIMULATEDANNEALING, by itself, creates a new SIMULATEDANNEALING or raises the existing
%      singleton*.
%
%      H = SIMULATEDANNEALING returns the handle to a new SIMULATEDANNEALING or the handle to
%      the existing singleton*.
%
%      SIMULATEDANNEALING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATEDANNEALING.M with the given input arguments.
%
%      SIMULATEDANNEALING('Property','Value',...) creates a new SIMULATEDANNEALING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simulatedannealing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simulatedannealing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simulatedannealing

% Last Modified by GUIDE v2.5 05-Apr-2009 02:02:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simulatedannealing_OpeningFcn, ...
                   'gui_OutputFcn',  @simulatedannealing_OutputFcn, ...
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


% --- Executes just before simulatedannealing is made visible.
function simulatedannealing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simulatedannealing (see VARARGIN)

%set(handles.init_temperatur_input,'String','input Tmax')
%s = sprintf('Cooling Rate : %0.3f',get(handles.set_cooling_rate,'Value'));
%set(handles.cooling_rate_disp, 'String', s);
% Choose default command line output for simulatedannealing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simulatedannealing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simulatedannealing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





function init_temperatur_input_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of init_temperatur_input as text
%        str2double(get(hObject,'String')) returns contents of init_temperatur_input as a double
s = str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','10000')
end
if s < 100 | s > 10000000
    set(hObject,'String','10000')
end

% --- Executes during object creation, after setting all properties.
function init_temperatur_input_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_temperatur_input_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of min_temperatur_input as text
%        str2double(get(hObject,'String')) returns contents of min_temperatur_input as a double
s=str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','1');
end
if s < 0 | S > 100
    set(hObject,'String','1');
end

% --- Executes during object creation, after setting all properties.
function min_temperatur_input_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_iterations_input_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of max_iterations_input as text
%        str2double(get(hObject,'String')) returns contents of max_iterations_input as a double
s = str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','500')
end
if s < 100 | s > 10000
    set(hObject,'String','500')
end


% --- Executes during object creation, after setting all properties.
function max_iterations_input_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in set_init_solution.
function set_init_solution_Callback(hObject, eventdata, handles)

% Hints: contents = get(hObject,'String') returns set_init_solution contents as cell array
%        contents{get(hObject,'Value')} returns selected item from set_init_solution


% --- Executes during object creation, after setting all properties.
function set_init_solution_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function set_cooling_rate_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
s = sprintf('Cooling Rate : %0.3f',get(hObject,'Value'));
set(handles.cooling_rate_disp, 'String', s);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function set_cooling_rate_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function cooling_rate_disp_CreateFcn(hObject, eventdata, handles)


% --- Executes when entered data in editable cell(s) in Parameter.
function Parameter_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to Parameter (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
   
% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)

% get init_solution_selection
Pm = get(handles.Parameterzahl, 'Value');
initsolution = get(handles.Parameter, 'Data');
initsolution = str2double(initsolution);
initsolution = initsolution(1:Pm,1);   %nach dem Anzahl der Parameter veraedern

% get init_temperatur
inittemperatur = get(handles.init_temperatur_input,'String');
inittemperatur = str2double(inittemperatur);

% get cooling_rate
coolingrate = get(handles.set_cooling_rate,'Value');

% get max_iterations
maxiterations = get(handles.max_iterations_input,'String');
maxiterations = str2double(maxiterations);

% get min_temperatur
mintemperature = get(handles.min_temperatur_input,'String');
mintemperature = str2double(mintemperature);
if isnan(initsolution)
    %disp('falsch input');
    titledisp=sprintf('**falsch input check Parameter input**' );
    text(.2,.5,titledisp,'fontweight','bold','color','red');
else     
    axes(handles.axes1)
    [Xopt Xcurrent] = Sahaupt( inittemperatur ,coolingrate,...
      maxiterations,initsolution,mintemperature);
    set(handles.axes1,'XMinorTick','on')
end

guidata(hObject, handles);

% --- Executes on button press in evolution.
function evolution_Callback(hObject, eventdata, handles)
% hObject    handle to evolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% get init_solution_selection
Pme = get(handles.Parameterzahl, 'Value');
initsolution = get(handles.Parameter, 'Data');
initsolution = str2double(initsolution);
initsolution = initsolution(1:Pme,1);   %nach dem Anzahl der Parameter veraedern


% get init_temperatur
inittemperatur = get(handles.init_temperatur_input,'String');
inittemperatur = str2double(inittemperatur);

% get cooling_rate
coolingrate = get(handles.set_cooling_rate,'Value');

% get max_iterations
maxiterations = get(handles.max_iterations_input,'String');
maxiterations = str2double(maxiterations);

% get min_temperatur
mintemperature = get(handles.min_temperatur_input,'String');
mintemperature = str2double(mintemperature);

% plot
if isnan(initsolution)
    %disp('falsch input');
    titledisp=sprintf('**falsch input check Parameter input**' );
    text(.2,.5,titledisp,'fontweight','bold','color','red');
else     
    axes(handles.axes2)
    Evolution( inittemperatur ,coolingrate,...
    maxiterations,initsolution,mintemperature);
    set(handles.axes2,'XMinorTick','on')
end

guidata(hObject, handles);




% --- Executes on selection change in Parameterzahl.
function Parameterzahl_Callback(hObject, eventdata, handles)
% hObject    handle to Parameterzahl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Parameterzahl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Parameterzahl


% --- Executes during object creation, after setting all properties.
function Parameterzahl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Parameterzahl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step1_Callback(hObject, eventdata, handles)
% hObject    handle to Step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step1 as text
%        str2double(get(hObject,'String')) returns contents of Step1 as a double


% --- Executes during object creation, after setting all properties.
function Step1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step2_Callback(hObject, eventdata, handles)
% hObject    handle to Step2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step2 as text
%        str2double(get(hObject,'String')) returns contents of Step2 as a double


% --- Executes during object creation, after setting all properties.
function Step2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotmax.
function plotmax_Callback(hObject, eventdata, handles)
% hObject    handle to plotmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% get init_solution_selection
Pm = get(handles.Parameterzahl, 'Value');
initsolution = get(handles.Parameter, 'Data');
initsolution = str2double(initsolution);
initsolution = initsolution(1:Pm,1);   %nach dem Anzahl der Parameter veraedern

% get init_temperatur
inittemperatur = get(handles.init_temperatur_input,'String');
inittemperatur = str2double(inittemperatur);

% get cooling_rate
coolingrate = get(handles.set_cooling_rate,'Value');

% get max_iterations
maxiterations = get(handles.max_iterations_input,'String');
maxiterations = str2double(maxiterations);

% get min_temperatur
mintemperature = get(handles.min_temperatur_input,'String');
mintemperature = str2double(mintemperature);
if isnan(initsolution)
    %disp('falsch input');
    titledisp=sprintf('**falsch input check Parameter input**' );
    text(.2,.5,titledisp,'fontweight','bold','color','red');
else     
    axes(handles.axes1)
    [Xopt Xcurrent] = Sahauptmax( inittemperatur ,coolingrate,...
      maxiterations,initsolution,mintemperature);
    set(handles.axes1,'XMinorTick','on')
end

guidata(hObject, handles);

% --- Executes on button press in Evolutionmax.
function Evolutionmax_Callback(hObject, eventdata, handles)
% hObject    handle to Evolutionmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% get init_solution_selection
Pme = get(handles.Parameterzahl, 'Value');
initsolution = get(handles.Parameter, 'Data');
initsolution = str2double(initsolution);
initsolution = initsolution(1:Pme,1);   %nach dem Anzahl der Parameter veraedern


% get init_temperatur
inittemperatur = get(handles.init_temperatur_input,'String');
inittemperatur = str2double(inittemperatur);

% get cooling_rate
coolingrate = get(handles.set_cooling_rate,'Value');

% get max_iterations
maxiterations = get(handles.max_iterations_input,'String');
maxiterations = str2double(maxiterations);

% get min_temperatur
mintemperature = get(handles.min_temperatur_input,'String');
mintemperature = str2double(mintemperature);

% plot
if isnan(initsolution)
    %disp('falsch input');
    titledisp=sprintf('**falsch input check Parameter input**' );
    text(.2,.5,titledisp,'fontweight','bold','color','red');
else     
    axes(handles.axes2)
    Evolutionmax( inittemperatur ,coolingrate,...
    maxiterations,initsolution,mintemperature);
    set(handles.axes2,'XMinorTick','on')
end

guidata(hObject, handles);

