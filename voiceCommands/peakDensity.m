% This code was created by Purdue's ECE instrument room undergrad staff
% for educational purposes.
%
% The following function acts to find the total number of peaks above the
% given threshold value 
%
% data - amplitude data 
% thresh - the limit to collect target 
% density - counter for num peaks past thresh's value 
%

function [density] = peakDensity(data, thresh)

  points = length(data(:,2));   %number of points 
  density = 0;                  %counter

  for i = 1:points
     
      curAmp = data(i,2);   %amplitude at our current point 
      
      if(curAmp > thresh)
          density = density + 1;
      end
      
  end
  
end