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

    func test_invert_whenRootIsNotNil_itShouldInvertTreeNodes() {
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

    func test_invert_whenRootIsNil_itShouldReturnNilNode() {
        XCTAssertNil(sut.root)

        let actualNode = sut.invert()

        XCTAssertNil(actualNode)
    }

    func test_searchValue_whenRootIsNil_itShouldReturnNil() {
        XCTAssertNil(sut.root)

        let actualNode = sut.searchValue(2)

        XCTAssertNil(actualNode)
    }

    func test_searchValue_whenValueIsNotInTree_itShouldReturnNil() {
        [1, 3, 5].forEach { value in
            sut.insertValue(value)
        }

        let actualNode = sut.searchValue(2)

        XCTAssertNil(actualNode)
    }

    func test_searchValue_whenValueIsInTree_itShouldReturnNode() {
        [1, 3, 5].forEach { value in
            sut.insertValue(value)
        }

        let actualNode = sut.searchValue(3)

        XCTAssertEqual(actualNode?.value, 3)
    }

    func test_deleteValue_whenRootIsNil_itShouldReturnNil() {
        XCTAssertNil(sut.root)

        let actualNode = sut.deleteValue(3)

        XCTAssertNil(actualNode)
    }

    func test_deleteValue_whenValueIsNotInTree_itShouldReturnSameTree() {
        [1, 3, 5].forEach { value in
            sut.insertValue(value)
        }

        let actualRoot = sut.deleteValue(2)

        var preOrderTraversal: [String] = []
        sut.preOrderTraversal(actualRoot) { node in
            preOrderTraversal += [String(node.value)]
        }

        XCTAssertEqual(preOrderTraversal.joined(separator: ", "), "1, 3, 5")
    }

    /// Delete node and replace with deepest and rightmost node
    func test_deleteValue_whenValueIsInTree_itShouldDeleteNodeWithValue() {
        [1, 3, 5].forEach { value in
            sut.insertValue(value)
        }

        let actualRoot = sut.deleteValue(1)

        var preOrderTraversal: [String] = []
        sut.preOrderTraversal(actualRoot) { node in
            preOrderTraversal += [String(node.value)]
        }

        XCTAssertEqual(preOrderTraversal.joined(separator: ", "), "5, 3")
    }

    func test_deleteValue_whenTreeOnlyContainsValue_itShouldReturnEmptyTree() {
        sut.insertValue(1)

        let actualRoot = sut.deleteValue(1)

        XCTAssertNil(actualRoot)
    }

    func test_maximumDepth_whenTreeIsEmpty_itShouldReturnZero() {
        let maximumDepth = sut.maximumDepth()

        XCTAssertEqual(maximumDepth, 0)
    }

    func test_maximumDepth_itShouldReturnNumberOfNodesAlongTheLongestPathFromRootDownToFarthestLeaf() {
        [3, 9, 20, 15, 7].forEach { value in
            sut.insertValue(value)
        }

        let maximumDepth = sut.maximumDepth()

        XCTAssertEqual(maximumDepth, 3)
    }

    func test_isSameTree_whenBothTreesAreEmpty_itShouldReturnTrue() {
        let other: BinaryTree<Int> = BinaryTree(root: nil)

        let isSameTree = sut.isSameTree(other)

        XCTAssertEqual(isSameTree, true)
    }

    func test_isSameTree_whenOtherTreeIsEmpty_itShouldReturnFalse() {
        let other: BinaryTree<Int> = BinaryTree(root: nil)
        sut.insertValue(1)

        let isSameTree = sut.isSameTree(other)

        XCTAssertEqual(isSameTree, false)
    }

    func test_isSameTree_whenTreeIsEmpty_itShouldReturnFalse() {
        let other = BinaryTree(root: BinaryTree.Node(value: 1))
        other.insertValue(1)

        let isSameTree = sut.isSameTree(other)

        XCTAssertEqual(isSameTree, false)
    }

    func test_isSameTree_whenTreesHaveSameStructureAndSameValueNodes_itShouldReturnTrue() {
        let other: BinaryTree<Int> = BinaryTree(root: nil)
        [2, 1, 4, 5, 1, 8].forEach { value in
            sut.insertValue(value)
            other.insertValue(value)
        }

        let isSameTree = sut.isSameTree(other)

        XCTAssertEqual(isSameTree, true)
    }

    func test_isSameTree_whenTreesHaveSameStructureAndDifferentValueNodes_itShouldReturnFalse() {
        let other: BinaryTree<Int> = BinaryTree(root: nil)
        [2, 1, 4].forEach { value in
            sut.insertValue(value)
        }
        [2, 1, 3].forEach { value in
            other.insertValue(value)
        }

        let isSameTree = sut.isSameTree(other)

        XCTAssertEqual(isSameTree, false)
    }

    func test_isSameTree_whenTreesHaveDifferentLeftSubTreeStructure_itShouldReturnFalse() {
        sut = BinaryTree(root: BinaryTree.Node(value: 1))
        let other = BinaryTree(root: BinaryTree.Node(value: 1))
        sut.root?.left = BinaryTree.Node(value: 3)

        let isSameTree = sut.isSameTree(other)

        XCTAssertEqual(isSameTree, false)
    }

    func test_isSameTree_whenTreesHaveDifferentRightSubTreeStructure_itShouldReturnFalse() {
        sut = BinaryTree(root: BinaryTree.Node(value: 1))
        let other = BinaryTree(root: BinaryTree.Node(value: 1))
        sut.root?.right = BinaryTree.Node(value: 3)

        let isSameTree = sut.isSameTree(other)

        XCTAssertEqual(isSameTree, false)
    }
}

extension BinaryTree.Node: Equatable where T: Equatable {
    public static func ==(lhs: BinaryTree.Node, rhs: BinaryTree.Node) -> Bool {
        lhs.value == rhs.value && lhs.left == rhs.left && lhs.right == rhs.right && lhs.count == rhs.count
    }
}
