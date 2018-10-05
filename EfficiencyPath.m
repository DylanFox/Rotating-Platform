%finding midpoint throughout the reach and grasp 

%midpoint = [(xThumb + xIndex)/2, (yThumb + yIndex)/2];

for i = 1:height(unfilt_F1866) 
unfilt_F1866.midpoint{i,1} = 0; 
end 

for i = 1:height(unfilt) 
   filt.midpoint{i,:} = [(filt.thumbXYposn{i,1}(:,1)+filt.indexXYposn{i,1}(:,1))/2,(filt.thumbXYposn{i,1}(:,2)+filt.indexXYposn{i,1}(:,2))/2];
end 

%Draw a line from the start point to the end point of the midpoint
%data, this will be the most efficient path - calculate its distance 

%Single
X = [filt.midpoint{1,1}(1,:); filt.midpoint{1,1}(end,:)]; %Singular
dist = pdist(X,'euclidean'); 

%Iterative 
for i = 1:height(unfilt_F1866)
    X{i,1} = [unfilt_F1866.midpoint{i,1}(1,:); unfilt_F1866.midpoint{i,1}(end,:)];
    ideal_dist(i,1) = pdist(X{i},'euclidean'); 
end

%Calculate distance of path actually taken using all the points recorded -
%this will be an approximation 

%Single 
X = unfilt_F1866.midpoint{1,1}; 
a = pdist(X([1:2],:),'euclidean')
aa = pdist(X([2:3],:),'euclidean')

%WORKED - Iterative 
for i = 1:height(unfilt_F1866)
for k = 1:(length(unfilt_F1866.midpoint{i,1}) -1)
a(k,i) = pdist(unfilt_F1866.midpoint{i,1}([k:k+1],:),'euclidean');
end
end
actual_dist = sum(a,1); 
actual_dist = actual_dist'; 

ReachPathRatio = actual_dist./ideal_dist;