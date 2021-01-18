function tree = createKDTree(data, l, r, idx)
    if (l > r) 
        return ;
    end
    [row, col] = size(data);
    % sortrows 以指定列数据排序 B = sortrows（A, col）;
    temp = sortrows(data, idx);
    m = l + round((r - l) / 2);
    tree.val = data(m, :);
    idx = mod((idx + 1), col) + 1;
    tree.left = [];
    tree.right = [];
    
    
end

