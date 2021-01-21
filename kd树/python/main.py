from kdtree import TreeNode
from kdtree import KDTree
from kdtree import preorder

data = [
    [2,3],[5,4],[9,6],[4,7],[8,1],[7,2]
]

kd = KDTree(data)
preorder(kd.root)