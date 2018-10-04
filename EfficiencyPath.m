%finding midpoint throughout the reach and grasp 

%midpoint = [(xThumb + xIndex)/2, (yThumb + yIndex)/2];

for i = 1:height(unfilt_F1866) 
unfilt_F1866.midpoint{i,1} = 0; 
end 

for i = 1:height(unfilt) 
   filt.midpoint{i,:} = [(filt.thumbXYposn{i,1}(:,1)+filt.indexXYposn{i,1}(:,1))/2,(filt.thumbXYposn{i,1}(:,2)+filt.indexXYposn{i,1}(:,2))/2]
end 

%Draw a line from the start point to the end point of the midpoint
%data, this will be the most efficient path - calculate its distance 
X = [filt.midpoint{1,1}(1,:); filt.midpoint{1,1}(end,:)];
dist = pdist(X,'euclidean'); 

%Calculate distance of path actually taken using all the points recorded -
%this will be an approximation 
for i = 1:height(unfilt) 
    XX = [filt.midpoint{i,1}(1,:); filt.midpoint{i,1}(end,:)] 