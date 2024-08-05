//
//  QuickSelect.swift
//
//
//  Created by Marco Domingues on 05/08/2024.
//

import Foundation

extension Array where Element: Comparable {
    mutating func quickSelectKthSmallest(_ k: Int) -> Element? {
        quickSelect(k - 1)
    }

    mutating func quickSelectKthLargest(_ k: Int) -> Element? {
        quickSelect(count - k)
    }

    private mutating func quickSelect(_ k: Int) -> Element? {
        let count = self.count
        guard !isEmpty, k >= 0, k < count else {
            return nil
        }

        quickSelect(left: 0, right: count - 1, k: k)
        return self[k]
    }

    private mutating func quickSelect(left: Int, right: Int, k: Int) {
        if left >= right {
            return
        }

        let pivotIndex = partition(left: left, right: right)

        if k == pivotIndex {
            return
        } else if k < pivotIndex {
            quickSelect(left: left, right: pivotIndex - 1, k: k)
        } else {
            quickSelect(left: pivotIndex + 1, right: right, k: k)
        }
    }

    /// Returns pivot index
    private mutating func partition(left: Int, right: Int) -> Int {
        let pivotIndex = Int.random(in: left...right)
        let pivotValue = self[pivotIndex]
        self.swapAt(pivotIndex, right)

        var index = left
        for i in left..<right {
            if self[i] < pivotValue {
                self.swapAt(i, index)
                index += 1
            }
        }

        self.swapAt(index, right)
        return index
    }
}
