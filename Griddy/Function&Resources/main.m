function varargout = main(varargin)
% MAIN MATLAB code for main.fig
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

% Last Modified by GUIDE v2.5 15-Dec-2019 04:04:41

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
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;
axes(handles.axes3)
matlabImage = imread('Main.png');
image(matlabImage)
axis off
axis image
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
% clear output,outputFor;
setOfInp1 = [handles.e1,handles.e2,handles.e3,handles.e4;handles.e5,handles.e6,handles.e7,handles.e8;handles.e9,handles.e10,handles.e11,handles.e12;handles.e13,handles.e14,handles.e15,handles.e16];
setOfInp2 = [handles.e1_2,handles.e2_2,handles.e3_2,handles.e4_2;handles.e5_2,handles.e6_2,handles.e7_2,handles.e8_2;handles.e9_2,handles.e10_2,handles.e11_2,handles.e12_2;handles.e13_2,handles.e14_2,handles.e15_2,handles.e16_2];
setOfOut = [handles.out1,handles.out2,handles.out3,handles.out4;handles.out5,handles.out6,handles.out7,handles.out8;handles.out9,handles.out10,handles.out11,handles.out12;handles.out13,handles.out14,handles.out15,handles.out16];
size = 0;
switch get(handles.popupmenu4,'Value')
        case 1
            size = 0;
        case 2
            size = 2;
        case 3
            size = 3;
        otherwise
            size = 4;
end
    for i = 1:4
        for j=1:4
            if mod(i+j,4) <= size
                set(setOfOut(i,j),'Visible',true);
            else
                set(setOfOut(i,j),'Visible',false);
            end
        end
    end
    inp1 = zeros(size);
    inp2 = zeros(size);
    for i = 1:size
        for j = 1:size
            if get(setOfInp2(i,j),'String') ~= ""  
                inp2(i,j) = str2double(get(setOfInp2(i,j),'String'));
            else
                inp2(i,j) = 0;
            end
            if get(setOfInp1(i,j),'String') ~= "" 
                inp1(i,j) = str2double(get(setOfInp1(i,j),'String'));
            else
                inp1(i,j) = 0;
            end
        end
    end
    if get(handles.popupmenu3,'Value') == 2 %Inverse
        tic
        outputFor = inv_for(inp1);
        foTime = toc;
        tic
        output = inv1_unb(inp1,eye(size));
        sparTime = toc;
    elseif get(handles.popupmenu3,'Value') == 3 %Addition
        tic
        outputFor = additionFor(inp1,inp2);
        foTime = toc;
        tic
        output = Add_unb(inp1,inp2);
        sparTime = toc;
    elseif get(handles.popupmenu3,'Value') == 4 %Subtraction 
        tic  
        outputFor = subtractionFor(inp1,inp2);
        foTime = toc;
        tic
        output = Lob_unb(inp1,inp2);
        sparTime = toc;
    elseif get(handles.popupmenu3,'Value') == 5 %Multiplication
        tic
        outputFor = productFor(inp1,inp2,zeros(size));
        foTime = toc;
        tic
        output = Multi_unb(inp1,inp2,zeros(size));
        sparTime = toc;
    end
    disp('output using for loop =');
    disp(outputFor);
    disp('output using spark =');
    disp(output);
    max = 0;
    font_size = 0;
    for i = 1:size
        for j =1:size
           if output(i,j) > max
               max = output(i,j);
           end
        end
    end
    if max >= 100000
        font_size = 8;
    elseif max>=10000
        font_size = 8;
    elseif max >=1000
        font_size = 10;
    elseif max >= 100
        font_size = 14;
    else
        font_size = 16;
    end
    for i = 1:4
       for j= 1:4
           if i<=size && j<=size
               set(setOfOut(i,j),'Visible',true);
               if get(handles.popupmenu3,'Value') == 2
                   font_size = 8;
               end
               set(setOfOut(i,j),'FontSize',font_size);
               if output(i,j) >1000000
                    set(setOfOut(i,j),'String','Inf');
               else
                    set(setOfOut(i,j),'String',round(outputFor(i,j),4));
               end
           else
               set(setOfOut(i,j),'Visible',false);               
           end
       end
    end
    set(handles.forTime,'String',double(foTime));
    set(handles.sparkTime,'String',double(sparTime));
% --- Executes on selection change in popupmenu1.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
% size = 0;
% setOfOut = [handles.out1,handles.out2,handles.out3,handles.out4;handles.out5,handles.out6,handles.out7,handles.out8;handles.out9,handles.out10,handles.out11,handles.out12;handles.out13,handles.out14,handles.out15,handles.out16];
% switch get(handles.popupmenu4,'Value')
%         case 1
%             size = 0;
%         case 2
%             size = 2;
%         case 3
%             size = 3;
%         otherwise
%             size = 4;
% end
set(handles.r1,'Visible',false);
set(handles.r2,'Visible',false);
set(handles.r3,'Visible',false);
set(handles.r4,'Visible',false);
        set(handles.out1,'Visible',false);
        set(handles.out2,'Visible',false);
        set(handles.out3,'Visible',false);
        set(handles.out4,'Visible',false);
        set(handles.out5,'Visible',false);
        set(handles.out6,'Visible',false);
        set(handles.out7,'Visible',false);
        set(handles.out8,'Visible',false);
        set(handles.out9,'Visible',false);
        set(handles.out10,'Visible',false);
        set(handles.out11,'Visible',false);
        set(handles.out12,'Visible',false);
        set(handles.out13,'Visible',false);
        set(handles.out14,'Visible',false);
        set(handles.out15,'Visible',false);
        set(handles.out16,'Visible',false);
