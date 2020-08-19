function out_trn = select_area(TR, t, cntds, str)
% t is an array containing the points limiting the area
% TR is the triangulation element containing the information from the mesh
% out_trn is a vector containing the rows on the TR element corresponding to the triangles along the path from t1 to t2
% cntds is a vector containing the centroids of all the triangles on the mesh
n = length(t); % This is the number of points delimiting an area

% conn = zeros(n, 2);
% for i = 1: n
%     % We first arrange the points to build a contour on a mesh space (triangle numbers)
%     tmp_cntds_2 = tmp_cntds;
%     temp_vec = 1:n;
%     temp_vec(i) = [];
%     tmp_cntds_2(i, :) = [];
%     id = dsearchn(tmp_cntds_2, cntds(t(i), :)); % This returns the index of the first closest point
%     conn(i, 1) = temp_vec(id); % This returns the triangle 
%     temp_vec(id) = [];
%     tmp_cntds_2(id, :) = [];
%     conn(i, 2) = temp_vec(dsearchn(tmp_cntds_2, cntds(t(i), :))); % This returns the index of the second closest point   
% end
% 
% out_trn = 0;
% for i = 1: n
%    % We first build the contour on a mesh space (triangle numbers)
%    for j = 1: 2 % There are two connection points for each point
%        if i == 1 && j == 1
%            out_trn = follow_path(TR, t(i), t(conn(i, j)), cntds, str);
%        else
%            out_trn = [out_trn; follow_path(TR, t(i), t(conn(i, j)), cntds, str)];
%        end
%    end   
% end
% out_trn = unique(out_trn);

% out_trn = 0;
% it = 0;
% for i = 1: n
%    % We first build the contour on a mesh space (triangle numbers)
%    for j = 1: n % There are two connection points for each point
%        it = it + 1;
%        if i ~= j
%            if it == 2
%                out_trn = follow_path(TR, t(i), t(j), cntds, str);
%            else
%                out_trn = [out_trn; follow_path(TR, t(i), t(j), cntds, str)];
%            end          
%        end
%    end
% end

v = 1: length(t); % Create a vector of n elements
comb = combnk(v,2); % We take all the combinations of two from the aforementioned vector
lc = size(comb, 1); % Number of combinations
it = 0;
for i = 1: lc
    tmp_v = v;
    tmp_v(comb(i, :)) = [];
    tmp_trn = follow_path(TR, t(comb(i, 1)), t(comb(i, 2)), cntds, str);    
    ltmp = length(tmp_trn);
    for j = 1: n - 2
        for k = 1: ltmp
            it = it + 1;
            if it == 1
                if tmp_trn(k) ~= t(tmp_v(j))
                    out_trn = follow_path(TR, tmp_trn(k), t(tmp_v(j)), cntds, str);
                end
            else
                if tmp_trn(k) ~= t(tmp_v(j))                    
                    out_trn = [out_trn; follow_path(TR, tmp_trn(k), t(tmp_v(j)), cntds, str);];
                end
            end            
        end        
    end
end
out_trn = unique(out_trn);
% 
% out_trn = 0;
% it = 0;
% for i = 1: n
%    % We first build the contour on a mesh space (triangle numbers)
%    for j = 1: n % There are two connection points for each point
%        it = it + 1;
%        if i ~= j
%            if it == 2
%                out_trn = follow_path(TR, t(i), t(j), cntds, str);
%            else
%                out_trn = [out_trn; follow_path(TR, t(i), t(j), cntds, str)];
%            end          
%        end
%    end
% end
% out_trn = unique(out_trn);







end