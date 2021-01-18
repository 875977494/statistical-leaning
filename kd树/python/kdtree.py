# 结点的数据结构
class TreeNode(object) :
    def __init__(self, data_self, split, left, right):
        # 数据
        self.data = data_self
        # 第几个维度
        self.split = split
        # 孩子结点
        self.left = left
        self.right = right

# 树的数据结构
class KDTree(object):
    def __init__(self):
        k = len(data[0])
        def CreateNode(split, data_set) :
            if not data_set:
                return None
            data_set.sort(key = lambda x : x[split])
            split_pos = len(data_set) // 2
            median = data_set[split_pos]
            split_next = (split + 1) % k

            return TreeNode(
                median,
                split,
                CreateNode(split_next, data_set[:split_pos]),
                CreateNode(split_next, data_set[split_pos + 1:])
            )
        self.root = CreateNode(0, data)
def preorder(root) :
    print(root.data)
    if root.left:
        preorder(root.left)
    if root.right:
        preorder(root.right)

def inorder(root) :
    if root.left:
        inorder(root.left)
    print(root.data)
    if root.right:
        inorder(root.right)

def postorder(root) :
    if root.left :
        postorder(root.left)
    if root.right :
        postorder(root.right)
    print(root.data)