set(handles.popupmenu4,'Value',1)
set(handles.popupmenu1,'Value',1)
set(handles.e1,'String','')
set(handles.e2,'String','')
set(handles.e3,'String','')
set(handles.e4,'String','')
set(handles.e5,'String','')
set(handles.e6,'String','')
set(handles.e7,'String','')
set(handles.e8,'String','')
set(handles.e9,'String','')
set(handles.e10,'String','')
set(handles.e11,'String','')
set(handles.e12,'String','')
set(handles.e13,'String','')
set(handles.e14,'String','')
set(handles.e15,'String','')
set(handles.e16,'String','')
set(handles.e1_2,'String','')
set(handles.e2_2,'String','')
set(handles.e3_2,'String','')
set(handles.e4_2,'String','')
set(handles.e5_2,'String','')
set(handles.e6_2,'String','')
set(handles.e7_2,'String','')
set(handles.e8_2,'String','')
set(handles.e9_2,'String','')
set(handles.e10_2,'String','')
set(handles.e11_2,'String','')
set(handles.e12_2,'String','')
set(handles.e13_2,'String','')
set(handles.e14_2,'String','')
set(handles.e15_2,'String','')
set(handles.e16_2,'String','')
set(handles.out1,'String','')
set(handles.out2,'String','')
set(handles.out3,'String','')
set(handles.out4,'String','')
set(handles.out5,'String','')
set(handles.out6,'String','')
set(handles.out7,'String','')
set(handles.out8,'String','')
set(handles.out9,'String','')
set(handles.out10,'String','')
set(handles.out11,'String','')
set(handles.out12,'String','')
set(handles.out13,'String','')
set(handles.out14,'String','')
set(handles.out15,'String','')
set(handles.out16,'String','')
set(handles.popupmenu1,'Value',1)
        set(handles.e1,'Visible',false);
        set(handles.e2,'Visible',false);
        set(handles.e3,'Visible',false);
        set(handles.e4,'Visible',false);
        set(handles.e5,'Visible',false);
        set(handles.e6,'Visible',false);
        set(handles.e7,'Visible',false);
        set(handles.e8,'Visible',false);
        set(handles.e9,'Visible',false);
        set(handles.e10,'Visible',false);
        set(handles.e11,'Visible',false);
        set(handles.e12,'Visible',false);
        set(handles.e13,'Visible',false);
        set(handles.e14,'Visible',false);
        set(handles.e15,'Visible',false);
        set(handles.e16,'Visible',false);
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
if get(handles.popupmenu3,'Value')==1
        set(handles.e1,'Visible',false);
        set(handles.e2,'Visible',false);
        set(handles.e3,'Visible',false);
        set(handles.e4,'Visible',false);
        set(handles.e5,'Visible',false);
        set(handles.e6,'Visible',false);
        set(handles.e7,'Visible',false);
        set(handles.e8,'Visible',false);
        set(handles.e9,'Visible',false);
        set(handles.e10,'Visible',false);
        set(handles.e11,'Visible',false);
        set(handles.e12,'Visible',false);
        set(handles.e13,'Visible',false);
        set(handles.e14,'Visible',false);
        set(handles.e15,'Visible',false);
        set(handles.e16,'Visible',false);
        set(handles.popupmenu4,'Visible',false);
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
else
        set(handles.popupmenu4,'Visible',true);
end
    

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,Size)) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
% setOfInp1 = [handles.e1,handles.e2,handles.e3,handles.e4;handles.e5,handles.e6,handles.e7,handles.e8;handles.e9,handles.e10,handles.e11,handles.e12;handles.e13,handles.e14,handles.e15,handles.e16];
% setOfInp2 = [handles.e1_2,handles.e2_2,handles.e3_2,handles.e4_2;handles.e5_2,handles.e6_2,handles.e7_2,handles.e8_2;handles.e9_2,handles.e10_2,handles.e11_2,handles.e12_2;handles.e13_2,handles.e14_2,handles.e15_2,handles.e16_2];
if get(handles.popupmenu1,'Value')==3
    set(handles.r1,'Visible',true);
    set(handles.r2,'Visible',true);
    set(handles.r3,'Visible',true);
    set(handles.r4,'Visible',true);
    set(handles.r2,'String','');
    set(handles.r3,'String','');
else
    set(handles.r1,'Visible',false);
    set(handles.r2,'Visible',false);
    set(handles.r3,'Visible',false);
    set(handles.r4,'Visible',false);
