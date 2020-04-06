%% Main section
clear all
close all
clc

% player = audioplayer(y1, 44100);

f = figure;
% actualTrack = 'Bruno Mars - The Lazy Song [OFFICIAL VIDEO].mp3';
% setappdata(f, 'file', actualTrack);
f.Name = 'Audio player';
f.NumberTitle = 'off';
f.ToolBar = 'none';
f.MenuBar = 'none';
f.CloseRequestFcn = @closeRequest;
f.Resize = 'off';

pauseBtn = uicontrol(f, 'Style', 'pushbutton');
pauseBtn.Callback = @pauseTrack;
pauseBtn.String = 'Pause';
pauseBtn.Position = [200 20 50 20];

playBtn = uicontrol(f, 'Style', 'pushbutton');
playBtn.Callback = @playTrack;
playBtn.String = 'Play';
playBtn.Position = [500 50 50 50];

stopBtn = uicontrol(f, 'Style', 'pushbutton');
stopBtn.Callback = @stopTrack;
stopBtn.String = 'Stop';
stopBtn.Position = [100 50 50 20];

openBtn = uicontrol(f, 'Style', 'pushbutton');
openBtn.Callback = @openTrack;
openBtn.String = 'Open file';
openBtn.Position = [200 50 100 20];

playNow = uicontrol(f, 'Style', 'text');
playNow.Position = [0 100 400 20];

% gainSlider = uicontrol(f, 'Style', 'slider');
% gainSlider.Value = 1;



f.UserData.playNow = playNow;

align([playBtn stopBtn pauseBtn openBtn], 'Fixed', 10, 'Bottom');

function stopTrack(hObject, eventdata, handles)         %callback function to stop playing actual track
    global player;                                      %get player instance from global variable
    if ~isempty(player)
        stop(player);                                   %stop player
    end
end

function openTrack(hObject, eventdata, handles)         %callback function for opening new file and importing it into audioplayer
    f = hObject.Parent;
    global player;
    [fileToPlay, path] = uigetfile('Audio files (*.wav;*.ogg;*.flac;*.au;*.aiff;*.aifc;*.aif;*.aifc;*.mp3;*.m4a;*.mp4)', 'Open audio file');
    if fileToPlay ~= 0
        [y, Fs] = audioread(strcat(path, fileToPlay), 'native');
        player = audioplayer(y, Fs);
        f.UserData.playNow.String = fileToPlay;
    end
end

function playTrack(hObject, eventdata, handles)
    global player;
    if ~isempty(player) && player.get.CurrentSample == 1
        play(player);

    elseif ~isempty(player)
        resume(player);
    end
end

function pauseTrack(hObject, eventdata, handles)
    global player;
    pause(player);
end

function closeRequest(~,~)
    clear all;
    delete(gcf);
end


% %% Test section
% tic
% filename = 'Bruno Mars - The Lazy Song [OFFICIAL VIDEO].mp3';
% [y, Fs] = audioread(filename, 'native');
% toc
% 
% tic
% fil = 'Bruno Mars - The Lazy Song [OFFICIAL VIDEO].mp3';
% [y1, Fs1] = audioread(fil, [1, 15*44100]);
% info = audioinfo(fil)
% toc
% 
% timeToPlay = 10;
% iFs = Fs * timeToPlay;
% 
% player = audioplayer(y1, 44100);
% player.get();