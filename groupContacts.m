function y = groupContacts(obj, vec)
% This function allows us to group the contact surfaces on groups.
% Basically, a set of triangles is received and this function checks
% which triangles are connected to one another and group them together.
tmp_tr = triangulation(obj.ConnectivityList(vec, :), obj.Points); % Create a triangulation only with the triangles of interest, but with the points of the full object
ed = edges(tmp_tr); % Find a nx2 vector which contains the connections on the given triangulation of interest
tmp_ed = unique([ed(:,1);ed(:,2)]); % We get all of the points of interest from the edge matrix 
y = {}; % Resulting contact regions
i = 0;
j = 0;
while 1
    i = i + 1; % Number of contact region    
    y{i}(1) = tmp_ed(1); % First element on the vector containing all of the points we are concerned with
    while 1
        j = j + 1; % Number of point on the i-th contact region
        if y{i}(j) == 3148
           cda=4; 
        end
        tmp = find(ed(:, 1) == y{i}(j)); % Find all of the connections of the corresponding point       
        if ~isempty(tmp)           
            y{i} = unique([y{i} ed(tmp,2)']); % If there are connections, we attach said connection points to the contact surface vector
            [a, b] = find(ed(:, 2) == ed(tmp, 2)'); % We attach all of the subsequent connections from the connections of the given point
            if ~isempty(a)                
                y{i} = unique([y{i} ed(a,1)']); % We attach all of the elements on the first column of edges, just in case they were not included before
            end    
            
            tmp = find(ed(:, 2) == y{i}(j)); % In case a connection element is not on the first column of the edge matrix, we doble check on the second column
            if ~isempty(tmp) 
                y{i} = unique([y{i} ed(tmp,1)']); % If there are connections, we attach said connection points to the contact surface vector
            end           
        else
            tmp = find(ed(:, 2) == y{i}(j)); % In case a connection element is not on the first column of the edge matrix, we doble check on the second column
            if ~any(ismember(ed(tmp,1), y{i})) % If there are not elements on the first column of the given point which belong already to the contact surface, 
                                                % we assume this is the end of the surface
                j = 0; % Reseting of count
                break; % Break current surface contact               
            else                                
                if ~isempty(tmp)
                    y{i} = unique([y{i} ed(tmp,2)']); % We add the elements to the contact surface vector and filter them out
                end  
                if j == length(y{i}) % If this is the last element on the contact surface, we break
                    j = 0;
                    break;
                end
            end
        end
    end
    [bl, loc] = ismember(y{i}, tmp_ed); % We check whether the elements on the contact surface are on the original tmp_ed vector we created before
    loc(loc == 0) = []; % We gather the locations where repeated elements might be
    tmp_ed(loc) = []; % We delete this elements so we can generate surface contacts with the remaining points
    if isempty(tmp_ed) % If after deleting the points from a contact surface, the vector is empty, it means we have finished grouping all of the points.
        i = 0;
        break;
    end
end
end