end
        set(handles.out1,'Visible',false);
        set(handles.out2,'Visible',false);
        set(handles.out3,'Visible',false);
        set(handles.out4,'Visible',false);
        set(handles.out5,'Visible',false);
        set(handles.out6,'Visible',false);
        set(handles.out7,'Visible',false);
        set(handles.out8,'Visible',false);
        set(handles.out9,'Visible',false);
        set(handles.out10,'Visible',false);
        set(handles.out11,'Visible',false);
        set(handles.out12,'Visible',false);
        set(handles.out13,'Visible',false);
        set(handles.out14,'Visible',false);
        set(handles.out15,'Visible',false);
        set(handles.out16,'Visible',false);
        set(handles.e1,'Visible',false);
        set(handles.e2,'Visible',false);
        set(handles.e3,'Visible',false);
        set(handles.e4,'Visible',false);
        set(handles.e5,'Visible',false);
        set(handles.e6,'Visible',false);
        set(handles.e7,'Visible',false);
        set(handles.e8,'Visible',false);
        set(handles.e9,'Visible',false);
        set(handles.e10,'Visible',false);
        set(handles.e11,'Visible',false);
        set(handles.e12,'Visible',false);
        set(handles.e13,'Visible',false);
        set(handles.e14,'Visible',false);
        set(handles.e15,'Visible',false);
        set(handles.e16,'Visible',false);
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
if get(handles.popupmenu4,'Value')==1
        set(handles.e1,'Visible',false);
        set(handles.e2,'Visible',false);
        set(handles.e3,'Visible',false);
        set(handles.e4,'Visible',false);
        set(handles.e5,'Visible',false);
        set(handles.e6,'Visible',false);
        set(handles.e7,'Visible',false);
        set(handles.e8,'Visible',false);
        set(handles.e9,'Visible',false);
        set(handles.e10,'Visible',false);
        set(handles.e11,'Visible',false);
        set(handles.e12,'Visible',false);
        set(handles.e13,'Visible',false);
        set(handles.e14,'Visible',false);
        set(handles.e15,'Visible',false);
        set(handles.e16,'Visible',false);
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
else
        set(handles.popupmenu4,'Visible',true);
end
set(handles.popupmenu4,'Value',1)
set(handles.e1,'String','');
set(handles.e2,'String','');
set(handles.e3,'String','');
set(handles.e4,'String','');
set(handles.e5,'String','');
set(handles.e6,'String','');
set(handles.e7,'String','');
set(handles.e8,'String','');
set(handles.e9,'String','');
set(handles.e10,'String','');
set(handles.e11,'String','');
set(handles.e12,'String','');
set(handles.e13,'String','');
set(handles.e14,'String','');
set(handles.e15,'String','');
set(handles.e16,'String','');
set(handles.e1_2,'String','');
set(handles.e2_2,'String','');
set(handles.e3_2,'String','');
set(handles.e4_2,'String','');
set(handles.e5_2,'String','');
set(handles.e6_2,'String','');
set(handles.e7_2,'String','');
set(handles.e8_2,'String','');
set(handles.e9_2,'String','');
set(handles.e10_2,'String','');
set(handles.e11_2,'String','');
set(handles.e12_2,'String','');
set(handles.e13_2,'String','');
set(handles.e14_2,'String','');
set(handles.e15_2,'String','');
set(handles.e16_2,'String','');
set(handles.out1,'String','');
set(handles.out2,'String','');
set(handles.out3,'String','');
set(handles.out4,'String','');
set(handles.out5,'String','');
set(handles.out6,'String','');
set(handles.out7,'String','');
set(handles.out8,'String','');
set(handles.out9,'String','');
set(handles.out10,'String','');
set(handles.out11,'String','');
set(handles.out12,'String','');
set(handles.out13,'String','');
set(handles.out14,'String','');
set(handles.out15,'String','');
set(handles.out16,'String','');
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
set(handles.out1,'Visible',false);
        set(handles.out2,'Visible',false);
        set(handles.out3,'Visible',false);
        set(handles.out4,'Visible',false);
        set(handles.out5,'Visible',false);
        set(handles.out6,'Visible',false);
        set(handles.out7,'Visible',false);
        set(handles.out8,'Visible',false);
        set(handles.out9,'Visible',false);
        set(handles.out10,'Visible',false);
        set(handles.out11,'Visible',false);
        set(handles.out12,'Visible',false);
        set(handles.out13,'Visible',false);
        set(handles.out14,'Visible',false);
        set(handles.out15,'Visible',false);
        set(handles.out16,'Visible',false);
