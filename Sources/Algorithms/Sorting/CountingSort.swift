//
//  CountingSort.swift
//
//
//  Created by Marco Domingues on 13/06/2024.
//

import Foundation

extension Array where Element == Int {
    mutating func countingSort() {
        self = self.countingSorted()
    }

    func countingSorted() -> [Element] {
        guard
            let maximum = self.max(),
            let minimum = self.min()
        else {
            return self
        }

        let auxiliaryArraysSize = maximum - minimum + 1

        // Calculate frequency of each number in the array to be sorted
        var frequency = Array(repeating: 0, count: auxiliaryArraysSize)
        for element in self {
            frequency[element - minimum] += 1
        }

        // Calculate starting indexes of each element in the final sorted array
        var startingIndex = 0
        var startingIndexes = Array(repeating: 0, count: auxiliaryArraysSize)
        for (i, frequency) in frequency.enumerated() {
            startingIndexes[i] = startingIndex
            startingIndex += frequency
        }

        var sorted = Array(repeating: 0, count: self.count)
        for element in self {
            sorted[startingIndexes[element - minimum]] = element

            /*
             Since we have placed an item in index startingIndexed[element], we need to
             increment startingIndexed[element] index by 1 so the next duplicate element
             is placed in appropriate index
             */
            startingIndexes[element - minimum] += 1
        }

        return sorted
    }
}
