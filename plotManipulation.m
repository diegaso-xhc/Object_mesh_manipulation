function plotManipulation(object, y, fingers)
% This function allows us to plot the interaction between a given object,
% the given hand structure and the contact surfaces which were previously
% found.
ob = {};
fgs = {};
lob = length(object);
lfgs = length(fingers);
for i = 1: lob
   ob{i} = ObjectInfo(object{i});
end
for i = 1: lfgs
   fgs{i} = FingerInfo(fingers{i});
end
for i = 1: lob    
   subplot(lob, 2, 2*i - 1)
   ob{i}.plotObject(1);
   plotContactRegions(y)   
   axis('equal')
   grid on
   
   subplot(lob, 2, 2*i)
   ob{i}.plotObject(1)
   plotContactRegions(y)
   axis('equal')
   grid on
   
   for j = 1: lfgs        
        subplot(lob, 2, 2*i)
        fgs{j}.plotFinger(1)
   end
end







end