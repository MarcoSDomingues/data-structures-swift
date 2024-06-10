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
}

extension BinaryTree: BinaryTreeTraversal {}
