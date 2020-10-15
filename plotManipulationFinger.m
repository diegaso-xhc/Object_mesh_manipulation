function plotManipulationFinger(object, y, fingers, yf)
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
    for j = 1: lfgs
        subplot(lob, lfgs, (i-1)*lfgs + j)
        fgs{j}.plotFinger(1);
%         ob{i}.plotObject(1, [rand rand rand]);
        plotContactRegionsFingers_v2(yf{i}{j}, [rand rand rand])
        axis('equal')
        view([45 25])        
    end    
end   

end







