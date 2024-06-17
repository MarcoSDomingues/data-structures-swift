//
//  BinaryTreeTraversal.swift
//
//
//  Created by Marco Domingues on 07/06/2024.
//

import Foundation

public protocol BinaryTreeTraversal {
    associatedtype Node: BinaryTreeNode

    func inOrderTraversal(_ root: Node?, process: (Node) -> Void)
    func preOrderTraversal(_ root: Node?, process: (Node) -> Void)
    func postOrderTraversal(_ root: Node?, process: (Node) -> Void)
    func levelOrderTraversal(_ root: Node?, process: (Node) -> Void)
}

public extension BinaryTreeTraversal {
    func inOrderTraversal(_ root: Node?, process: (Node) -> Void) {
        guard let root else {
            return
        }

        inOrderTraversal(root.left, process: process)
        process(root)
        inOrderTraversal(root.right, process: process)
    }

    func preOrderTraversal(_ root: Node?, process: (Node) -> Void) {
        guard let root else {
            return
        }

        process(root)
        preOrderTraversal(root.left, process: process)
        preOrderTraversal(root.right, process: process)
    }

    func postOrderTraversal(_ root: Node?, process: (Node) -> Void) {
        guard let root else {
            return
        }

        postOrderTraversal(root.left, process: process)
        postOrderTraversal(root.right, process: process)
        process(root)
    }

    /// Breadth First Search
    func levelOrderTraversal(_ root: Node?, process: (Node) -> Void) {
        guard let root else {
            return
        }

        var queue = [root]
        while !queue.isEmpty {
            for _ in 0..<queue.count {
                let current = queue.removeFirst()
                process(current)

                if let left = current.left {
                    queue += [left]
                }

                if let right = current.right {
                    queue += [right]
                }
            }
        }
    }
}
