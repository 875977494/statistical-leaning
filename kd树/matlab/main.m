clear;
clc;
x = [2, 3;
    5, 4;
    9, 6;
    4, 7;
    8, 1;
    7, 2;
];

%% ´ý²éµã
xi = [1, 1];
[row, col] = size(x);
KDTree = createKDTree(x, 0, row - 1, 1);

close = SearchKDTree(KDTree, xi);


