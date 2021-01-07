% This code was created by Purdue's ECE instrument room undergrad staff
% for educational purposes.
% This function is meant for testing in conjunction with speechTesting.m.
% It will find X number of critical peaks in the amplitude spectrum provided
% to its input arguments. In doing so a correlation between inputs might be found.
%
% Arguments:
% data - col 1: freqs /// col 2: amplitudes  
% n    - the number of peaks we are looking for 
% peaks - a vector of the critical data we found of length n
%

function [peaks, freqs] = findingPeaks(data, n) 

  %init peaks and freqs to be searchably low values 
  for i = 1:n
      peaks(i) = -i; %small amplitudes and need nonzero logic so negative 
      freqs(i) = i;
  end


  points = length(data(:,1)); %number of points in the spectrum
  
  for i = 1:points %sweep thru all data 
      
      curAmp = data(i, 2); %current amplitude  
      curFre = data(i, 1); %current frequency 
      
      if(curAmp > min(peaks))
          index = find(peaks == min(peaks));
          freqs(index) = curFre; 
          peaks(index) = curAmp;
      end
      
  end
 
end