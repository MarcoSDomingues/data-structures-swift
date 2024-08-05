//
//  QuickSelectTests.swift
//
//
//  Created by Marco Domingues on 05/08/2024.
//

import XCTest
import Foundation
@testable import Algorithms

final class QuickSelectTests: XCTestCase {
    func test_quickSelectKthSmallest_whenArrayIsEmpty_itShouldReturnNil() {
        var array: [Int] = []

        let element = array.quickSelectKthSmallest(0)

        XCTAssertNil(element)
    }

    func test_quickSelectKthSmallest_whenKIsOutOfBounds_itShouldReturnNil() {
        var array: [Int] = [1]

        var element = array.quickSelectKthSmallest(2)
        XCTAssertNil(element)

        element = array.quickSelectKthSmallest(-1)
        XCTAssertNil(element)
    }

    func test_quickSelectKthSmallest_selectes_2ndSmallestElementOfUnsortedArray() {
        var array = [2, 5, 1, 3]
        let k = 2

        let element = array.quickSelectKthSmallest(k)

        XCTAssertEqual(element, 2)
    }

    func test_quickSelectKthSmallest_selectes_2ndSmallestElementOfSortedArray() {
        var array = [1, 2, 3, 5]
        let k = 2

        let element = array.quickSelectKthSmallest(k)

        XCTAssertEqual(element, 2)
    }

    func test_quickSelectKthLargest_whenArrayIsEmpty_itShouldReturnNil() {
        var array: [Int] = []

        let element = array.quickSelectKthLargest(0)

        XCTAssertNil(element)
    }

    func test_quickSelectKthLargest_whenKIsOutOfBounds_itShouldReturnNil() {
        var array: [Int] = [1]

        var element = array.quickSelectKthLargest(2)
        XCTAssertNil(element)

        element = array.quickSelectKthLargest(-1)
        XCTAssertNil(element)
    }

    func test_quickSelectKthLargest_selectes_2ndLargestElementOfUnsortedArray() {
        var array = [2, 5, 1, 3]
        let k = 2

        let element = array.quickSelectKthLargest(k)

        XCTAssertEqual(element, 3)
    }

    func test_quickSelectKthLargest_selectes_2ndLargestElementOfSortedArray() {
        var array = [1, 2, 3, 5]
        let k = 2

        let element = array.quickSelectKthLargest(k)

        XCTAssertEqual(element, 3)
    }
}
