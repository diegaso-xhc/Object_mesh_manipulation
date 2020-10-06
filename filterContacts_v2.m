function y = filterContacts_v2(x, nobj, nfgs, obj)
% This function filters the contact surfaces depending on their orientation
% with respect to the object where they appear. If there are two contact
% surfaces from the same finger which point on different directions, it is
% assumed that one of these surfaces was misidentified. 
y = {{}};

for i = 1: nobj
    cg = mean(obj{i}.Points, 1); % Center of gravity of the object
    for j = 1: nfgs
        lc = length(x{i}{j}); % Number of contacts on a given object and finger
        if lc > 1
           tmp = 1:lc;
           co = nchoosek(tmp,2); % We gather all of the possible combinations from the contact surfaces
           tmp_co = co;
           lco = size(co, 1);           
           for k = 1: lco
               if dot(x{i}{j}{co(k, 1)}.m_vnorm, x{i}{j}{co(k, 2)}.m_vnorm) <= -0.8 % Check whether the mean normal of the two contact surfaces point on opposite directions
%                    if length(x{i}{j}{co(k, 1)}.p) > length(x{i}{j}{co(k, 2)}.p)
%                        tmp_co(k, 2) = 0;
%                    elseif length(x{i}{j}{co(k, 1)}.p) == length(x{i}{j}{co(k, 2)}.p)
%                        tmp_co(k, 2) = 0;
%                    else
%                        tmp_co(k, 1) = 0;
%                    end
                   if dot(x{i}{j}{co(k, 1)}.mp - cg, x{i}{j}{co(k, 1)}.m_vnorm) >= 0 % Check whether or not the contact surfaces point in different directions from the center of the object or not                       
                       tmp_co(k, 2) = 0;                   
                   else
                       tmp_co(k, 1) = 0;
                   end
               end               
           end           
           l_vec = unique(co(~(tmp_co == 0)));
           for t = 1: length(l_vec)
               y{i}{j}{t} = x{i}{j}{l_vec(t)}; % Assignment of the contact surfaces which haven't been removed              
           end           
        elseif lc == 0
           y{i}{j} = x{i}{j}; % In case no contact surface was identified 
        else
           y{i}{j}{:} = x{i}{j}{:}; % In case there is only one contact surface
        end        
    end
end
end