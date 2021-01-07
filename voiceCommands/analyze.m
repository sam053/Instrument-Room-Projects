% This code was created by Purdue's ECE instrument room undergrad staff
% for educational purposes.
% This function is meant to be used in conjunction with speechTesting.m
% It is meant to take in the argument arrays of frequency and peaks which
% are both of length n specified in speechTesting.m. The values used in
% analysis are based off of multiple tests looked at in excel. 
%
% density - the number of peaks above thresh
% freqs - most prominent frequencies of length n 
% peaks - amplitdues at freqs of length n 
% command - the determination (for printing output)
%
% simple statistics are used as a determining method though it can become
% much more complex

function [command] = analyze(density, freqs, peaks)

  %note not all of these were used in the final product but many were
  %useful in testing 
  avgF = mean(freqs);       %average frequency in most prominent set
  avgP = mean(peaks);       %average amplitude in most prominent set
  medF = median(freqs);     %median frequency in most prominent set 
  
  ind = find(peaks == max(peaks));  %index 
  maxAmp = peaks(ind);              %maximum amplitude 
  maxAmpF = freqs(ind);             %frequency at maximum amplitdue 
  ind = find(peaks == min(peaks));  %index 
  minAmp = peaks(ind);              %minimum amplitude 
  minAmpF = freqs(ind);             %frequency at minimum amplitude 
  
  
  %make a decision 
  %easiest to first tell by peakDensity 
  %sub decisions are to help parse out edge cases 
  
  if(density > 700 && density < 1800)
      if(minAmpF < 560 )
          command = 'h';
      else
          command = 'g';
      end
      
  elseif(density > 1800 && density < 2700)
      if(minAmpF > 560 || avgF < 450)
        command = 'g'; 
      else
        command = 'h';
      end
      
  else
      command = 'u'; %undetectable  
  end
  
end