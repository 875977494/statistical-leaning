## create kdTree

class TreeNode:
    # data 数据
    # split 划分域
    # left right 左右孩子结点
    def __init__(self, data, split, left, right) :
        self.data = data
        self.split = split
        self.left = left
        self.right = right

class KDTree:
    def __init__(self, data):
        k = len(data[0])

        def CreateNode(split, data_set) :
            if not data_set : return None
            data_set.sort(key = lambda  x : x[split])
            split_pos = len(data_set) // 2
            m = data_set[split_pos]
            split_next = (split + 1) % k
            return TreeNode(
                m,
                split,
                CreateNode(split_next, data_set[:split_pos]),
                CreateNode(split_next, data_set[split_pos + 1:])
            )

        self.root = CreateNode(0, data)

def preorder(root):
    print(root.data)
    if root.left:
        preorder(root.left)
    if root.right:
        preorder(root.right)







