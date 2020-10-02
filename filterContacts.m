function y = filterContacts(x, nobj, nfgs)
for i = 1: nobj
    for j = 1: nfgs
        lc = length(x{i}{j});
        if lc > 1
           tmp = 1:lc;
           co = nchoosek(tmp,2);
           tmp_co = co;
           lco = size(co, 1);           
           for k = 1: lco
               if dot(x{i}{j}{co(k, 1)}.m_vnorm, x{i}{j}{co(k, 2)}.m_vnorm) <= -0.8
                   if length(x{i}{j}{co(k, 1)}.p) > length(x{i}{j}{co(k, 2)}.p)
                       tmp_co(k, 2) = 0;
                   elseif length(x{i}{j}{co(k, 1)}.p) == length(x{i}{j}{co(k, 2)}.p)
                       tmp_co(k, 2) = 0;
                   else
                       tmp_co(k, 1) = 0;
                   end
               end               
           end           
           y{i}{j}{:} = x{i}{j}{1, unique(co(~(tmp_co == 0)))};
        elseif lc == 0
           y{i}{j} = x{i}{j}; 
        else
           y{i}{j}{:} = x{i}{j}{:}; 
        end
        
    end
end
end