set(handles.e1,'String','')
set(handles.e2,'String','')
set(handles.e3,'String','')
set(handles.e4,'String','')
set(handles.e5,'String','')
set(handles.e6,'String','')
set(handles.e7,'String','')
set(handles.e8,'String','')
set(handles.e9,'String','')
set(handles.e10,'String','')
set(handles.e11,'String','')
set(handles.e12,'String','')
set(handles.e13,'String','')
set(handles.e14,'String','')
set(handles.e15,'String','')
set(handles.e16,'String','')
set(handles.e1_2,'String','')
set(handles.e2_2,'String','')
set(handles.e3_2,'String','')
set(handles.e4_2,'String','')
set(handles.e5_2,'String','')
set(handles.e6_2,'String','')
set(handles.e7_2,'String','')
set(handles.e8_2,'String','')
set(handles.e9_2,'String','')
set(handles.e10_2,'String','')
set(handles.e11_2,'String','')
set(handles.e12_2,'String','')
set(handles.e13_2,'String','')
set(handles.e14_2,'String','')
set(handles.e15_2,'String','')
set(handles.e16_2,'String','')
set(handles.out1,'String','')
set(handles.out2,'String','')
set(handles.out3,'String','')
set(handles.out4,'String','')
set(handles.out5,'String','')
set(handles.out6,'String','')
set(handles.out7,'String','')
set(handles.out8,'String','')
set(handles.out9,'String','')
set(handles.out10,'String','')
set(handles.out11,'String','')
set(handles.out12,'String','')
set(handles.out13,'String','')
set(handles.out14,'String','')
set(handles.out15,'String','')
set(handles.out16,'String','')
setOfInp1 = [handles.e1,handles.e2,handles.e3,handles.e4;handles.e5,handles.e6,handles.e7,handles.e8;handles.e9,handles.e10,handles.e11,handles.e12;handles.e13,handles.e14,handles.e15,handles.e16];
setOfInp2 = [handles.e1_2,handles.e2_2,handles.e3_2,handles.e4_2;handles.e5_2,handles.e6_2,handles.e7_2,handles.e8_2;handles.e9_2,handles.e10_2,handles.e11_2,handles.e12_2;handles.e13_2,handles.e14_2,handles.e15_2,handles.e16_2];
size= 0;
switch get(handles.popupmenu4,'Value')
    case 2
        size = 2;
        set(handles.e1,'Visible',true);
        set(handles.e2,'Visible',true);
        set(handles.e3,'Visible',false);
        set(handles.e4,'Visible',false);
        set(handles.e5,'Visible',true);
        set(handles.e6,'Visible',true);
        set(handles.e7,'Visible',false);
        set(handles.e8,'Visible',false);
        set(handles.e9,'Visible',false);
        set(handles.e10,'Visible',false);
        set(handles.e11,'Visible',false);
        set(handles.e12,'Visible',false);
        set(handles.e13,'Visible',false);
        set(handles.e14,'Visible',false);
        set(handles.e15,'Visible',false);
        set(handles.e16,'Visible',false);
        if get(handles.popupmenu3,'Value')>2
        set(handles.e1_2,'Visible',true);
        set(handles.e2_2,'Visible',true);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',true);
        set(handles.e6_2,'Visible',true);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
        else
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
        end
    case 3
        size = 3;
        set(handles.e1,'Visible',true);
        set(handles.e2,'Visible',true);
        set(handles.e3,'Visible',true);
        set(handles.e4,'Visible',false);
        set(handles.e5,'Visible',true);
        set(handles.e6,'Visible',true);
        set(handles.e7,'Visible',true);
        set(handles.e8,'Visible',false);
        set(handles.e9,'Visible',true);
        set(handles.e10,'Visible',true);
        set(handles.e11,'Visible',true);
        set(handles.e12,'Visible',false);
        set(handles.e13,'Visible',false);
        set(handles.e14,'Visible',false);
        set(handles.e15,'Visible',false);
        set(handles.e16,'Visible',false);
        if get(handles.popupmenu3,'Value')>2
        set(handles.e1_2,'Visible',true);
        set(handles.e2_2,'Visible',true);
        set(handles.e3_2,'Visible',true);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',true);
        set(handles.e6_2,'Visible',true);
        set(handles.e7_2,'Visible',true);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',true);
        set(handles.e10_2,'Visible',true);
        set(handles.e11_2,'Visible',true);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
        else
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
        end
    case 4
        size = 4;
        set(handles.e1,'Visible',true);
        set(handles.e2,'Visible',true);
        set(handles.e3,'Visible',true);
        set(handles.e4,'Visible',true);
        set(handles.e5,'Visible',true);
        set(handles.e6,'Visible',true);
        set(handles.e7,'Visible',true);
        set(handles.e8,'Visible',true);
        set(handles.e9,'Visible',true);
        set(handles.e10,'Visible',true);
        set(handles.e11,'Visible',true);
        set(handles.e12,'Visible',true);
        set(handles.e13,'Visible',true);
        set(handles.e14,'Visible',true);
        set(handles.e15,'Visible',true);
        set(handles.e16,'Visible',true);
        if get(handles.popupmenu3,'Value')>2
        set(handles.e1_2,'Visible',true);
        set(handles.e2_2,'Visible',true);
        set(handles.e3_2,'Visible',true);
        set(handles.e4_2,'Visible',true);
        set(handles.e5_2,'Visible',true);
        set(handles.e6_2,'Visible',true);
        set(handles.e7_2,'Visible',true);
        set(handles.e8_2,'Visible',true);
        set(handles.e9_2,'Visible',true);
        set(handles.e10_2,'Visible',true);
        set(handles.e11_2,'Visible',true);
        set(handles.e12_2,'Visible',true);
        set(handles.e13_2,'Visible',true);
        set(handles.e14_2,'Visible',true);
        set(handles.e15_2,'Visible',true);
        set(handles.e16_2,'Visible',true);
        else
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
        end
    otherwise
        set(handles.e1,'Visible',false);
        set(handles.e2,'Visible',false);
        set(handles.e3,'Visible',false);
        set(handles.e4,'Visible',false);
        set(handles.e5,'Visible',false);
        set(handles.e6,'Visible',false);
        set(handles.e7,'Visible',false);
        set(handles.e8,'Visible',false);
        set(handles.e9,'Visible',false);
        set(handles.e10,'Visible',false);
        set(handles.e11,'Visible',false);
        set(handles.e12,'Visible',false);
        set(handles.e13,'Visible',false);
        set(handles.e14,'Visible',false);
        set(handles.e15,'Visible',false);
        set(handles.e16,'Visible',false);
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);
end
mode = 'inactive';
if get(handles.popupmenu1,'Value')==2  %Type
    mode = 'on';
