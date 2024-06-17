//
//  BinaryTree.swift
//
//
//  Created by Marco Domingues on 06/06/2024.
//

import Foundation

public final class BinaryTree<T> {
    public final class Node: BinaryTreeNode {
        public var value: T
        public var left: Node?
        public var right: Node?

        public var count: Int {
            (left?.count ?? 0) + 1 + (right?.count ?? 0)
        }

        init(value: T, left: Node? = nil, right: Node? = nil) {
            self.value = value
            self.left = left
            self.right = right
        }
    }

    public var root: Node?

    init(root: Node?) {
        self.root = root
    }

    @discardableResult
    public func insertValue(_ value: T) -> Node {
        let node = Node(value: value)
        return insertNode(node)
    }

    @discardableResult
    public func insertNode(_ newNode: Node) -> Node {
        guard let root else {
            // Tree is empty -> node becomes root
            root = newNode
            return newNode
        }

        // Create a Queue to traverse the tree
        // and find the position to insert the node
        var queue: [Node] = [root]

        while !queue.isEmpty {
            let node = queue.removeFirst()

            if let leftChild = node.left {
                queue.append(leftChild)
            } else {
                node.left = newNode
                break
            }

            if let rightChild = node.right {
                queue.append(rightChild)
            } else {
                node.right = newNode
                break
            }
        }

        return root
    }

    @discardableResult
    func invert() -> Node? {
        guard let root else {
            return nil
        }

        var queue = [root]

        while !queue.isEmpty {
            let current = queue.removeFirst()
            let temp = current.left
            current.left = current.right
            current.right = temp

            if let left = current.left {
                queue += [left]
            }

            if let right = current.right {
                queue += [right]
            }
        }

        return root
    }

    /// Returns the maximum number of nodes along the longest path
    /// from the root node down to the farthest leaf node.
    func maximumDepth() -> Int {
        guard let root else {
            return 0
        }

        var maxDepth = 0

        var stack = [(root, 1)]
        while !stack.isEmpty {
            let (current, depth) = stack.removeLast()
            maxDepth = max(maxDepth, depth)

            if let left = current.left {
                stack += [(left, depth + 1)]
            }

            if let right = current.right {
                stack += [(right, depth + 1)]
            }
        }

        return maxDepth
    }
}

extension BinaryTree where T: Comparable {
    @discardableResult
    func searchValue(_ value: T) -> Node? {
        guard let root else {
            return nil
        }

        var queue = [root]

        while !queue.isEmpty {
            let current = queue.removeFirst()

            if current.value == value {
                return current
            }
            if let leftChild = current.left {
                queue += [leftChild]
            }
            if let rightChild = current.right {
                queue += [rightChild]
            }
        }

        return nil
    }

    @discardableResult
    func deleteValue(_ value: T) -> Node? {
        guard let root else {
            return nil
        }

        // If tree has only one node, and we are deleting it
        if root.left == nil, root.right == nil, root.value == value {
            self.root = nil
            return nil
        }

        var queue = [root]

        var deepestNode: Node?
        var nodeToDelete: Node?
        var parentOfDeepestNode: Node?

        while !queue.isEmpty {
            let current = queue.removeFirst()

            if current.value == value {
                nodeToDelete = current
            }

            if let leftChild = current.left {
                queue += [leftChild]
                parentOfDeepestNode = current
                deepestNode = leftChild
            }

            if let rightChild = current.right {
                queue += [rightChild]
                parentOfDeepestNode = current
                deepestNode = rightChild
            }
        }

        if let deepestNode, let nodeToDelete {
            nodeToDelete.value = deepestNode.value

            if let parentOfDeepestNode {
                if parentOfDeepestNode.left === deepestNode {
                    parentOfDeepestNode.left = nil
                } else {
                    parentOfDeepestNode.right = nil
                }
            }
        }

        return root
    }
}

extension BinaryTree where T: Comparable {
    /// Two binary trees are considered the same if they are structurally identical, 
    /// and the nodes have the same value.
    func isSameTree(_ other: BinaryTree) -> Bool {
        if self.root == nil, other.root == nil {
            return true
        }

        guard
            let l = root,
            let r = other.root,
            l.value == r.value
        else {
            return false
        }

        var queue = [(l, r)]
        while !queue.isEmpty {
            let (l, r) = queue.removeFirst()

            if l.value != r.value {
                return false
            }

            if let leftL = l.left, let leftR = r.left {
                queue += [(leftL, leftR)]
            } else if l.left != nil || r.left != nil {
                return false
            }

            if let rightL = l.right, let rightR = r.right {
                queue += [(rightL, rightR)]
            } else if l.right != nil || r.right != nil {
                return false
            }
        }

        return true
    }
}

extension BinaryTree: BinaryTreeTraversal {}
