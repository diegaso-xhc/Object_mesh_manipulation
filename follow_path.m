function out_trn = follow_path(TR, t1, t2, cntds, str)
% t1 is the initial triangle
% t2 is the destination triangle
% TR is the triangulation element containing the information from the mesh
% out_trn is a vector containing the rows on the TR element corresponding to the triangles along the path from t1 to t2
% cntds is a vector containing the centroids of all the triangles on the mesh
if strcmp(str, 'side')
   it = 0;
   flag = 0;
   while flag == 0
       it = it + 1;
       out_trn(it, 1) = t1;
       tmp_trn = find_neighbors(TR, t1, str);   
       ln = length(tmp_trn);
       for i = 1: ln
          tmp_cntds(i, :) = cntds(tmp_trn(i), :); 
       end
       t1 = tmp_trn(dsearchn(tmp_cntds, cntds(t2, :)));
       if ismember(t1, out_trn)
           t1 = tmp_trn(randi([1 ln], 1));
       end
       t1
       if t1 == t2
           flag = 1;
       end
   end
elseif strcmp(str, 'vertex')

end

end