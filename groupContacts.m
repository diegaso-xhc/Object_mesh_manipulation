function y = groupContacts(obj, vec)
% This function allows us to group the contact surfaces on groups.
% Basically, a set of triangles is received and this function checks
% which triangles are connected to one another and group them together.
tmp_tr = triangulation(obj.ConnectivityList(vec, :), obj.Points); % Create a triangulation only with the triangles of interest, but with the points of the full object
ed = edges(tmp_tr);
tmp_ed = unique(ed(:,1));
y = {};
i = 0;
j = 0;
while 1
    i = i + 1; % Iteration number
    y{i}(1) = tmp_ed(1);
    while 1
        j = j + 1;
        tmp = find(ed(:, 1) == y{i}(j));
        if ~isempty(tmp)
            y{i} = unique([y{i} ed(tmp,2)']);
        else
            j = 0;
            break;
        end
    end
    [bl, loc] = ismember(tmp_ed, y{i});
    loc(loc == 0) = [];
    tmp_ed(loc) = [];
    if isempty(tmp_ed)
        i = 0;
        break;
    end
end
end