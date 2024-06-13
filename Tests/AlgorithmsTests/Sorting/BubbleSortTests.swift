//
//  BubbleSortTests.swift
//  
//
//  Created by Marco Domingues on 12/06/2024.
//

import XCTest
@testable import Algorithms

final class BubbleSortTests: XCTestCase {
    func test_bubbleSort_sortsArrayInPlace() {
        var array = [3, 5, 1, 2]

        array.bubbleSort()

        XCTAssertEqual(array, [1, 2, 3, 5])
    }

    func test_bubbleSort_whenArrayIsAlreadySorted() {
        var array = [1, 2, 3, 5]

        array.bubbleSort()

        XCTAssertEqual(array, [1, 2, 3, 5])
    }

    func test_bubbleSort_whenArrayHasNegativeNumbers() {
        var array = [1, 5, -3, -6, 10]

        array.bubbleSort()

        XCTAssertEqual(array, [-6, -3, 1, 5, 10])
    }

    func test_bubbleSort_whenArrayIsEmpty() {
        var array: [Int] = []

        array.bubbleSort()

        XCTAssertEqual(array, [])
    }

    func test_bubbleSorted_shouldReturnSortedCopyOfArray() {
        let array = [3, 5, 1, 2]

        let sorted = array.bubbleSorted()

        XCTAssertEqual(array, [3, 5, 1, 2])
        XCTAssertEqual(sorted, [1, 2, 3, 5])
    }
}