else
    mode = 'inactive';
end
if get(handles.popupmenu1,'Value')==4 % Import
%     f = msgbox();
    a=0;
    if get(handles.popupmenu3,'Value') == 2
        a = size;
    else
        a = 2*size;
    end
    input = zeros(a,size);
    [filename, pathname] = uigetfile({'*.txt'},'File Selector');
    if ~ischar(filename)
         return; 
    end
    file = fullfile(pathname, filename);
    [fid, msg] = fopen(file, 'r');
    if fid == -1
        error(msg);
    end
    input1 =zeros(size);
    input2 = zeros(size);
    i=1;
    while ~feof(fid)
        char = fgets(fid);
        char = strsplit(char,{' ','\n','\r'});
        for j = 1:size
           if j<= length(char)
               a=str2double(char(j));
               if char(j) == ""
                   a = 0;
               end
               if i<= size
                   input1(i,j) = a;
               elseif get(handles.popupmenu3,'Value') ~= 2
                   input2(i-size,j) = a;
               end
           end
        end
        i=i+1;
    end
%     temp = fscanf(fid,'%f',[size a]);
    fclose(fid);
    disp(input2);
%     input = input + temp';
%     input1 = input(1:size,:);
%     if get(handles.popupmenu3,'Value') = 2
%         input2 = input(size+1:size*2,:);
%     end
end
for i = 1:4
    for j = 1:4
        set(setOfInp1(i,j),'Enable',mode);
        set(setOfInp2(i,j),'Enable',mode);
        if get(handles.popupmenu1,'Value')==3  %Random
            if get(handles.r2,'String') == ""
                min = 0;
            else
                min = str2double(get(handles.r2,'String'));
            end
            if get(handles.r3,'String') == ""
                max = 0;
            else
                max = str2double(get(handles.r3,'String'));
            end
            set(setOfInp1(i,j),'String',num2str(randi(max-min+1,1)+min-1));
            set(setOfInp2(i,j),'String',num2str(randi(max-min+1,1)+min-1));            
        elseif get(handles.popupmenu1,'Value') == 4 && i<=size && j<=size
            set(setOfInp1(i,j),'String',num2str(input1(i,j)));
            if get(handles.popupmenu3,'Value') ~= 2
                set(setOfInp2(i,j),'String',num2str(input2(i,j))); 
            end
        end
    end
end
% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function e1_Callback(hObject, eventdata, handles)
% hObject    handle to e1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e1 as text
%        str2double(get(hObject,'String')) returns contents of e1 as a double


% --- Executes during object creation, after setting all properties.
function e1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e2_Callback(hObject, eventdata, handles)
% hObject    handle to e2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e2 as text
%        str2double(get(hObject,'String')) returns contents of e2 as a double


% --- Executes during object creation, after setting all properties.
function e2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e3_Callback(hObject, eventdata, handles)
% hObject    handle to e3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e3 as text
%        str2double(get(hObject,'String')) returns contents of e3 as a double


% --- Executes during object creation, after setting all properties.
function e3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e4_Callback(hObject, eventdata, handles)
% hObject    handle to e4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e4 as text
%        str2double(get(hObject,'String')) returns contents of e4 as a double


% --- Executes during object creation, after setting all properties.
function e4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e5_Callback(hObject, eventdata, handles)
% hObject    handle to e5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e5 as text
%        str2double(get(hObject,'String')) returns contents of e5 as a double


% --- Executes during object creation, after setting all properties.
function e5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e6_Callback(hObject, eventdata, handles)
% hObject    handle to e6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e6 as text
%        str2double(get(hObject,'String')) returns contents of e6 as a double


% --- Executes during object creation, after setting all properties.
function e6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e7_Callback(hObject, eventdata, handles)
% hObject    handle to e7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e7 as text
%        str2double(get(hObject,'String')) returns contents of e7 as a double


% --- Executes during object creation, after setting all properties.
function e7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e8_Callback(hObject, eventdata, handles)
% hObject    handle to e8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e8 as text
%        str2double(get(hObject,'String')) returns contents of e8 as a double


% --- Executes during object creation, after setting all properties.
function e8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e9_Callback(hObject, eventdata, handles)
% hObject    handle to e9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e9 as text
%        str2double(get(hObject,'String')) returns contents of e9 as a double


% --- Executes during object creation, after setting all properties.
function e9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e10_Callback(hObject, eventdata, handles)
% hObject    handle to e10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e10 as text
%        str2double(get(hObject,'String')) returns contents of e10 as a double


% --- Executes during object creation, after setting all properties.
function e10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e11_Callback(hObject, eventdata, handles)
% hObject    handle to e11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e11 as text
%        str2double(get(hObject,'String')) returns contents of e11 as a double


% --- Executes during object creation, after setting all properties.
function e11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e12_Callback(hObject, eventdata, handles)
% hObject    handle to e12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e12 as text
%        str2double(get(hObject,'String')) returns contents of e12 as a double


% --- Executes during object creation, after setting all properties.
function e12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e13_Callback(hObject, eventdata, handles)
% hObject    handle to e13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e13 as text
%        str2double(get(hObject,'String')) returns contents of e13 as a double


% --- Executes during object creation, after setting all properties.
function e13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e14_Callback(hObject, eventdata, handles)
% hObject    handle to e14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e14 as text
%        str2double(get(hObject,'String')) returns contents of e14 as a double


