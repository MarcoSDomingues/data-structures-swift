//
//  BinaryTreeTests.swift
//
//
//  Created by Marco Domingues on 06/06/2024.
//

import XCTest
import Foundation
@testable import DataStructures

final class BinaryTreeTests: XCTestCase {
    private var sut: BinaryTree<Int>!

    override func setUp() {
        super.setUp()

        sut = BinaryTree(root: nil)
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func test_insertNode_whenRootIsNil_itShouldInsertNodeAsRoot() {
        let expectedRoot = BinaryTree.Node(value: 3)

        sut.insertNode(expectedRoot)

        XCTAssertEqual(sut.root, expectedRoot)
    }

    func test_insertNode_whenRootIsNotNil_itShouldInsertNodeAsLeftChild() {
        let root = BinaryTree.Node(value: 3)
        let expectedLeftNode = BinaryTree.Node(value: 5)

        sut.insertNode(root)
        sut.insertNode(expectedLeftNode)

        XCTAssertEqual(sut.root, root)
        XCTAssertEqual(root.left, expectedLeftNode)
    }

    func test_insertNode_whenRootAndLeftIsNotNil_itShouldInsertNodeAsRightChild() {
        let root = BinaryTree.Node(value: 3, left: BinaryTree.Node(value: 5))
        let expectedRightNode = BinaryTree.Node(value: 1)

        sut.insertNode(root)
        sut.insertNode(expectedRightNode)

        XCTAssertEqual(sut.root, root)
        XCTAssertEqual(root.right, expectedRightNode)
    }

    func test_insertNodes_countShouldBe9() {
        [1, 7, 9, 2, 6, 9, 5, 11, 5].forEach { value in
            sut.insertNode(BinaryTree.Node(value: value))
        }

        XCTAssertEqual(sut.root?.count, 9)
    }

    func test_insertValues_countShouldBe9() {
        [1, 7, 9, 2, 6, 9, 5, 11, 5].forEach { value in
            sut.insertValue(value)
        }

        XCTAssertEqual(sut.root?.count, 9)
    }

    func test_inOrderTraversal_itShouldTraverse_fromLeft_toRoot_andRight() {
        [1, 7, 9, 2, 6, 9, 5, 11, 5].forEach { value in
            sut.insertValue(value)
        }

        var inOrderTraversal: [String] = []
        sut.inOrderTraversal(sut.root) { node in
            inOrderTraversal += [String(node.value)]
        }

        XCTAssertEqual(inOrderTraversal.joined(separator: ", "), "11, 2, 5, 7, 6, 1, 9, 9, 5")
    }

    func test_preOrderTraversal_itShouldTraverse_fromRoot_toLeft_andRight() {
        [1, 7, 9, 2, 6, 9, 5, 11, 5].forEach { value in
            sut.insertValue(value)
        }

        var preOrderTraversal: [String] = []
        sut.preOrderTraversal(sut.root) { node in
            preOrderTraversal += [String(node.value)]
        }

        Character("a").asciiValue! - 

        XCTAssertEqual(preOrderTraversal.joined(separator: ", "), "1, 7, 2, 11, 5, 6, 9, 9, 5")
    }

    func test_postOrderTraversal_itShouldTraverse_fromLeft_toRight_andRoot() {
        [1, 7, 9, 2, 6, 9, 5, 11, 5].forEach { value in
            sut.insertValue(value)
        }

        var postOrderTraversal: [String] = []
        sut.postOrderTraversal(sut.root) { node in
            postOrderTraversal += [String(node.value)]
        }

        XCTAssertEqual(postOrderTraversal.joined(separator: ", "), "11, 5, 2, 6, 7, 9, 5, 9, 1")
    }

    func test_invert_itShouldInvertTreeNodes() {
        [1, 7, 9, 2, 6, 9, 5, 11, 5].forEach { value in
            sut.insertValue(value)
        }

        var inOrderTraversal: [String] = []
        sut.inOrderTraversal(sut.root) { node in
            inOrderTraversal += [String(node.value)]
        }

        XCTAssertEqual(inOrderTraversal.joined(separator: ", "), "11, 2, 5, 7, 6, 1, 9, 9, 5")

        sut.invert()

        inOrderTraversal = []
        sut.inOrderTraversal(sut.root) { node in
            inOrderTraversal += [String(node.value)]
        }

        XCTAssertEqual(inOrderTraversal.joined(separator: ", "), "5, 9, 9, 1, 6, 7, 5, 2, 11")
    }
}

extension BinaryTree.Node: Equatable where T: Equatable {
    public static func ==(lhs: BinaryTree.Node, rhs: BinaryTree.Node) -> Bool {
        lhs.value == rhs.value && lhs.left == rhs.left && lhs.right == rhs.right && lhs.count == rhs.count
    }
}
