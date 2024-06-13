//
//  CountingSortTests.swift
//
//
//  Created by Marco Domingues on 13/06/2024.
//

import Foundation
import XCTest
@testable import Algorithms

final class CountingSortTests: XCTestCase {
    func test_countingSort_sortsArrayInPlace() {
        var array = [3, 5, 1, 2]

        array.countingSort()

        XCTAssertEqual(array, [1, 2, 3, 5])
    }

    func test_countingSort_whenArrayIsAlreadySorted() {
        var array = [1, 2, 3, 5]

        array.countingSort()

        XCTAssertEqual(array, [1, 2, 3, 5])
    }

    func test_countingSort_whenArrayHasNegativeNumbers() {
        var array = [1, 5, -3, -6, 10]

        array.countingSort()

        XCTAssertEqual(array, [-6, -3, 1, 5, 10])
    }

    func test_countingSort_whenArrayIsEmpty() {
        var array: [Int] = []

        array.countingSort()

        XCTAssertEqual(array, [])
    }

    func test_countingSorted_shouldReturnSortedCopyOfArray() {
        let array = [3, 5, 1, 2]

        let sorted = array.countingSorted()

        XCTAssertEqual(array, [3, 5, 1, 2])
        XCTAssertEqual(sorted, [1, 2, 3, 5])
    }
}