% --- Executes during object creation, after setting all properties.
function e14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e15_Callback(hObject, eventdata, handles)
% hObject    handle to e15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e15 as text
%        str2double(get(hObject,'String')) returns contents of e15 as a double


% --- Executes during object creation, after setting all properties.
function e15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e16_Callback(hObject, eventdata, handles)
% hObject    handle to e16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e16 as text
%        str2double(get(hObject,'String')) returns contents of e16 as a double


% --- Executes during object creation, after setting all properties.
function e16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e1_2_Callback(hObject, eventdata, handles)
% hObject    handle to e1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e1_2 as text
%        str2double(get(hObject,'String')) returns contents of e1_2 as a double


% --- Executes during object creation, after setting all properties.
function e1_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e2_2_Callback(hObject, eventdata, handles)
% hObject    handle to e2_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e2_2 as text
%        str2double(get(hObject,'String')) returns contents of e2_2 as a double


% --- Executes during object creation, after setting all properties.
function e2_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e2_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e3_2_Callback(hObject, eventdata, handles)
% hObject    handle to e3_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e3_2 as text
%        str2double(get(hObject,'String')) returns contents of e3_2 as a double


% --- Executes during object creation, after setting all properties.
function e3_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e3_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e4_2_Callback(hObject, eventdata, handles)
% hObject    handle to e4_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e4_2 as text
%        str2double(get(hObject,'String')) returns contents of e4_2 as a double


% --- Executes during object creation, after setting all properties.
function e4_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e4_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e5_2_Callback(hObject, eventdata, handles)
% hObject    handle to e5_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e5_2 as text
%        str2double(get(hObject,'String')) returns contents of e5_2 as a double


% --- Executes during object creation, after setting all properties.
function e5_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e5_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e6_2_Callback(hObject, eventdata, handles)
% hObject    handle to e6_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e6_2 as text
%        str2double(get(hObject,'String')) returns contents of e6_2 as a double


% --- Executes during object creation, after setting all properties.
function e6_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e6_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e7_2_Callback(hObject, eventdata, handles)
% hObject    handle to e7_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e7_2 as text
%        str2double(get(hObject,'String')) returns contents of e7_2 as a double


% --- Executes during object creation, after setting all properties.
function e7_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e7_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e8_2_Callback(hObject, eventdata, handles)
% hObject    handle to e8_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e8_2 as text
%        str2double(get(hObject,'String')) returns contents of e8_2 as a double


% --- Executes during object creation, after setting all properties.
function e8_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e8_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e9_2_Callback(hObject, eventdata, handles)
% hObject    handle to e9_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e9_2 as text
%        str2double(get(hObject,'String')) returns contents of e9_2 as a double


% --- Executes during object creation, after setting all properties.
function e9_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e9_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e10_2_Callback(hObject, eventdata, handles)
% hObject    handle to e10_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e10_2 as text
%        str2double(get(hObject,'String')) returns contents of e10_2 as a double


% --- Executes during object creation, after setting all properties.
function e10_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e10_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e11_2_Callback(hObject, eventdata, handles)
% hObject    handle to e11_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e11_2 as text
%        str2double(get(hObject,'String')) returns contents of e11_2 as a double


% --- Executes during object creation, after setting all properties.
function e11_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e11_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e12_2_Callback(hObject, eventdata, handles)
% hObject    handle to e12_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e12_2 as text
%        str2double(get(hObject,'String')) returns contents of e12_2 as a double


% --- Executes during object creation, after setting all properties.
function e12_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e12_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e13_2_Callback(hObject, eventdata, handles)
% hObject    handle to e13_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e13_2 as text
%        str2double(get(hObject,'String')) returns contents of e13_2 as a double


% --- Executes during object creation, after setting all properties.
function e13_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e13_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e14_2_Callback(hObject, eventdata, handles)
% hObject    handle to e14_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e14_2 as text
%        str2double(get(hObject,'String')) returns contents of e14_2 as a double


% --- Executes during object creation, after setting all properties.
function e14_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e14_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e15_2_Callback(hObject, eventdata, handles)
% hObject    handle to e15_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e15_2 as text
%        str2double(get(hObject,'String')) returns contents of e15_2 as a double


% --- Executes during object creation, after setting all properties.
function e15_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e15_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e16_2_Callback(hObject, eventdata, handles)
% hObject    handle to e16_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e16_2 as text
%        str2double(get(hObject,'String')) returns contents of e16_2 as a double


% --- Executes during object creation, after setting all properties.
function e16_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e16_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out1_Callback(hObject, eventdata, handles)
% hObject    handle to out1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out1 as text
%        str2double(get(hObject,'String')) returns contents of out1 as a double


% --- Executes during object creation, after setting all properties.
function out1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out2_Callback(hObject, eventdata, handles)
% hObject    handle to out2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out2 as text
%        str2double(get(hObject,'String')) returns contents of out2 as a double


% --- Executes during object creation, after setting all properties.
function out2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out3_Callback(hObject, eventdata, handles)
% hObject    handle to out3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out3 as text
%        str2double(get(hObject,'String')) returns contents of out3 as a double


% --- Executes during object creation, after setting all properties.
function out3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out4_Callback(hObject, eventdata, handles)
% hObject    handle to out4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out4 as text
%        str2double(get(hObject,'String')) returns contents of out4 as a double


