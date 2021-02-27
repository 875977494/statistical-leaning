clear;
close all;
clc;
% ��������
data = [2 3;
    5 4;
    9 6;
    4 7;
    8 1;
    7 2];
% �����ݱ��
for i = 1: size(data,1)
    data(i,3) = i;
end
% ����Kd��
Kd_tree = Kd_tree_create(data);
% ����Kd������kNN��ѯ
closest = Kd_tree_search_knn(Kd_tree, [6,3.1], 2);

%% ʹ��data����Kd��
function [tree] = Kd_tree_create(data)
% ����Kd����ÿ�ηָ��Է�������ά�Ƚ��зָ�
[num, dimension] = size(data);
dimension = dimension - 1;
for i = 1: dimension
    data_var(i) = var(data(:,i));
end
[~, choose_dim] = max(data_var);
data = sortrows(data, choose_dim);
tree.id = data(round(num/2),end);
tree.node = data(round(num/2),1:end-1);
tree.dim = choose_dim;
tree.parent = [];
tree.left = [];
tree.right = [];

% �ݹ�������������
lefttree = [];
righttree = [];
if round(num/2) > 1
    leftdata = data(1:(round(num/2)-1), :);
    lefttree = Kd_tree_create(leftdata);
    for i = 1: size(lefttree, 1)
        if isempty(lefttree(i).parent)
            lefttree(i).parent = tree.id;
            tree.left = lefttree(i).id;
        end
    end
end
if round(num/2) < num
    rightdata = data((round(num/2)+1):end, :);
    righttree = Kd_tree_create(rightdata);
    for i = 1: size(righttree, 1)
        if isempty(righttree(i).parent)
            righttree(i).parent = tree.id;
            tree.right = righttree(i).id;
        end
    end
end
tree = [tree; lefttree];
tree = [tree; righttree];
end


%% ����Kd������kNN��ѯ
function [closest_point] = Kd_tree_search_knn(Kd_tree, data, n)
% �Ӹ��ڵ㿪ʼһֱ��ѯ��Ҷ�ڵ㣬�ҵ���data��һ�������Ҷ�ڵ�
closest = Kd_tree(1);
while(1)
    if closest.node(closest.dim) >= data(closest.dim) && ~isempty(closest.left)
        closest = Kd_tree(find([Kd_tree.id]==closest.left));
    elseif closest.node(closest.dim) <= data(closest.dim) && ~isempty(closest.right)
        closest = Kd_tree(find([Kd_tree.id]==closest.right));
    else
        break
    end
end

Kd_tree(find([Kd_tree.id]==closest.id)).done = 1;
closest_point = closest.node;
[max_dis, max_idx] = max(sum((closest_point - data).^2, 2));
max_dis = max_dis(1);
max_idx = max_idx(1);

% �ӵ�ǰ�ڵ����ϻ���
node_now = closest;
while(1)
    % ���ݵ����ڵ��break
    if find([Kd_tree.id]==node_now.id) == 1
        break
    end
    
    % ���ݵ����ڵ㣬������ڵ�ĵ����Ҫ�����ӽ�ȥ
    node_now = Kd_tree(find([Kd_tree.id]==node_now.parent));
    Kd_tree(find([Kd_tree.id]==node_now.id)).done = 1;
    if size(closest_point, 1) < n
        closest_point(end+1, :) = node_now.node;
    elseif sum((node_now.node-data).^2) < max_dis
        closest_point(max_idx, :) = node_now.node;
        [max_dis, max_idx] = max(sum((closest_point - data).^2, 2));
        max_dis = max_dis(1);
        max_idx = max_idx(1);
    end
    
    % ���data�㵽���ڵ�ķָ��ߵľ��룬�������С�ڵ�ǰ�����룬���������һ���з���Ҫ��ĵ�
    closest_temp = [];
    if (data(node_now.dim)-node_now.node(node_now.dim))^2 < max_dis
        if ~isempty(node_now.left)
            node_temp = Kd_tree(find([Kd_tree.id]==node_now.left));
            if isempty(node_temp.done)
                % �����ӽڵ������һ�У���Ϊ���ڵ㣬�ݹ����
                Kd_tree_temp = Kd_tree;
                Kd_tree_temp(1) = node_temp;
                Kd_tree_temp(find([Kd_tree.id]==node_temp.id)) = Kd_tree(1);
                closest_temp = [closest_temp; Kd_tree_search_knn(Kd_tree_temp, data, n)];
            end
        end
        if ~isempty(node_now.right)
            node_temp = Kd_tree(find([Kd_tree.id]==node_now.right));
            if isempty(node_temp.done)
                % �����ӽڵ������һ�У���Ϊ���ڵ㣬�ݹ����
                Kd_tree_temp = Kd_tree;
                Kd_tree_temp(1) = node_temp;
                Kd_tree_temp(find([Kd_tree.id]==node_temp.id)) = Kd_tree(1);
                closest_temp = [closest_temp; Kd_tree_search_knn(Kd_tree_temp, data, n)];
            end
        end
    end
    
    if ~isempty(closest_temp)
        closest_temp_dis = sum((closest_temp - data).^2, 2);
        for i = 1: size(closest_temp_dis, 1)
            if closest_temp_dis(i) < max_dis
                closest_point(max_idx, :) = closest_temp(i, :);
                [max_dis, max_idx] = max(sum((closest_point - data).^2, 2));
                max_dis = max_dis(1);
                max_idx = max_idx(1);
            end
        end
    end
end
end