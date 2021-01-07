% This code was created by Purdue's ECE instrument room undergrad staff
% for educational purposes. The following is used to test audio inputs 
% into the frequency spectrum or to take real time input from a microphone and 
% interpret it as a key word based on its characteristics. 
%
% Needs these functions to run:
%   findingPeaks.m
%
% Use https://www.mathworks.com/help/matlab/ref/fft.html for more info
% on the fast forier transform 
%
% For more info on the real time audio recording use:
% https://www.mathworks.com/help/matlab/import_export/record-and-play-audio.html

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Variables 
%
Fs = 44100; %sample rate Hz
T = 1/Fs;   %sampling period
nBits = 8;  %bits per sample
NumChannels = 1; %mono (code is not set for dual) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Real time recording 
%Make sure the Testing block is commented out when running 
%
recObj = audiorecorder(Fs, nBits, NumChannels); %rec object
fprintf('Say a command: Hello or Goodbye\n');
fprintf('recording...5sec\n');
recordblocking(recObj, 5);       %5 second sample
fprintf('Done!\n');
amp = getaudiodata(recObj);      %take out the recording 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Testing block for pre recorded 
%Make sure the real time is commented out when testing for new commands 
%
%filename = "hello3.wav";       % Put your input audio file in here 
%[data, Fs] = audioread(filename);
%amp = data(:,1);               %amplitude of 1 channel 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time related variables of signal
%
L = length(amp);            %length of signal
t = 0:T:(L*T)-T;            %time vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot the incoming audio vs time (not necessary just visualization)
%
%figure();
%plot(t, amp);
%title('Audio in Time');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fast fourier Transform into a single side spectrum of frequencies 
%
Y = fft(amp);                       %taking the fft 
spectrumDual = abs(Y/L);            %dual side spectrum 
spectrum = spectrumDual(1:L/2 + 1); %single side spectrum 

band = Fs*(0:(L/2))/L;           %freq band 
band = transpose(band);          %transpose to match 
band = band(1 : 20000);          %dont need any freq above 20kHz
spectrum = spectrum(1 : 20000);  %needs to match array size of band
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find the critical peaks of the data to do analysis 
%
% small n is good for intial testing with many cases 
% larger n is better for application (less error)
%
n = 40;                         %how many peaks?
spectrum = normalize(spectrum); %normalize amps (reduces variance in speech)
data = [band, spectrum];    
[peaks, freqs] = findingPeaks(data, n);  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This segment is useful for testing, it finds the frequency 
%of the highest amplitude peak in the results of finding Peaks
%by study this we can add more properties to the analyze function.
%
%Shld be commented out when not testing the code 
%
ind = find(peaks == max(peaks));
maxAmp = peaks(ind);
maxAmpF = freqs(ind);
ind = find(peaks == min(peaks));
minAmp = peaks(ind);
minAmpF = freqs(ind);

avgP = mean(peaks);
avgF = mean(freqs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot our human hearing range 20Hz-20000Hz in the band of freq 
%visualization (not necessary for operation)
%
%figure();
%semilogx(band, spectrum);

%title('Amplitude Spectrum');
%xlabel('f (Hz)');
%ylabel('amplitude');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%finds number of peaks above a threshold
%
thresh = 1.2;   %change this based on your tests 
density = peakDensity(data, thresh);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analyzing the peaks and frequency data 
% bassed on the parameters
% that were looked at in excel
%
command = analyze(density, freqs, peaks);

if (command == 'h')
    fprintf('\n you said hello\n');
elseif(command == 'g')
    fprintf('\n you said goodbye\n');
elseif(command == 'u')
    fprintf('\n unknown input\n');
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%