% --- Executes during object creation, after setting all properties.
function out4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out5_Callback(hObject, eventdata, handles)
% hObject    handle to out5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out5 as text
%        str2double(get(hObject,'String')) returns contents of out5 as a double


% --- Executes during object creation, after setting all properties.
function out5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out6_Callback(hObject, eventdata, handles)
% hObject    handle to out6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out6 as text
%        str2double(get(hObject,'String')) returns contents of out6 as a double


% --- Executes during object creation, after setting all properties.
function out6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out7_Callback(hObject, eventdata, handles)
% hObject    handle to out7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out7 as text
%        str2double(get(hObject,'String')) returns contents of out7 as a double


% --- Executes during object creation, after setting all properties.
function out7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out8_Callback(hObject, eventdata, handles)
% hObject    handle to out8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out8 as text
%        str2double(get(hObject,'String')) returns contents of out8 as a double


% --- Executes during object creation, after setting all properties.
function out8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out9_Callback(hObject, eventdata, handles)
% hObject    handle to out9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out9 as text
%        str2double(get(hObject,'String')) returns contents of out9 as a double


% --- Executes during object creation, after setting all properties.
function out9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out10_Callback(hObject, eventdata, handles)
% hObject    handle to out10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out10 as text
%        str2double(get(hObject,'String')) returns contents of out10 as a double


% --- Executes during object creation, after setting all properties.
function out10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out11_Callback(hObject, eventdata, handles)
% hObject    handle to out11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out11 as text
%        str2double(get(hObject,'String')) returns contents of out11 as a double


% --- Executes during object creation, after setting all properties.
function out11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out12_Callback(hObject, eventdata, handles)
% hObject    handle to out12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out12 as text
%        str2double(get(hObject,'String')) returns contents of out12 as a double


% --- Executes during object creation, after setting all properties.
function out12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out13_Callback(hObject, eventdata, handles)
% hObject    handle to out13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out13 as text
%        str2double(get(hObject,'String')) returns contents of out13 as a double


% --- Executes during object creation, after setting all properties.
function out13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out14_Callback(hObject, eventdata, handles)
% hObject    handle to out14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out14 as text
%        str2double(get(hObject,'String')) returns contents of out14 as a double


% --- Executes during object creation, after setting all properties.
function out14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out15_Callback(hObject, eventdata, handles)
% hObject    handle to out15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out15 as text
%        str2double(get(hObject,'String')) returns contents of out15 as a double


% --- Executes during object creation, after setting all properties.
function out15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function out16_Callback(hObject, eventdata, handles)
% hObject    handle to out16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out16 as text
%        str2double(get(hObject,'String')) returns contents of out16 as a double


% --- Executes during object creation, after setting all properties.
function out16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function forTime_Callback(hObject, eventdata, handles)
% hObject    handle to forTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of forTime as text
%        str2double(get(hObject,'String')) returns contents of forTime as a double


% --- Executes during object creation, after setting all properties.
function forTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to forTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sparkTime_Callback(hObject, eventdata, handles)
% hObject    handle to sparkTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sparkTime as text
%        str2double(get(hObject,'String')) returns contents of sparkTime as a double


% --- Executes during object creation, after setting all properties.
function sparkTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sparkTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3
% axes(hObject);


% --- Executes on key press with focus on e1 and none of its controls.
function e1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to e1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r2_Callback(hObject, eventdata, handles)
% hObject    handle to r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of r2 as text
%        str2double(get(hObject,'String')) returns contents of r2 as a double

        set(handles.out1,'Visible',false);
        set(handles.out2,'Visible',false);
        set(handles.out3,'Visible',false);
        set(handles.out4,'Visible',false);
        set(handles.out5,'Visible',false);
        set(handles.out6,'Visible',false);
        set(handles.out7,'Visible',false);
        set(handles.out8,'Visible',false);
        set(handles.out9,'Visible',false);
        set(handles.out10,'Visible',false);
        set(handles.out11,'Visible',false);
        set(handles.out12,'Visible',false);
        set(handles.out13,'Visible',false);
        set(handles.out14,'Visible',false);
        set(handles.out15,'Visible',false);
        set(handles.out16,'Visible',false);
        set(handles.e1,'Visible',false);
        set(handles.e2,'Visible',false);
        set(handles.e3,'Visible',false);
        set(handles.e4,'Visible',false);
        set(handles.e5,'Visible',false);
        set(handles.e6,'Visible',false);
        set(handles.e7,'Visible',false);
        set(handles.e8,'Visible',false);
        set(handles.e9,'Visible',false);
        set(handles.e10,'Visible',false);
        set(handles.e11,'Visible',false);
        set(handles.e12,'Visible',false);
        set(handles.e13,'Visible',false);
        set(handles.e14,'Visible',false);
        set(handles.e15,'Visible',false);
        set(handles.e16,'Visible',false);
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);

