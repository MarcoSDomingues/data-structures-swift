//
//  BinaryTreeNode.swift
//
//
//  Created by Marco Domingues on 07/06/2024.
//

import Foundation

public protocol BinaryTreeNode {
    associatedtype Value

    var value: Value { get set }
    var left: Self? { get set }
    var right: Self? { get set }
    var count: Int { get }
}
