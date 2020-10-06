classdef FingerInfo < handle
    properties
        ob % Object where the contact surface is        
        p % These are the points belonging to a given contact surface
        cnn % Vector contining the normals of the given points        
    end    
    methods
        function obj = FingerInfo(o)
            obj.ob = o;
            obj.p = o.Points;
            obj.cnn = o.ConnectivityList;            
        end
        function plotFinger(obj, boolean)            
            if boolean
                hold on
                h = trimesh(obj.ob);
                h.EdgeColor = [0, 0, 0];
                h.EdgeAlpha = 0.2;
                h.FaceAlpha = 0.1;
                axis('equal')
                hold off
                xlabel('X')
                ylabel('Y')
                zlabel('Z')                
            else
                h = trimesh(obj.ob);
                h.EdgeColor = [0, 0, 0];
                h.EdgeAlpha = 0.2;
                h.FaceAlpha = 0.1;
                axis('equal')
                hold off
                xlabel('X')
                ylabel('Y')
                zlabel('Z')                
                hold off
            end            
        end        
    end
end