set(handles.popupmenu4,'Value',1)
set(handles.e1,'String','');
set(handles.e2,'String','');
set(handles.e3,'String','');
set(handles.e4,'String','');
set(handles.e5,'String','');
set(handles.e6,'String','');
set(handles.e7,'String','');
set(handles.e8,'String','');
set(handles.e9,'String','');
set(handles.e10,'String','');
set(handles.e11,'String','');
set(handles.e12,'String','');
set(handles.e13,'String','');
set(handles.e14,'String','');
set(handles.e15,'String','');
set(handles.e16,'String','');
set(handles.e1_2,'String','');
set(handles.e2_2,'String','');
set(handles.e3_2,'String','');
set(handles.e4_2,'String','');
set(handles.e5_2,'String','');
set(handles.e6_2,'String','');
set(handles.e7_2,'String','');
set(handles.e8_2,'String','');
set(handles.e9_2,'String','');
set(handles.e10_2,'String','');
set(handles.e11_2,'String','');
set(handles.e12_2,'String','');
set(handles.e13_2,'String','');
set(handles.e14_2,'String','');
set(handles.e15_2,'String','');
set(handles.e16_2,'String','');
set(handles.out1,'String','');
set(handles.out2,'String','');
set(handles.out3,'String','');
set(handles.out4,'String','');
set(handles.out5,'String','');
set(handles.out6,'String','');
set(handles.out7,'String','');
set(handles.out8,'String','');
set(handles.out9,'String','');
set(handles.out10,'String','');
set(handles.out11,'String','');
set(handles.out12,'String','');
set(handles.out13,'String','');
set(handles.out14,'String','');
set(handles.out15,'String','');
set(handles.out16,'String','');

% --- Executes during object creation, after setting all properties.
function r2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r3_Callback(hObject, eventdata, handles)
% hObject    handle to r3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of r3 as text
%        str2double(get(hObject,'String')) returns contents of r3 as a double
set(handles.out1,'Visible',false);
        set(handles.out2,'Visible',false);
        set(handles.out3,'Visible',false);
        set(handles.out4,'Visible',false);
        set(handles.out5,'Visible',false);
        set(handles.out6,'Visible',false);
        set(handles.out7,'Visible',false);
        set(handles.out8,'Visible',false);
        set(handles.out9,'Visible',false);
        set(handles.out10,'Visible',false);
        set(handles.out11,'Visible',false);
        set(handles.out12,'Visible',false);
        set(handles.out13,'Visible',false);
        set(handles.out14,'Visible',false);
        set(handles.out15,'Visible',false);
        set(handles.out16,'Visible',false);
        set(handles.e1,'Visible',false);
        set(handles.e2,'Visible',false);
        set(handles.e3,'Visible',false);
        set(handles.e4,'Visible',false);
        set(handles.e5,'Visible',false);
        set(handles.e6,'Visible',false);
        set(handles.e7,'Visible',false);
        set(handles.e8,'Visible',false);
        set(handles.e9,'Visible',false);
        set(handles.e10,'Visible',false);
        set(handles.e11,'Visible',false);
        set(handles.e12,'Visible',false);
        set(handles.e13,'Visible',false);
        set(handles.e14,'Visible',false);
        set(handles.e15,'Visible',false);
        set(handles.e16,'Visible',false);
        set(handles.e1_2,'Visible',false);
        set(handles.e2_2,'Visible',false);
        set(handles.e3_2,'Visible',false);
        set(handles.e4_2,'Visible',false);
        set(handles.e5_2,'Visible',false);
        set(handles.e6_2,'Visible',false);
        set(handles.e7_2,'Visible',false);
        set(handles.e8_2,'Visible',false);
        set(handles.e9_2,'Visible',false);
        set(handles.e10_2,'Visible',false);
        set(handles.e11_2,'Visible',false);
        set(handles.e12_2,'Visible',false);
        set(handles.e13_2,'Visible',false);
        set(handles.e14_2,'Visible',false);
        set(handles.e15_2,'Visible',false);
        set(handles.e16_2,'Visible',false);

set(handles.popupmenu4,'Value',1)
set(handles.e1,'String','');
set(handles.e2,'String','');
set(handles.e3,'String','');
set(handles.e4,'String','');
set(handles.e5,'String','');
set(handles.e6,'String','');
set(handles.e7,'String','');
set(handles.e8,'String','');
set(handles.e9,'String','');
set(handles.e10,'String','');
set(handles.e11,'String','');
set(handles.e12,'String','');
set(handles.e13,'String','');
set(handles.e14,'String','');
set(handles.e15,'String','');
set(handles.e16,'String','');
set(handles.e1_2,'String','');
set(handles.e2_2,'String','');
set(handles.e3_2,'String','');
set(handles.e4_2,'String','');
set(handles.e5_2,'String','');
set(handles.e6_2,'String','');
set(handles.e7_2,'String','');
set(handles.e8_2,'String','');
set(handles.e9_2,'String','');
set(handles.e10_2,'String','');
set(handles.e11_2,'String','');
set(handles.e12_2,'String','');
set(handles.e13_2,'String','');
set(handles.e14_2,'String','');
set(handles.e15_2,'String','');
set(handles.e16_2,'String','');
set(handles.out1,'String','');
set(handles.out2,'String','');
set(handles.out3,'String','');
set(handles.out4,'String','');
set(handles.out5,'String','');
set(handles.out6,'String','');
set(handles.out7,'String','');
set(handles.out8,'String','');
set(handles.out9,'String','');
set(handles.out10,'String','');
set(handles.out11,'String','');
set(handles.out12,'String','');
set(handles.out13,'String','');
set(handles.out14,'String','');
set(handles.out15,'String','');
set(handles.out16,'String','');

% --- Executes during object creation, after setting all properties.
function r3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
